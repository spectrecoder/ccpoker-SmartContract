const { SignerWithAddress } = require("@nomiclabs/hardhat-ethers/signers");
const { ethers } = require("hardhat");
const {
  DecryptVerifier__factory,
  Shuffle_encryptVerifier__factory,
  ShuffleManager__factory,
  Test__factory,
} = require("../types/types.ts");

// Depploys contract for decryption.
async function deployDecrypt() {
  return await new DecryptVerifier__factory().deploy();
}

// Deploys contract for shuffle encrypt.
async function deployShuffleEncrypt() {
  return await new Shuffle_encryptVerifier__factory().deploy();
}

export async function deploy_shuffle_manager() {
  const encrypt52 = await deployShuffleEncrypt();
  const decrypt = await deployDecrypt();

  const crypto = await (await ethers.getContractFactory("zkShuffleCrypto")).deploy();
  const sm = await (
    await ethers.getContractFactory("ShuffleManager", {
      libraries: {
        zkShuffleCrypto: crypto.address,
      },
    })
  ).deploy(decrypt.address, encrypt52.address);
  
  return sm;
}
