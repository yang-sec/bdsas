export MEAN_DELAY=50
export JITTER=0
docker exec orderer1.example.com apk add iproute2
docker exec orderer2.example.com apk add iproute2
docker exec orderer3.example.com apk add iproute2
docker exec orderer4.example.com apk add iproute2
docker exec orderer5.example.com apk add iproute2
docker exec peer0.org1.example.com apk add iproute2
docker exec peer0.org2.example.com apk add iproute2
docker exec peer0.org3.example.com apk add iproute2
docker exec peer0.org4.example.com apk add iproute2
docker exec peer0.org5.example.com apk add iproute2
docker exec peer0.org6.example.com apk add iproute2
docker exec peer0.org7.example.com apk add iproute2
docker exec peer0.org8.example.com apk add iproute2
docker exec peer0.org9.example.com apk add iproute2
docker exec cli apk add iproute2
docker exec orderer1.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec orderer2.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec orderer3.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec orderer4.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec orderer5.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org1.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org2.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org3.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org4.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org5.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org6.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org7.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms
docker exec peer0.org8.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
docker exec peer0.org9.example.com tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms
docker exec cli tc qdisc add dev eth0 root netem delay ${MEAN_DELAY}ms ${JITTER}ms 
