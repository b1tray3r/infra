#!/bin/bash

sudo apt-get update -y;
sudo apt-get upgrade -y;

if [ -f "./.env" ]; then
    echo "Load environment variables from .env files"
    . .env

    env
fi

if [ -d "./private/" ]; then
    if [ -f "./private/key.ed25519" ]; then
        cp ./private/key.ed25519 ~/.ssh/aborgardt.ed25519
    fi
fi