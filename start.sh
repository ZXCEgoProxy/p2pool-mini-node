#!/bin/bash

# Set wallet address (use provided or default)
WALLET=${WALLET_ADDRESS:-"4AL6QjWtF4RCyPzPT7Ew3khPuqhmcJC9BQe9Cpxvv3noevJyp23YLTySZpHzWZyb1EEcGd8FRurTpWjcQmdJJgxzUYSFyBC"}

# Start Monero daemon (pruned for lower disk usage)
echo "Starting Monero daemon..."
/monero/monerod --zmq-pub tcp://127.0.0.1:18083 --out-peers 8 --in-peers 16 --add-priority-node=p2pmd.xmrvsbeast.com:18080 --add-priority-node=nodes.hashvault.pro:18080 --enforce-dns-checkpointing --enable-dns-blocklist --prune-blockchain --detach --non-interactive --log-file /dev/stdout

# Wait a bit for monerod to start
sleep 30

# Start P2Pool (light mode for lower RAM usage)
echo "Starting P2Pool..."
/p2pool/p2pool --host 127.0.0.1 --wallet $WALLET --mini --light-mode </dev/null &

# Keep the container running
wait