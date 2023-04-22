import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    localhost: {
      url: "http://localhost:8545",
    },
    polygon_mumbai: {
      url: " https://polygon-mumbai.g.alchemy.com/v2/Co2EgtLv5g3mtN_fbUD63rF3DfWvykmx",
      accounts: [
        "0x$(b732490637cfe5a092a3ab3ebfdabec58213f02ce6cfcb97db954d3595183ca5)",
      ],
    },
  },
};

export default config;
