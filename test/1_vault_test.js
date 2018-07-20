const Vault = artifacts.require('Vault.sol')
const Market = artifacts.require('Market.sol')
const EIP20 = artifacts.require('Token/EIP20.sol')
const gasPrice = 6000029

contract('Market', (accounts) => {
  it('should deploy a Market', async () => {
    const token_instance = await EIP20.new(1000, "TEST", 1, "TEST")
    const instance = await Market.new(token_instance.address)
    if (instance.address === undefined) throw new Error('deployment failed')
  })
    
  it('should deploy a Market', async () => {
    const token_instance = await EIP20.new(1000, "TEST", 1, "TEST")
    const instance = await Market.new(token_instance.address)
    if (instance.address === undefined) throw new Error('deployment failed')
  })
})