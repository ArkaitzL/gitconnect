@echo off
setlocal EnableDelayedExpansion

:INICIO
cls
echo.
echo ====================================================
echo              GIT CONNECTOR - CONFIGURACION
echo ====================================================
echo.

echo --------------------------------------------
echo Paso 1: Crea tu repositorio en GitHub manualmente.
echo --------------------------------------------
echo https://github.com/new
echo.

echo.
echo --------------------------------------------
echo Paso 2: Inicializando Git en la carpeta
echo --------------------------------------------
echo Ruta base actual: %CD:\=/% 
echo.

:PEDIR_CARPETA
set /p SUBCARPETA=C: Escribe el nombre de la subcarpeta: 

set "CARPETA=%CD%\%SUBCARPETA%"
if not exist "!CARPETA!" (
    echo ERROR: La carpeta "!CARPETA!" no existe. Intenta de nuevo.
    goto PEDIR_CARPETA
)

cd /d "!CARPETA!"

echo.
echo --------------------------------------------
echo Paso 3 [Automatico]: Inicializando Git en la carpeta
echo --------------------------------------------
echo.

if not exist ".git" (
    git init
    echo Repositorio Git inicializado correctamente.
) else (
    echo Git ya estaba inicializado.
)

git add .
git commit -m "Commit inicial"

echo.
echo --------------------------------------------
echo Paso 4: Vincular repositorio remoto
echo --------------------------------------------
echo.

:PEDIR_REPO
set /p REPO=C: Pega la URL del repositorio GitHub (ej: https://github.com/usuario/repositorio.git): 

if "%REPO%"=="" (
    echo ERROR: No ingresaste ninguna URL. Intenta de nuevo.
    goto PEDIR_REPO
)

:: Comprobar si repo remoto NO está vacío
set REMOTO_NO_VACIO=
for /f %%i in ('git ls-remote "!REPO!" ^| findstr "refs/heads/main"') do set REMOTO_NO_VACIO=1

if defined REMOTO_NO_VACIO (
    echo ERROR: El repositorio remoto NO está vacío. Usa un repositorio nuevo y vacío.
    goto PEDIR_REPO
)

git remote add origin "!REPO!"
git branch -M main
git push -u origin main

echo.
echo --------------------------------------------
echo PROCESO COMPLETADO CORRECTAMENTE
echo --------------------------------------------
echo.

pause
