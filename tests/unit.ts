const { expect } = require("chai");
const { tx_to_contract } = require("./utility");

describe("ZKShuffle Unit Test", function () {
  this.timeout(6000000);

  async function deployTokenFixture() {
    const [owner, addr1, addr2] = await ethers.getSigners();
    const encryptVerifierContract = await ethers.getContractFactory("Groth16EncryptVerifier");
    const encryptVerifier = await encryptVerifierContract.deploy();

    const decryptVerifierContract = await ethers.getContractFactory("Groth16DecryptVerifier");
    const decryptVerifier = await decryptVerifierContract.deploy();
    
    const Poker = await ethers.getContractFactory("Poker")
    const poker = await Poker.deploy(await decryptVerifier.getAddress(), await encryptVerifier.getAddress());
    return { poker, owner, addr1, addr2 };
  }

  it("Deploy Shuffle Manager", async () => {
    
  });

});
