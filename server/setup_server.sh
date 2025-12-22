#!/bin/bash
# WildBorne Server Setup - Linux
# Modpack 97 mods - Version 1.21.6

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DATA_DIR="$SCRIPT_DIR/data"
MODS_DEST="$DATA_DIR/Mods"
GITHUB_RELEASE="https://github.com/Pixnop/Wildborne-VintageStory/releases/latest/download"

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

# [4/5] Download mods from GitHub Release
echo "[4/5] Downloading modpack from GitHub Release..."
echo ""

# Count existing mods
EXISTING_MODS=$(ls -1 "$MODS_DEST"/*.zip 2>/dev/null | wc -l)

if [[ $EXISTING_MODS -gt 50 ]]; then
    echo "       Mods already installed ($EXISTING_MODS mods)"
    read -p "       Skip download? (y/n): " SKIP_DL
    if [[ "$SKIP_DL" == "y" ]] || [[ "$SKIP_DL" == "Y" ]]; then
        echo ""
        goto_skip=true
    fi
fi

if [[ "$goto_skip" != "true" ]]; then
    echo "       Downloading from GitHub Releases..."
    echo "       URL: $GITHUB_RELEASE"
    echo ""

    # Try curl or wget
    if command -v curl &> /dev/null; then
        curl -L -o "$SCRIPT_DIR/modpack.zip" "$GITHUB_RELEASE/Wildborne-latest.zip" 2>/dev/null
    elif command -v wget &> /dev/null; then
        wget -O "$SCRIPT_DIR/modpack.zip" "$GITHUB_RELEASE/Wildborne-latest.zip" 2>/dev/null
    else
        warning "Neither curl nor wget found"
        echo "       Please download manually from:"
        echo "       https://github.com/Pixnop/Wildborne-VintageStory/releases"
    fi

    if [[ -f "$SCRIPT_DIR/modpack.zip" ]]; then
        echo "       Extracting mods..."
        unzip -o -q "$SCRIPT_DIR/modpack.zip" -d "$MODS_DEST/"
        rm -f "$SCRIPT_DIR/modpack.zip"
        status "Done"
    else
        warning "Download failed"
        echo ""
        echo "       Please download manually:"
        echo "       1. Go to: https://github.com/Pixnop/Wildborne-VintageStory/releases"
        echo "       2. Download the latest Wildborne-X.X.X.zip"
        echo "       3. Extract contents to: $MODS_DEST"
    fi
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

if [[ $MODCOUNT -lt 90 ]]; then
    echo ""
    warning "Expected 97 mods, found $MODCOUNT"
    echo "       Download mods from: https://github.com/Pixnop/Wildborne-VintageStory/releases"
fi

echo ""

# Make scripts executable
chmod +x "$SCRIPT_DIR"/*.sh

echo "========================================"
echo "  SETUP COMPLETE!"
echo "========================================"
echo ""
echo "To start the server: ./start_server.sh"
echo ""
echo "========================================"
echo "  IMPORTANT - World Generation Settings"
echo "========================================"
echo ""
echo "The Rivers mod REQUIRES oceans to generate rivers."
echo ""
echo "Run these commands BEFORE creating the world:"
echo ""
echo "  /worldconfig landcover 0.5"
echo "  /worldconfig landcoverScale 4"
echo ""
echo "Recommended settings:"
echo "  - Landcover: 50%"
echo "  - Landcover Scale: 300-500%"
echo "  - Ocean presence: ENABLED"
echo ""
