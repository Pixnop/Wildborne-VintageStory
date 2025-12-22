@echo off
chcp 65001 >nul 2>nul
echo ========================================
echo   WildBorne - Stopping Server
echo ========================================
echo.

tasklist /FI "IMAGENAME eq VintagestoryServer.exe" 2>nul | find /I "VintagestoryServer.exe" >nul
if %ERRORLEVEL% equ 0 (
    echo Stopping VintagestoryServer.exe...
    taskkill /F /IM VintagestoryServer.exe >nul 2>nul
    echo Server stopped.
) else (
    echo Server is not running.
)

echo.
pause
