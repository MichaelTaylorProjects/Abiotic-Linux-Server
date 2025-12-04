#!/bin/bash
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
SRC="/home/abiotic/abioticserver/AbioticFactor/Saved/SaveGames/Server/Worlds/YourWorldNameHere"
DEST="/home/abiotic/backups"

mkdir -p "$DEST"
tar -czf "$DEST/${WORLD_NAME}_$TIMESTAMP.tar.gz" "$SRC"
find "$DEST" -type f -mtime +7 -delete
