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
set "GITHUB_RELEASE=https://github.com/Pixnop/Wildborne-VintageStory/releases/latest/download"
set "MODPACK_ZIP=Wildborne-latest.zip"

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

echo [4/5] Downloading modpack from GitHub Release...
echo.

REM Check if mods already exist
set /a EXISTING_MODS=0
for %%f in ("%MODS_DEST%\*.zip") do set /a EXISTING_MODS+=1

if %EXISTING_MODS% gtr 50 (
    echo       Mods already installed (%EXISTING_MODS% mods)
    echo       Skip download? (Y/N)
    set /p "SKIP_DL=Choice: "
    if /i "!SKIP_DL!"=="Y" goto :skip_download
)

echo       Downloading from GitHub Releases...
echo       URL: %GITHUB_RELEASE%
echo.

REM Try curl (Windows 10+)
where curl >nul 2>nul
if %ERRORLEVEL% equ 0 (
    curl -L -o "%SCRIPT_DIR%modpack.zip" "%GITHUB_RELEASE%/Wildborne-latest.zip" 2>nul
    if exist "%SCRIPT_DIR%modpack.zip" (
        echo       Extracting mods...
        powershell -Command "Expand-Archive -Force '%SCRIPT_DIR%modpack.zip' '%MODS_DEST%'"
        del "%SCRIPT_DIR%modpack.zip"
        echo       Done
    ) else (
        echo       Download failed. Please download manually:
        echo       https://github.com/Pixnop/Wildborne-VintageStory/releases
    )
) else (
    REM Try PowerShell
    echo       Using PowerShell...
    powershell -Command "try { Invoke-WebRequest -Uri '%GITHUB_RELEASE%/Wildborne-latest.zip' -OutFile '%SCRIPT_DIR%modpack.zip' } catch { exit 1 }"
    if exist "%SCRIPT_DIR%modpack.zip" (
        echo       Extracting mods...
        powershell -Command "Expand-Archive -Force '%SCRIPT_DIR%modpack.zip' '%MODS_DEST%'"
        del "%SCRIPT_DIR%modpack.zip"
        echo       Done
    ) else (
        echo.
        echo       ========================================
        echo       Automatic download failed.
        echo       ========================================
        echo.
        echo       Please download manually:
        echo       1. Go to: https://github.com/Pixnop/Wildborne-VintageStory/releases
        echo       2. Download the latest Wildborne-X.X.X.zip
        echo       3. Extract contents to: %MODS_DEST%
        echo.
    )
)

:skip_download
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

if %MODCOUNT% lss 90 (
    echo.
    echo       WARNING: Expected 97 mods, found %MODCOUNT%
    echo       Download mods from: https://github.com/Pixnop/Wildborne-VintageStory/releases
)
echo.

echo ========================================
echo   SETUP COMPLETE!
echo ========================================
echo.
echo To start the server: start_server.bat
echo.
echo ========================================
echo   IMPORTANT - World Generation Settings
echo ========================================
echo.
echo The Rivers mod REQUIRES oceans to generate rivers.
echo.
echo Run these commands BEFORE creating the world:
echo.
echo   /worldconfig landcover 0.5
echo   /worldconfig landcoverScale 4
echo.
echo Recommended settings:
echo   - Landcover: 50%%
echo   - Landcover Scale: 300-500%%
echo   - Ocean presence: ENABLED
echo.
pause
