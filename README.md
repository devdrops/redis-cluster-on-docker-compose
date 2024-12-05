# Redis cluster, on Docker Compose

References:

- https://medium.com/@jielim36/basic-docker-compose-and-build-a-redis-cluster-with-docker-compose-0313f063afb6

## Steps

1. `make create-conf`
2. `make run-redis`
3. `make create-cluster`
4. Run the command below:

```
redis-cli --cluster create 172.38.0.10:6379 172.38.0.11:6379 172.38.0.12:6379 172.38.0.13:6379 172.38.0.14:6379 172.38.0.15:6379 --cluster-replicas 1
```

Desired output:

```
>>> Performing hash slots allocation on 6 nodes...
Master[0] -> Slots 0 - 5460
Master[1] -> Slots 5461 - 10922
Master[2] -> Slots 10923 - 16383
Adding replica 172.38.0.14:6379 to 172.38.0.10:6379
Adding replica 172.38.0.15:6379 to 172.38.0.11:6379
Adding replica 172.38.0.13:6379 to 172.38.0.12:6379
M: 8496210cc05393aba980c36301793f0a87db2206 172.38.0.10:6379
   slots:[0-5460] (5461 slots) master
M: d472e69068b49964bb737166fb9c3f3205a547a7 172.38.0.11:6379
   slots:[5461-10922] (5462 slots) master
M: 6b23414e8560264783398bf7012f589a89c39ccb 172.38.0.12:6379
   slots:[10923-16383] (5461 slots) master
S: 50e1b650fead35868f94354611397f713230c3e9 172.38.0.13:6379
   replicates 6b23414e8560264783398bf7012f589a89c39ccb
S: f2e74deb146f600af805591b36250ad2c26afcc9 172.38.0.14:6379
   replicates 8496210cc05393aba980c36301793f0a87db2206
S: 20ab38e7959a797226bd13d89e61278d10c54d29 172.38.0.15:6379
   replicates d472e69068b49964bb737166fb9c3f3205a547a7
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
...
>>> Performing Cluster Check (using node 172.38.0.10:6379)
M: 8496210cc05393aba980c36301793f0a87db2206 172.38.0.10:6379
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
S: 20ab38e7959a797226bd13d89e61278d10c54d29 172.38.0.15:6379
   slots: (0 slots) slave
   replicates d472e69068b49964bb737166fb9c3f3205a547a7
S: f2e74deb146f600af805591b36250ad2c26afcc9 172.38.0.14:6379
   slots: (0 slots) slave
   replicates 8496210cc05393aba980c36301793f0a87db2206
S: 50e1b650fead35868f94354611397f713230c3e9 172.38.0.13:6379
   slots: (0 slots) slave
   replicates 6b23414e8560264783398bf7012f589a89c39ccb
M: 6b23414e8560264783398bf7012f589a89c39ccb 172.38.0.12:6379
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
M: d472e69068b49964bb737166fb9c3f3205a547a7 172.38.0.11:6379
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
```

5. Check status with the command below:

```
redis-cli -c
cluster nodes
```

Desired output:

```
20ab38e7959a797226bd13d89e61278d10c54d29 172.38.0.15:6379@16379 slave d472e69068b49964bb737166fb9c3f3205a547a7 0 1733419999728 2 connected
8496210cc05393aba980c36301793f0a87db2206 172.38.0.10:6379@16379 myself,master - 0 0 1 connected 0-5460
f2e74deb146f600af805591b36250ad2c26afcc9 172.38.0.14:6379@16379 slave 8496210cc05393aba980c36301793f0a87db2206 0 1733419998717 1 connected
50e1b650fead35868f94354611397f713230c3e9 172.38.0.13:6379@16379 slave 6b23414e8560264783398bf7012f589a89c39ccb 0 1733419999000 3 connected
6b23414e8560264783398bf7012f589a89c39ccb 172.38.0.12:6379@16379 master - 0 1733419998000 3 connected 10923-16383
d472e69068b49964bb737166fb9c3f3205a547a7 172.38.0.11:6379@16379 master - 0 1733419999526 2 connected 5461-10922
```
