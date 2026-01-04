#!/bin/bash
# WildBorne Docker Setup Script
# Modpack: 121 mods - Vintage Story 1.21.6

set -e

VS_VERSION="1.21.6"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GITHUB_RELEASE="https://github.com/Pixnop/Wildborne-VintageStory/releases/latest/download"

echo "========================================"
echo "  WildBorne Docker Setup"
echo "  Modpack 121 mods - Version ${VS_VERSION}"
echo "========================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

status() { echo -e "${GREEN}[OK]${NC} $1"; }
warning() { echo -e "${YELLOW}[!]${NC} $1"; }

# [1/4] Create directories
echo "[1/4] Creating directories..."
mkdir -p "$SCRIPT_DIR/server"
mkdir -p "$SCRIPT_DIR/data/Mods"
mkdir -p "$SCRIPT_DIR/data/Saves"
mkdir -p "$SCRIPT_DIR/data/Logs"
mkdir -p "$SCRIPT_DIR/data/ModConfig"
status "Done"
echo ""

# [2/4] Download Vintage Story Server
echo "[2/4] Downloading Vintage Story Server ${VS_VERSION}..."
if [ ! -f "$SCRIPT_DIR/server/VintagestoryServer.dll" ]; then
    wget -q --show-progress "https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VS_VERSION}.tar.gz" -O /tmp/vs_server.tar.gz
    tar -xzf /tmp/vs_server.tar.gz -C "$SCRIPT_DIR/server"
    rm /tmp/vs_server.tar.gz
    status "Done"
else
    status "Server already downloaded"
fi
echo ""

# [3/4] Download WildBorne modpack
echo "[3/4] Downloading WildBorne modpack..."
MODCOUNT=$(ls -1 "$SCRIPT_DIR/data/Mods"/*.zip 2>/dev/null | wc -l)
if [ "$MODCOUNT" -lt 120 ]; then
    wget -q --show-progress "$GITHUB_RELEASE/Wildborne-latest.zip" -O /tmp/modpack.zip
    unzip -o -q /tmp/modpack.zip -d "$SCRIPT_DIR/data/Mods/"
    rm /tmp/modpack.zip
    MODCOUNT=$(ls -1 "$SCRIPT_DIR/data/Mods"/*.zip 2>/dev/null | wc -l)
    status "Installed $MODCOUNT mods"
else
    status "Mods already installed ($MODCOUNT mods)"
fi
echo ""

# [4/4] Create default serverconfig.json with Rivers-compatible world settings
echo "[4/4] Creating server configuration..."
if [ ! -f "$SCRIPT_DIR/data/serverconfig.json" ]; then
    cat > "$SCRIPT_DIR/data/serverconfig.json" << 'EOF'
{
  "ServerName": "WildBorne Server",
  "ServerDescription": "Modpack WildBorne - 121 mods",
  "WelcomeMessage": "Bienvenue sur le serveur WildBorne!",
  "MaxClients": 16,
  "Password": "",
  "Port": 42420,
  "AllowPvP": true,
  "AllowFireSpread": true,
  "AllowFallingBlocks": true,
  "WorldConfig": {
    "WorldConfiguration": {
      "landcover": "0.5",
      "oceanscale": "4"
    }
  }
}
EOF
    status "Created serverconfig.json (Rivers: landcover=0.5, oceanscale=4)"
else
    status "serverconfig.json already exists"
fi

# Set permissions
chmod -R 755 "$SCRIPT_DIR/data"
status "Done"
echo ""

echo "========================================"
echo "  SETUP COMPLETE!"
echo "========================================"
echo ""
echo "To start the server:"
echo "  docker compose up -d"
echo ""
echo "To view logs:"
echo "  docker compose logs -f"
echo ""
echo "To stop:"
echo "  docker compose down"
echo ""
echo "========================================"
echo "  Rivers Configuration (Auto)"
echo "========================================"
echo ""
echo "World generation is pre-configured for Rivers mod:"
echo "  - landcover: 0.5 (50% land/ocean)"
echo "  - oceanscale: 4 (large oceans)"
echo ""
echo "Just start the server and create a new world!"
echo ""
