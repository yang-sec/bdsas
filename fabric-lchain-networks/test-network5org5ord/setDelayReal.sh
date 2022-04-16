docker exec peer0.org1.example.com apk add iproute2
docker exec peer0.org1.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec peer0.org1.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 26ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 25ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 32ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 27ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 6ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 6ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 6ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 6ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 6ms
docker exec peer0.org1.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 6ms
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:1
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:2
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:3
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:4
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:5
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:6
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:7
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec peer0.org1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec peer0.org2.example.com apk add iproute2
docker exec peer0.org2.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec peer0.org2.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 26ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 11ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 10ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 11ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 31ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 31ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 31ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 31ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 31ms
docker exec peer0.org2.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 42ms
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:2
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:3
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:4
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:5
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:6
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:7
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec peer0.org2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec peer0.org3.example.com apk add iproute2
docker exec peer0.org3.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec peer0.org3.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 25ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 11ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 21ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 21ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 34ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 34ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 34ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 34ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 34ms
docker exec peer0.org3.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 36ms
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:3
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:4
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:5
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:6
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:7
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec peer0.org3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec peer0.org4.example.com apk add iproute2
docker exec peer0.org4.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec peer0.org4.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 32ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 10ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 21ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 11ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 32ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 32ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 32ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 32ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 32ms
docker exec peer0.org4.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 38ms
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:4
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:5
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:6
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:7
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec peer0.org4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec peer0.org5.example.com apk add iproute2
docker exec peer0.org5.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec peer0.org5.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 27ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 11ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 21ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 11ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 27ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 27ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 27ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 27ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 27ms
docker exec peer0.org5.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 34ms
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:4
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:5
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:6
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:7
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec peer0.org5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec orderer1.example.com apk add iproute2
docker exec orderer1.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec orderer1.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 6ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 32ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 34ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 32ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 28ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 1ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 1ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 1ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 1ms
docker exec orderer1.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 2ms
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:4
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:5
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:6
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:7
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec orderer1.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec orderer2.example.com apk add iproute2
docker exec orderer2.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec orderer2.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 6ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 32ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 34ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 32ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 28ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 1ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 1ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 1ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 1ms
docker exec orderer2.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 2ms
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:4
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:5
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:6
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:7
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec orderer2.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec orderer3.example.com apk add iproute2
docker exec orderer3.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec orderer3.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 6ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 32ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 34ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 32ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 28ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 1ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 1ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 1ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 1ms
docker exec orderer3.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 2ms
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:4
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:5
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:6
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:7
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:8
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec orderer3.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec orderer4.example.com apk add iproute2
docker exec orderer4.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec orderer4.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 6ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 32ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 34ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 32ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 28ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 1ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 1ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 1ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 1ms
docker exec orderer4.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 2ms
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:4
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:5
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:6
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:7
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:8
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:9
docker exec orderer4.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec orderer5.example.com apk add iproute2
docker exec orderer5.example.com tc qdisc add dev eth0 root handle 1: htb default 10
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec orderer5.example.com tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 6ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 32ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 34ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 32ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 28ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 1ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 1ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 1ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 1ms
docker exec orderer5.example.com tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 2ms
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:4
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:5
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:6
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:7
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:8
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:9
docker exec orderer5.example.com tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.12 flowid 1:10

docker exec cli apk add iproute2
docker exec cli tc qdisc add dev eth0 root handle 1: htb default 10
docker exec cli tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:2 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:3 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:4 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:5 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:6 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:7 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:8 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:9 htb rate 10mbps
docker exec cli tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbps
docker exec cli tc qdisc add dev eth0 parent 1:1 handle 110: netem delay 6ms
docker exec cli tc qdisc add dev eth0 parent 1:2 handle 120: netem delay 42ms
docker exec cli tc qdisc add dev eth0 parent 1:3 handle 130: netem delay 36ms
docker exec cli tc qdisc add dev eth0 parent 1:4 handle 140: netem delay 38ms
docker exec cli tc qdisc add dev eth0 parent 1:5 handle 150: netem delay 34ms
docker exec cli tc qdisc add dev eth0 parent 1:6 handle 160: netem delay 2ms
docker exec cli tc qdisc add dev eth0 parent 1:7 handle 170: netem delay 2ms
docker exec cli tc qdisc add dev eth0 parent 1:8 handle 180: netem delay 2ms
docker exec cli tc qdisc add dev eth0 parent 1:9 handle 190: netem delay 2ms
docker exec cli tc qdisc add dev eth0 parent 1:10 handle 200: netem delay 2ms
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.5 flowid 1:1
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.11 flowid 1:2
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.9 flowid 1:3
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.4 flowid 1:4
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.8 flowid 1:5
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.3 flowid 1:6
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.7 flowid 1:7
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.6 flowid 1:8
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.10 flowid 1:9
docker exec cli tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 192.168.16.2 flowid 1:10

