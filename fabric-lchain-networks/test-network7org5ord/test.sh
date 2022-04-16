# Set up network
./network.sh up createChannel

# Instate chaincode
./network.sh deployCC -ccn basic -ccp ../spectrum-access/chaincode-go -ccl go -ccep "OutOf(4,'Org1MSP.member','Org2MSP.member','Org3MSP.member','Org4MSP.member','Org5MSP.member','Org6MSP.member','Org7MSP.member')"

# Environment variables
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

# Environment variables for Org1
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

# Init ledger
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer1.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:8051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" --peerAddresses localhost:11051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt" --peerAddresses localhost:12051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt" --peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt" --peerAddresses localhost:14051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/ca.crt" --peerAddresses localhost:15051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org7.example.com/peers/peer0.org7.example.com/tls/ca.crt" -c '{"function":"InitLedger","Args":[]}'
# Test query
peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssignments"]}'

