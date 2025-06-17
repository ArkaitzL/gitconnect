@echo off
setlocal EnableDelayedExpansion

:: Obtener la carpeta donde está este script (instalador)
set "CARPETA_ACTUAL=%~dp0"
:: Quitar la barra final si existe
if "%CARPETA_ACTUAL:~-1%"=="\" set "CARPETA_ACTUAL=%CARPETA_ACTUAL:~0,-1%"


:: Ahora verificar si la carpeta actual está en PATH
echo %PATH% | findstr /I /C:"!CARPETA_ACTUAL!" >nul
if errorlevel 1 (
    setx PATH "%PATH%;!CARPETA_ACTUAL!"
    echo Carpeta anadida al PATH.
) else (
    echo La carpeta ya esta en PATH. No es necesario anadirla.
)

echo.
echo Puedes comprobarlo aqui:
echo %PATH%
echo.
pause
