# P2Pool Mini Node

This project sets up a P2Pool mini node with a Monero daemon for decentralized mining.

## Prerequisites

- A Monero wallet address that supports P2Pool (see https://p2pool.io/mini/#help for supported wallets)
- Railway account for deployment

## Deployment on Railway

1. Fork or clone this repository.
2. Connect your GitHub repository to Railway.
3. In Railway dashboard, go to Variables and add `WALLET_ADDRESS` with your Monero wallet address (e.g., 4AL6QjWtF4RCyPzPT7Ew3khPuqhmcJC9BQe9Cpxvv3noevJyp23YLTySZpHzWZyb1EEcGd8FRurTpWjcQmdJJgxzUYSFyBC).
4. Deploy the project. Railway will build the Docker image and run the services.

## Services

- **Monero Daemon (monerod)**: Runs on port 18080, synchronizes the Monero blockchain.
- **P2Pool**: Runs on ports 37888 (P2P) and 3333 (Stratum for miners).

## Connecting Miners

Miners can connect to the P2Pool stratum server on port 3333 of your Railway deployment URL.

Example with XMRig:
```
./xmrig -o your-railway-url:3333
```

## Notes

- The Monero blockchain sync may take several hours to days on first run.
- Railway has storage limits; monitor usage as the blockchain grows.
- Ensure your wallet address is correct to avoid losing mining rewards.

## Support

Refer to https://p2pool.io/mini/#help for more information.