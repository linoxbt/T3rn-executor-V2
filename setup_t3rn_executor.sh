#!/bin/bash

# Update and install necessary packages
echo "Updating system and installing dependencies..."
sudo apt update && sudo apt upgrade -y || { echo "Failed to update system"; exit 1; }
sudo apt install -y build-essential git screen wget || { echo "Failed to install packages"; exit 1; }

# Download and extract the latest executor binary
echo "Downloading and extracting T3rn executor..."
wget -q --show-progress https://github.com/t3rn/executor-release/releases/download/v0.53.1/executor-linux-v0.53.1.tar.gz || { echo "Download failed"; exit 1; }
tar -xvzf executor-linux-v0.53.1.tar.gz || { echo "Extraction failed"; exit 1; }
cd executor/executor/bin || { echo "Directory change failed"; exit 1; }

export ENVIRONMENT=testnet
export LOG_LEVEL=debug
export LOG_PRETTY=false

export EXECUTOR_PROCESS_BIDS_ENABLED=true
export EXECUTOR_PROCESS_ORDERS_ENABLED=true
export EXECUTOR_PROCESS_CLAIMS_ENABLED=true
export EXECUTOR_MAX_L3_GAS_PRICE=1000


export PRIVATE_KEY_LOCAL=

export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,optimism-sepolia,l2rn'

export NETWORKS_DISABLED='blast-sepolia,monad-testnet,unichain-sepolia,arbitrum,base,optimism'

export RPC_ENDPOINTS='{
    "l2rn": ["https://t3rn-b2n.blockpi.network/v1/rpc/public"],
    "arbt": ["https://arbitrum-sepolia.drpc.org/"],
    "bast": ["https://base-sepolia-rpc.publicnode.com/"],
    "opst": ["https://sepolia.optimism.io/"]
}'

export EXECUTOR_PROCESS_PENDING_ORDERS_FROM_API=false
export EXECUTOR_PROCESS_ORDERS_API_ENABLED=false
export EXECUTOR_ENABLE_BATCH_BIDDING=true

./executor
