#!/bin/bash
set -e

echo "==> Building StellarID contract..."
cargo build --target wasm32-unknown-unknown --release

echo "==> Deploying to testnet..."
CONTRACT_ID=$(soroban contract deploy \
  --wasm target/wasm32-unknown-unknown/release/stellar_id.wasm \
  --network testnet \
  --source deployer)

echo "Contract deployed: $CONTRACT_ID"

echo "==> Initializing contract..."
soroban contract invoke \
  --id "$CONTRACT_ID" \
  --network testnet \
  --source deployer \
  -- initialize \
  --admin "$(soroban keys address deployer)"

echo "==> StellarID deployed and initialized!"
echo "CONTRACT_ID=$CONTRACT_ID"
