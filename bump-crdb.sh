#!/bin/bash
LATEST=$(curl -s -L https://www.cockroachlabs.com/docs/stable/install-cockroachdb-linux | grep version-name | sed -n 's/.*<.*>\(.*\)<.*>/\1/p')
CURRENT="nil"
if cockroach version &> /dev/null; then
    CURRENT=$(cockroach version | grep "Build Tag" | sed 's/.* //g')
fi
if [ "$LATEST" = "$CURRENT" ]; then
    echo Cockroach version is up to date: "$LATEST"
else
    echo Updating cockroach from "$CURRENT" to "$LATEST"
    wget -qO- "https://binaries.cockroachdb.com/cockroach-$LATEST.linux-amd64.tgz" | tar  xvz
    sudo cp -i "cockroach-$LATEST.linux-amd64/cockroach" /usr/local/bin/
    rm -rf "cockroach-$LATEST.linux-amd64"
fi
