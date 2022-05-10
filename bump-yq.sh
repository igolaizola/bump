#!/bin/bash
LATEST=$(curl -w "%{redirect_url}" -o /dev/null -s https://github.com/mikefarah/yq/releases/latest | awk -F '/' '{print $NF}')
CURRENT=v$(yq -V | awk '{print $NF}')
if [ "$LATEST" = "$CURRENT" ]; then
    echo yq version is up to date: "$LATEST"
else
    exit 1
    echo Updating yq from "$CURRENT" to "$LATEST"
    wget -qO- "https://github.com/mikefarah/yq/releases/download/$LATEST/yq_linux_amd64"
    sudo mv yq_linux_amd64 /usr/bin/yq
    sudo chmod +x /usr/bin/yq
fi
