#!/bin/bash
# WildBorne Server - Stop Script (Linux)

echo "========================================"
echo "  WildBorne - Stopping Server"
echo "========================================"
echo ""

# Find and kill VintagestoryServer process
if pgrep -f "VintagestoryServer" > /dev/null; then
    echo "Stopping VintagestoryServer..."
    pkill -f "VintagestoryServer"
    echo "Server stopped."
else
    echo "Server is not running."
fi

echo ""
