#!/bin/bash
LATEST=v$(curl -s -L https://nodejs.org/en/download/ | grep "Latest LTS Version" | sed -n 's/.*<strong>\(.*\)<\/strong>.*/\1/p')
CURRENT="nil"
if node -v &> /dev/null; then
    CURRENT=$(node -v)
fi
if [ "$LATEST" = "$CURRENT" ]; then
    echo Node version is up to date: "$LATEST"
else
    echo Updating node from "$CURRENT" to "$LATEST"
    wget "https://nodejs.org/dist/$LATEST/node-$LATEST-linux-x64.tar.xz"
    sudo rm -rf /usr/local/lib/nodejs
    sudo mkdir /usr/local/lib/nodejs
    sudo tar -xJvf node-$LATEST-linux-x64.tar.xz -C /usr/local/lib/nodejs --strip-components=1
    rm "node-$LATEST-linux-x64.tar.xz"
    echo "Remember to add /usr/local/lib/nodejs/bin to your PATH"
fi
