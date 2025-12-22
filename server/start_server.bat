@echo off
chcp 65001 >nul 2>nul
title WildBorne Server 1.21.6
color 0B

echo ========================================
echo   WildBorne Server - Version 1.21.6
echo   Modpack: 97 mods
echo   Port: 42420
echo ========================================
echo.
echo Commands:
echo   /stop              - Stop the server
echo   /whitelist add X   - Add player to whitelist
echo   /player X role admin - Give admin rights
echo.
echo Rivers configuration (before world creation):
echo   /worldconfig landcover 0.5
echo   /worldconfig landcoverScale 4
echo.
echo ========================================
echo.

cd /d "%~dp0"

if not exist "VintagestoryServer.exe" (
    echo ERROR: VintagestoryServer.exe not found
    echo.
    echo Run setup_server.bat first!
    echo.
    pause
    exit /b 1
)

REM Start the server
"%~dp0VintagestoryServer.exe" --dataPath "%~dp0data"

echo.
echo Server stopped.
pause
