docker exec orderer1.example.com tc qdisc del dev eth0 root netem
docker exec peer0.org1.example.com tc qdisc del dev eth0 root netem
docker exec peer0.org2.example.com tc qdisc del dev eth0 root netem
docker exec peer0.org3.example.com tc qdisc del dev eth0 root netem
docker exec peer0.org4.example.com tc qdisc del dev eth0 root netem
docker exec cli tc qdisc del dev eth0 root netem