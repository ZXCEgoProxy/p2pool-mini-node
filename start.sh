#!/bin/bash

# Set wallet address (use provided or default)
WALLET=${WALLET_ADDRESS:-"4AL6QjWtF4RCyPzPT7Ew3khPuqhmcJC9BQe9Cpxvv3noevJyp23YLTySZpHzWZyb1EEcGd8FRurTpWjcQmdJJgxzUYSFyBC"}

# Start Monero daemon (pruned for lower disk usage)
echo "Starting Monero daemon..."
/monero/monerod --zmq-pub tcp://127.0.0.1:18083 --out-peers 8 --in-peers 16 --add-priority-node=p2pmd.xmrvsbeast.com:18080 --add-priority-node=nodes.hashvault.pro:18080 --enforce-dns-checkpointing --enable-dns-blocklist --prune-blockchain --detach --non-interactive --log-file /dev/stdout

# Wait for monerod to start
sleep 30

# Wait for synchronization
echo "Waiting for Monero daemon to synchronize..."
while true; do
  height=$(curl -s http://127.0.0.1:18081/get_info | jq -r .height 2>/dev/null)
  target_height=$(curl -s http://127.0.0.1:18081/get_info | jq -r .target_height 2>/dev/null)
  synchronized=$(curl -s http://127.0.0.1:18081/get_info | jq -r .synchronized 2>/dev/null)
  if [ "$synchronized" = "true" ]; then
    echo "Monero daemon synchronized at height $height"
    break
  elif [ -n "$height" ] && [ -n "$target_height" ]; then
    progress=$((height * 100 / target_height))
    echo "Sync progress: $height / $target_height ($progress%)"
  else
    echo "Waiting for sync info..."
  fi
  sleep 60
done

# Start P2Pool
echo "Starting P2Pool..."
/p2pool/p2pool --host 127.0.0.1 --wallet $WALLET --mini --light-mode </dev/null &

# Keep the container running
wait