const hre = require('hardhat')

async function main() {
    const DNFT = await hre.ethers.getContractFactory("dynamicNFT")
    const dNft = await DNFT.deploy()

    await dNft.deployed()

    console.log('Deployed Address: ', dNft.address)
}

main().then(() => process.exit(0))
.catch(e => {
    console.log(e)
    process.exit(1)
})