#!/bin/bash

# Set wallet address (use provided or default)
WALLET=${WALLET_ADDRESS:-"4AL6QjWtF4RCyPzPT7Ew3khPuqhmcJC9BQe9Cpxvv3noevJyp23YLTySZpHzWZyb1EEcGd8FRurTpWjcQmdJJgxzUYSFyBC"}

# Start Monero daemon
echo "Starting Monero daemon..."
/monero/monerod --zmq-pub tcp://127.0.0.1:18083 --out-peers 32 --in-peers 64 --add-priority-node=p2pmd.xmrvsbeast.com:18080 --add-priority-node=nodes.hashvault.pro:18080 --enforce-dns-checkpointing --enable-dns-blocklist </dev/null &

# Wait a bit for monerod to start
sleep 30

# Start P2Pool
echo "Starting P2Pool..."
/p2pool/p2pool --host 127.0.0.1 --wallet $WALLET --mini </dev/null &

# Keep the container running
wait