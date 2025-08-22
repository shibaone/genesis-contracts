#!/usr/bin/env sh

# Usage:
# generate.sh 15001 heimdall-15001

set -x #echo on

if [ -z "$1" ]
  then
    echo "Bor chain id is required first argument"
  exit 1
fi

if [ -z "$2" ]
  then
    echo "Heimdall chain id is required as second argument"
  exit 1
fi

npm install
npx hardhat compile
git submodule init
git submodule update
cd matic-contracts
npm install
node run template:process --bor-chain-id $1
npx hardhat compile
cd ..
node generate-borvalidatorset.js --bor-chain-id $1 --heimdall-chain-id $2
npx hardhat compile
node generate-genesis.js --bor-chain-id $1 --heimdall-chain-id $2
