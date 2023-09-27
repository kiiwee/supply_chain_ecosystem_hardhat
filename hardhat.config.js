require("@nomicfoundation/hardhat-toolbox");
const INFURA_API_KEY = "KEY";



/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/ySdMukKcnxVHHhXe43KiAZUIxyXRN02i`,
      accounts: ["d73ed619c765d64d75295ea829c1056c3683d0090d607e177a27d7970cedbd18"]
    }
  },
  // ethernal: {
  //   apiToken: process.env.ETHERNAL_API_TOKEN,
  //   email: "i.stoev@icloud.com",
  //   password: "riVruv-tiwwab-cecgu9"
  // }
};
