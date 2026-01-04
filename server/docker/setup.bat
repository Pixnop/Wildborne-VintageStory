@echo off
:: WildBorne Docker Setup Script - Windows
:: Modpack: 121 mods - Vintage Story 1.21.6

setlocal enabledelayedexpansion

set VS_VERSION=1.21.6
set SCRIPT_DIR=%~dp0
set GITHUB_RELEASE=https://github.com/Pixnop/Wildborne-VintageStory/releases/latest/download

echo ========================================
echo   WildBorne Docker Setup
echo   Modpack 121 mods - Version %VS_VERSION%
echo ========================================
echo.

:: [1/4] Create directories
echo [1/4] Creating directories...
if not exist "%SCRIPT_DIR%server" mkdir "%SCRIPT_DIR%server"
if not exist "%SCRIPT_DIR%data\Mods" mkdir "%SCRIPT_DIR%data\Mods"
if not exist "%SCRIPT_DIR%data\Saves" mkdir "%SCRIPT_DIR%data\Saves"
if not exist "%SCRIPT_DIR%data\Logs" mkdir "%SCRIPT_DIR%data\Logs"
if not exist "%SCRIPT_DIR%data\ModConfig" mkdir "%SCRIPT_DIR%data\ModConfig"
echo [OK] Done
echo.

:: [2/4] Download Vintage Story Server
echo [2/4] Downloading Vintage Story Server %VS_VERSION%...
if not exist "%SCRIPT_DIR%server\VintagestoryServer.dll" (
    echo        Downloading from cdn.vintagestory.at...
    curl -L -o "%TEMP%\vs_server.tar.gz" "https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_%VS_VERSION%.tar.gz"
    if exist "%TEMP%\vs_server.tar.gz" (
        echo        Extracting...
        tar -xzf "%TEMP%\vs_server.tar.gz" -C "%SCRIPT_DIR%server"
        del "%TEMP%\vs_server.tar.gz"
        echo [OK] Done
    ) else (
        echo [ERROR] Download failed
        pause
        exit /b 1
    )
) else (
    echo [OK] Server already downloaded
)
echo.

:: [3/4] Download WildBorne modpack
echo [3/4] Downloading WildBorne modpack...
set MODCOUNT=0
for %%f in ("%SCRIPT_DIR%data\Mods\*.zip") do set /a MODCOUNT+=1

if !MODCOUNT! lss 120 (
    echo        Downloading from GitHub Releases...
    curl -L -o "%TEMP%\modpack.zip" "%GITHUB_RELEASE%/Wildborne-latest.zip"
    if exist "%TEMP%\modpack.zip" (
        echo        Extracting mods...
        powershell -Command "Expand-Archive -Path '%TEMP%\modpack.zip' -DestinationPath '%SCRIPT_DIR%data\Mods' -Force"
        del "%TEMP%\modpack.zip"
        set MODCOUNT=0
        for %%f in ("%SCRIPT_DIR%data\Mods\*.zip") do set /a MODCOUNT+=1
        echo [OK] Installed !MODCOUNT! mods
    ) else (
        echo [ERROR] Download failed
        pause
        exit /b 1
    )
) else (
    echo [OK] Mods already installed ^(!MODCOUNT! mods^)
)
echo.

:: [4/4] Create default serverconfig.json with Rivers-compatible world settings
echo [4/4] Creating server configuration...
if not exist "%SCRIPT_DIR%data\serverconfig.json" (
    (
        echo {
        echo   "ServerName": "WildBorne Server",
        echo   "ServerDescription": "Modpack WildBorne - 121 mods",
        echo   "WelcomeMessage": "Bienvenue sur le serveur WildBorne!",
        echo   "MaxClients": 16,
        echo   "Password": "",
        echo   "Port": 42420,
        echo   "AllowPvP": true,
        echo   "AllowFireSpread": true,
        echo   "AllowFallingBlocks": true,
        echo   "WorldConfig": {
        echo     "WorldConfiguration": {
        echo       "landcover": "0.5",
        echo       "oceanscale": "4"
        echo     }
        echo   }
        echo }
    ) > "%SCRIPT_DIR%data\serverconfig.json"
    echo [OK] Created serverconfig.json ^(Rivers: landcover=0.5, oceanscale=4^)
) else (
    echo [OK] serverconfig.json already exists
)
echo.

echo ========================================
echo   SETUP COMPLETE!
echo ========================================
echo.
echo To start the server:
echo   docker compose up -d
echo.
echo To view logs:
echo   docker compose logs -f
echo.
echo To stop:
echo   docker compose down
echo.
echo ========================================
echo   Rivers Configuration (Auto)
echo ========================================
echo.
echo World generation is pre-configured for Rivers mod:
echo   - landcover: 0.5 (50%% land/ocean)
echo   - oceanscale: 4 (large oceans)
echo.
echo Just start the server and create a new world!
echo.

pause
