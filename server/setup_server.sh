#!/bin/bash
# WildBorne Server Setup - Linux
# Modpack 97 mods - Version 1.21.6

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DATA_DIR="$SCRIPT_DIR/data"
MODS_DEST="$DATA_DIR/Mods"

echo "========================================"
echo "  WildBorne - Server Setup"
echo "  Modpack 97 mods - Version 1.21.6"
echo "========================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
status() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# [1/5] Search for Vintage Story
echo "[1/5] Searching for Vintage Story..."

VS_PATHS=(
    "$HOME/.config/Vintagestory"
    "$HOME/Vintagestory"
    "/opt/vintagestory"
    "/usr/share/vintagestory"
    "$HOME/.local/share/Vintagestory"
)

VS_SOURCE=""

for path in "${VS_PATHS[@]}"; do
    if [[ -f "$path/VintagestoryServer.exe" ]] || [[ -f "$path/VintagestoryServer" ]]; then
        VS_SOURCE="$path"
        status "Found: $VS_SOURCE"
        break
    fi
done

if [[ -z "$VS_SOURCE" ]]; then
    warning "Vintage Story not found automatically"
    echo ""
    echo "Enter the path to your Vintage Story installation:"
    read -p "Path: " VS_SOURCE

    if [[ ! -f "$VS_SOURCE/VintagestoryServer.exe" ]] && [[ ! -f "$VS_SOURCE/VintagestoryServer" ]]; then
        error "VintagestoryServer not found in $VS_SOURCE"
        echo ""
        echo "Please install Vintage Story 1.21.6 from:"
        echo "  https://account.vintagestory.at/"
        exit 1
    fi
fi

echo ""

# [2/5] Copy server files
echo "[2/5] Copying server files..."

if [[ ! -f "$SCRIPT_DIR/VintagestoryServer.exe" ]] && [[ ! -f "$SCRIPT_DIR/VintagestoryServer" ]]; then
    echo "       Copying from: $VS_SOURCE"

    # Copy executables
    cp -f "$VS_SOURCE/VintagestoryServer"* "$SCRIPT_DIR/" 2>/dev/null || true
    cp -f "$VS_SOURCE/VintagestoryLib.dll" "$SCRIPT_DIR/" 2>/dev/null || true

    # Copy Lib folder
    if [[ -d "$VS_SOURCE/Lib" ]]; then
        cp -rf "$VS_SOURCE/Lib" "$SCRIPT_DIR/"
    fi

    # Copy assets folder
    if [[ -d "$VS_SOURCE/assets" ]]; then
        cp -rf "$VS_SOURCE/assets" "$SCRIPT_DIR/"
    fi

    status "Done"
else
    status "Server files already present"
fi

echo ""

# [3/5] Create directories
echo "[3/5] Creating directories..."
mkdir -p "$DATA_DIR"
mkdir -p "$MODS_DEST"
mkdir -p "$DATA_DIR/Saves"
mkdir -p "$DATA_DIR/Logs"
mkdir -p "$DATA_DIR/ModConfig"
mkdir -p "$DATA_DIR/Backups"
status "Done"
echo ""

# [4/5] Download mods
echo "[4/5] Downloading mods..."

if command -v python3 &> /dev/null; then
    if [[ -f "$SCRIPT_DIR/../modlist.txt" ]]; then
        python3 "$SCRIPT_DIR/../scripts/download_mods.py" 1.21.6

        # Move downloaded mods
        if [[ -d "$SCRIPT_DIR/../mods" ]]; then
            mv -f "$SCRIPT_DIR/../mods/"*.zip "$MODS_DEST/" 2>/dev/null || true
        fi
        status "Done"
    else
        warning "modlist.txt not found"
        echo "       Download mods from GitHub Releases"
    fi
else
    warning "Python 3 not found"
    echo "       Download mods manually from:"
    echo "       https://github.com/Pixnop/Wildborne-VintageStory/releases"
fi

echo ""

# [5/5] Verification
echo "[5/5] Verification..."

if [[ -f "$SCRIPT_DIR/VintagestoryServer.exe" ]] || [[ -f "$SCRIPT_DIR/VintagestoryServer" ]]; then
    status "Server executable OK"
else
    error "Server executable missing"
    exit 1
fi

# Count mods
MODCOUNT=$(ls -1 "$MODS_DEST"/*.zip 2>/dev/null | wc -l)
echo "       Mods installed: $MODCOUNT"

echo ""

# Make scripts executable
chmod +x "$SCRIPT_DIR"/*.sh

echo "========================================"
echo "  SETUP COMPLETE!"
echo "========================================"
echo ""
echo "To start the server: ./start_server.sh"
echo ""
echo "IMPORTANT - World generation for Rivers mod:"
echo "  1. Start server"
echo "  2. Run these commands BEFORE creating world:"
echo "     /worldconfig landcover 0.5"
echo "     /worldconfig landcoverScale 4"
echo ""
echo "Oceans are REQUIRED for rivers to generate!"
echo ""
