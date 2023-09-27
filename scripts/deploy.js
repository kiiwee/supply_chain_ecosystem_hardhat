// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
// const ethernal = require('hardhat-ethernal');

async function main() {

  const Token = await hre.ethers.getContractFactory("MyToken");
  const token = await Token.deploy();

  await token.waitForDeployment();

  console.log(
    token.runner.address
  );
  // await hre.ethernal.push({
  //   name: 'MyToken',
  //   address: token.runner.address,
  // });
}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;

});
