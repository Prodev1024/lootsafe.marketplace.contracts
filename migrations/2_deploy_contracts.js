const Market = artifacts.require('./Market.sol')
const Vault = artifacts.require('./Vault.sol')
const Cellar = artifacts.require('./lib/Cellar.sol')
const EIP20 = artifacts.require("./lib/EIP20.sol")

module.exports = function(deployer) {
  Promise.all([
    deployer.deploy(Market, "0xbF263D10291eb685eca7cf0108B51b94d8b4a41b"),
  ])
}