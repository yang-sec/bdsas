# BD-SAS

BD-SAS is a blockchain-based decentralized spectrum access system (SAS) designed to enable dynamic spectrum sharing (DSS). It decentralizes the current SAS as has been deployed for the CBRS band and achieves (1) fault tolerance to individual SAS server failures and (2) automatic synchronization of spectrum allocations.

# G-Chain Emulation
G-Chain contract source code: contracts/G-Chain_Regulate.sol

We use the Ethereum Rinkeby testnet for emulating G-Chain. Deployed G-Chain contract: https://rinkeby.etherscan.io/address/0xDBd97d9d6e61dB19e3Dd0eAfcaF132507BEC1098

# L-Chain Prototypes
L-Chain test network source code: fabric-lchain-networks/

## How to Instantiate an L-Chain test network
1. Follow https://hyperledger-fabric.readthedocs.io/en/latest/getting_started_run_fabric.html to install and test run Hyperledger Fabric
2. cd into one of the test networks directories in fabric-lchain-networks/
3. Run "test.sh"
4. (Optional) Run "./addDelay.sh" to simulate delays between nodes
5. **Test with Hyperledger Caliper**
6. When ending the test, run "./delDelay.sh" and then "./network.sh down" 

## Test with Hyperledger Caliper
After Step 3 (or 4) of the above:
1. cd into the caliper-workspace/ directory
2. Edit networks/networkConfig.yaml for the corresponding test network name
3. Run the following command to get the benchmark results (please be patient, it can be a 3-minute wait):
```
npx caliper launch manager --caliper-workspace ./ --caliper-networkconfig networks/networkConfig.yaml --caliper-benchconfig benchmarks/SpectrumAccessBenchmark_Access.yaml --caliper-flow-only-test --caliper-fabric-gateway-enabled
```
4. To test with different benchmark settings, replace "SpectrumAccessBenchmark_Access.yaml" with the existing benchmark files in the benchmarks directory or your own benchmark files.
