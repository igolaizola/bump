#!/bin/bash
LATEST=$(curl -s https://go.dev/dl/ | grep ".linux-amd64.tar.gz</span>" | sed -e 's/.*go\(.*\).linux.*/\1/')
CURRENT="nil"
if go version &> /dev/null; then
    CURRENT=$(go version |  sed -e 's/.*go\(.*\) linux.*/\1/')
fi
if [ "$LATEST" = "$CURRENT" ]; then
    echo Golang version is up to date: "$LATEST"
else
    echo Updating golang from "$CURRENT" to "$LATEST"
    wget "https://go.dev/dl/go$LATEST.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "go$LATEST.linux-amd64.tar.gz"
    rm "go$LATEST.linux-amd64.tar.gz"
fi
