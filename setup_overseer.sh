#!/bin/bash

if [ -f "./.env" ]; then
    echo "Load environment variables from .env files"
    . .env
fi

if [ "${UPDATE_SYSTEM}"]; then
    sudo apt-get update -y;
    sudo apt-get upgrade -y;
fi

if [ -d "./private/" ]; then
    if [ -f "./private/key.ed25519" ]; then
        cp ./private/key.ed25519 ~/.ssh/aborgardt.ed25519
    fi
fi