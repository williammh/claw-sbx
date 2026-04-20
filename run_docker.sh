#!/usr/bin/env bash

if command -v podman &> /dev/null; then
    ENGINE="podman"
    FLAGS="--userns=keep-id"
elif command -v docker &> /dev/null; then
    ENGINE="docker"
    FLAGS=""
else
    echo "Error: No engine found."
    exit 1
fi

echo "Using container engine: $ENGINE"

$ENGINE run -it \
    $FLAGS \
	--env-file ./data/.env \
    --env OPENCLAW_ALLOW_INSECURE_PRIVATE_WS=1 \
    --env OPENCLAW_GATEWAY_CONTROLUI_ENABLED=true \
    --env OPENCLAW_GATEWAY_CONTROLUI_PORT=18789 \
    --publish 18789:18789 \
	--volume "$(pwd)/data:/home/claw/.openclaw:Z" \
    claw_sbx \
    openclaw gateway --allow-unconfigured