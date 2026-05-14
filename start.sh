#!/bin/bash

# Generate wallet if not provided
if [ -z "$WALLET_ADDRESS" ]; then
  echo "Generating new Monero wallet..."
  /monero/monero-wallet-cli --generate-new-wallet /tmp/wallet --password "" --mnemonic-language English --restore-height 0 --command "address;exit" | grep "Address:" | awk '{print $2}' > /tmp/wallet_address.txt
  WALLET=$(cat /tmp/wallet_address.txt)
  echo "Generated wallet address: $WALLET"
else
  WALLET=$WALLET_ADDRESS
fi

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