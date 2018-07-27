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

    it('should create and fetch a vault', async () => {
       const token = await EIP20.new(1000, "TEST", 1, "TEST");
       const market = await Market.new(token.address);

       await market.send(0, {from: accounts[1], gas: gasPrice});
       expectThrow(market.send(1, {from: accounts[1], gas: gasPrice}));
       expectThrow(market.send(0, {from: accounts[1], gas: gasPrice}));
       const vault = await market.vaults.call(accounts[1]);
       if (vault === undefined) throw new Error('Vault not created');
       if (market.address === undefined) throw new Error('deployment of market failed');
    });

    it('Should create a listing', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        await market.send(0, {gas: gasPrice});
        const vault = await market.vaults.call(accounts[0]);
        await sword.transfer(vault, 2);
        await market.create_listing(sword.address, 1, 10);
        const listing = await market.listings.call(0);
        if (listing[1].toString() == '0') throw new Error('Listing not created');
    });

    it('Should throw when creating a listing with no vault', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        expectThrow(market.create_listing(sword.address, 1, 10));
    });

    it('Should throw when there is not enough stuff to create a listing', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        await market.send(0, {gas: gasPrice});
        const vault = await market.vaults.call(accounts[0]);
        expectThrow(market.create_listing(sword.address, 1, 10));
    });

    it('Should cancel a listing', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        await market.send(0, {gas: gasPrice});
        const vault = await market.vaults.call(accounts[0]);
        await sword.transfer(vault, 2);
        await market.create_listing(sword.address, 1, 10);
        const listing = await market.listings.call(0);
        expectThrow(market.cancel_listing(1));
        expectThrow(market.cancel_listing(0, {from: accounts[1]}));
        await market.cancel_listing(0);
        if (listing[1].toString() == '0') throw new Error('Listing not created');
    });

    it('Should fulfill a listing', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        await market.send(0, {gas: gasPrice});
        const vault = await market.vaults.call(accounts[0]);
        await sword.transfer(vault, 2);
        await market.create_listing(sword.address, 1, 10);
        const listing = await market.listings.call(0);
        expectThrow(market.fulfill_listing(0, {from: accounts[1]}));
        await market.sendTransaction({from: accounts[1], value: 0, gas: gasPrice});
        const vault_1 = await market.vaults.call(accounts[1]);
        expectThrow(market.fulfill_listing(0, {from: accounts[1]}));
        await token.transfer(vault_1, 200);
        await market.fulfill_listing(0, {from: accounts[1]});
    })

    it('Should cancel a listing', async () => {
        const token = await EIP20.new(1000, "TEST", 1, "TEST");
        const sword = await EIP20.new(1000, "SWOR", 1, "SWOR");
        const market = await Market.new(token.address);
        await market.send(0, {gas: gasPrice});
        const vault = await market.vaults.call(accounts[0]);
        await sword.transfer(vault, 2);
        await market.create_listing(sword.address, 1, 10);
        const listing = await market.listings.call(0);
        await market.cancel_listing(0);
    });
});