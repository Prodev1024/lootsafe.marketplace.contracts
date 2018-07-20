const Vault = artifacts.require('Vault.sol');
const Market = artifacts.require('Market.sol');
const EIP20 = artifacts.require('lib/EIP20.sol');
const { expectThrow } = require('./tools/expectThrow');
const gasPrice = 6000029;

contract('Market', (accounts) => {
    it('should deploy a Market', async () => {
       const token_instance = await EIP20.new(1000, "TEST", 1, "TEST");
       const instance = await Market.new(token_instance.address);
       if (instance.address === undefined) throw new Error('deployment of market failed');
    });

    it('should create a vault', async () => {
       const token = await EIP20.new(1000, "TEST", 1, "TEST");
       const market = await Market.new(token.address);

       await market.send(0, {from: accounts[1], gas: gasPrice});

       const vault = await market.my_vault();
       if (vault === undefined) throw new Error('Vault not created');
       if (market.address === undefined) throw new Error('deployment of market failed');
    });

    it('Should check balance of Vault', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const market = await Market.new(token.address);

        await market.send(0, {gas: gasPrice});
        const vault = await market.my_vault();

        await token.transfer(vault, 1);

        const truthy_vault_balance = await Vault.at(vault).has_balance.call(token.address, 1);
        const falsy_vault_balance = await Vault.at(vault).has_balance.call(token.address, 2);

        if (!truthy_vault_balance) throw new Error('Vault not displaying correct truthy has balance');
        if (falsy_vault_balance) throw new Error('Vault not displaying correct falsy has balance');
    });

    it('Should lock assets in the Vault', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        await market.send(0, {gas: gasPrice});
        const vault = await market.my_vault.call();
        await sword.transfer(vault, 2);
        await market.create_listing(sword.address, 1, 10);
        await Vault.at(vault).withdrawal(sword.address, 1);
        const userbal = await sword.balanceOf.call(accounts[0]);
        if (userbal.toString() != '999') throw new Error('Unlocked withdraw is broken');
        await expectThrow(Vault.at(vault).withdrawal(sword.address, 1));
    });

    it('Should unlock assets in the Vault', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        await market.send(0, {gas: gasPrice});
        const vault = await market.my_vault.call();
        await sword.transfer(vault, 1);
        await market.create_listing(sword.address, 1, 10);
        await expectThrow(Vault.at(vault).withdrawal(sword.address, 1));
        await market.cancel_listing(0);
        await Vault.at(vault).withdrawal(sword.address, 1);
        const vault_balance = await Vault.at(vault).has_balance.call(sword.address, 1);
        const merchant_balance = await sword.balanceOf.call(accounts[0]);
        if (vault_balance) throw new Error('Vault didnt unlock funds');
        if (merchant_balance.toString() != '1000') throw new Error('Merchant didnt get funds back');
    });
});