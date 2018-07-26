const Market = artifacts.require('./Market.sol')
const Vault = artifacts.require('./Vault.sol')
const Cellar = artifacts.require('./lib/Cellar.sol')
const MarketEvents = artifacts.require('./lib/MarketEvents.sol')
const EIP20 = artifacts.require("./lib/EIP20.sol")

module.exports = function(deployer) {
  Promise.all([
    deployer.deploy(Market, "0x18e36dc3bA1456455FF8102F6d2CF5E91064D7f7"),
  ])
}