@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>nul
title WildBorne - Server Setup
color 0A

echo ========================================
echo   WildBorne - Server Setup
echo   Modpack 97 mods - Version 1.21.6
echo ========================================
echo.

set "SCRIPT_DIR=%~dp0"
set "DATA_DIR=%SCRIPT_DIR%data"
set "MODS_DEST=%DATA_DIR%\Mods"

REM Search for Vintage Story installation
echo [1/5] Searching for Vintage Story...
echo.

set "VS_FOUND="

REM Common installation paths
set "PATHS[0]=%ProgramFiles%\Vintagestory"
set "PATHS[1]=%ProgramFiles(x86)%\Vintagestory"
set "PATHS[2]=C:\Vintagestory"
set "PATHS[3]=D:\Vintagestory"
set "PATHS[4]=%USERPROFILE%\Vintagestory"
set "PATHS[5]=%APPDATA%\..\Local\Vintagestory"

for /L %%i in (0,1,5) do (
    if exist "!PATHS[%%i]!\VintagestoryServer.exe" (
        set "VS_SOURCE=!PATHS[%%i]!"
        set "VS_FOUND=1"
        echo       Found: !VS_SOURCE!
        goto :found
    )
)

:notfound
if not defined VS_FOUND (
    echo ========================================
    echo   Vintage Story not found automatically
    echo ========================================
    echo.
    echo Enter the path to your Vintage Story installation:
    echo Example: C:\Program Files\Vintagestory
    echo.
    set /p "VS_SOURCE=Path: "

    if not exist "!VS_SOURCE!\VintagestoryServer.exe" (
        echo.
        echo ERROR: VintagestoryServer.exe not found in !VS_SOURCE!
        echo.
        echo Please install Vintage Story 1.21.6 from:
        echo   https://account.vintagestory.at/
        echo.
        pause
        exit /b 1
    )
)

:found
echo.

echo [2/5] Copying server files...
if not exist "%SCRIPT_DIR%VintagestoryServer.exe" (
    echo       Copying from: %VS_SOURCE%

    REM Copy essential files only
    copy /Y "%VS_SOURCE%\VintagestoryServer.exe" "%SCRIPT_DIR%" >nul
    copy /Y "%VS_SOURCE%\VintagestoryLib.dll" "%SCRIPT_DIR%" >nul 2>nul
    copy /Y "%VS_SOURCE%\Vintagestory.exe.config" "%SCRIPT_DIR%\VintagestoryServer.exe.config" >nul 2>nul

    REM Copy Lib folder
    if exist "%VS_SOURCE%\Lib" (
        xcopy /E /Y /Q /I "%VS_SOURCE%\Lib" "%SCRIPT_DIR%Lib" >nul
    )

    REM Copy assets folder
    if exist "%VS_SOURCE%\assets" (
        xcopy /E /Y /Q /I "%VS_SOURCE%\assets" "%SCRIPT_DIR%assets" >nul
    )

    echo       Done
) else (
    echo       Server files already present
)
echo.

echo [3/5] Creating directories...
if not exist "%DATA_DIR%" mkdir "%DATA_DIR%"
if not exist "%MODS_DEST%" mkdir "%MODS_DEST%"
if not exist "%DATA_DIR%\Saves" mkdir "%DATA_DIR%\Saves"
if not exist "%DATA_DIR%\Logs" mkdir "%DATA_DIR%\Logs"
if not exist "%DATA_DIR%\ModConfig" mkdir "%DATA_DIR%\ModConfig"
if not exist "%DATA_DIR%\Backups" mkdir "%DATA_DIR%\Backups"
echo       Done
echo.

echo [4/5] Downloading mods...
echo       This requires Python 3.x
echo.

where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo       WARNING: Python not found
    echo       Please download mods manually from:
    echo       https://github.com/Pixnop/Wildborne-VintageStory/releases
    echo.
) else (
    REM Check if modlist.txt exists
    if exist "%SCRIPT_DIR%..\modlist.txt" (
        python "%SCRIPT_DIR%..\scripts\download_mods.py" 1.21.6

        REM Move downloaded mods
        if exist "%SCRIPT_DIR%..\mods\*.zip" (
            move /Y "%SCRIPT_DIR%..\mods\*.zip" "%MODS_DEST%\" >nul 2>nul
        )
    ) else (
        echo       modlist.txt not found
        echo       Download mods from GitHub Releases
    )
)
echo.

echo [5/5] Verification...
if exist "%SCRIPT_DIR%VintagestoryServer.exe" (
    echo       VintagestoryServer.exe OK
) else (
    echo       ERROR: Server executable missing
    pause
    exit /b 1
)

REM Count mods
set /a MODCOUNT=0
for %%f in ("%MODS_DEST%\*.zip") do set /a MODCOUNT+=1
echo       Mods installed: %MODCOUNT%
echo.

echo ========================================
echo   SETUP COMPLETE!
echo ========================================
echo.
echo To start the server: start_server.bat
echo.
echo IMPORTANT - World generation for Rivers mod:
echo   1. Start server
echo   2. Run these commands BEFORE creating world:
echo      /worldconfig landcover 0.5
echo      /worldconfig landcoverScale 4
echo.
echo Oceans are REQUIRED for rivers to generate!
echo.
pause
