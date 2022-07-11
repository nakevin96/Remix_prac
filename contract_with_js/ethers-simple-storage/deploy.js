// solidity is synchronous programming language
// javajscript can do asynchronous job

async function main() {
  // deploy a contract? wait for it to be deployed
  // contract.deploy => wouldn't wait for it to finish
  // complie contract in our code
  // and complie them separately : yarn solcjs --bin --abi --iniclude-path node_modules/ --base-path . -o . SimpleStorage.sol
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
