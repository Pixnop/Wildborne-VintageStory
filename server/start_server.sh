#!/bin/bash
# WildBorne Server - Start Script (Linux)
# Modpack 97 mods - Version 1.21.6

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================"
echo "  WildBorne Server - Version 1.21.6"
echo "  Modpack: 97 mods"
echo "  Port: 42420"
echo "========================================"
echo ""
echo "Commands:"
echo "  /stop              - Stop the server"
echo "  /whitelist add X   - Add player to whitelist"
echo "  /player X role admin - Give admin rights"
echo ""
echo "Rivers configuration (before world creation):"
echo "  /worldconfig landcover 0.5"
echo "  /worldconfig landcoverScale 4"
echo ""
echo "========================================"
echo ""

cd "$SCRIPT_DIR"

# Check for server executable
if [[ -f "VintagestoryServer" ]]; then
    # Native Linux executable
    ./VintagestoryServer --dataPath "$SCRIPT_DIR/data"
elif [[ -f "VintagestoryServer.exe" ]]; then
    # Use mono for .exe
    if command -v mono &> /dev/null; then
        mono VintagestoryServer.exe --dataPath "$SCRIPT_DIR/data"
    else
        echo "ERROR: mono not found"
        echo ""
        echo "Install mono-complete:"
        echo "  Ubuntu/Debian: sudo apt install mono-complete"
        echo "  Fedora: sudo dnf install mono-complete"
        echo "  Arch: sudo pacman -S mono"
        exit 1
    fi
else
    echo "ERROR: VintagestoryServer not found"
    echo ""
    echo "Run setup_server.sh first!"
    exit 1
fi

echo ""
echo "Server stopped."
