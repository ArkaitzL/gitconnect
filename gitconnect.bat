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
set /p SUBCARPETA=C: Escribe el nombre de la subcarpeta (Enter carpeta actual): 

set "CARPETA=%CD%"
if not "%SUBCARPETA%"=="" set "CARPETA=%CD%\%SUBCARPETA%"

if not exist "!CARPETA!" (
    echo ERROR: La carpeta "!CARPETA!" no existe. Intenta de nuevo.
    echo.
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
    echo.
    goto PEDIR_REPO
)

:: Configura remote (si ya existe, elimina y añade para evitar error)
git remote remove origin >nul 2>&1
git remote add origin "!REPO!"
git branch -M main

echo.
echo --------------------------------------------
echo Sincronizando con repositorio remoto...
echo --------------------------------------------
echo.

:: Hacer pull para evitar errores de historial no relacionado (ej: README inicial)
git pull origin main --allow-unrelated-histories --no-edit

:: Subir al repositorio
git push -u origin main

echo.
echo --------------------------------------------
echo PROCESO COMPLETADO CORRECTAMENTE
echo --------------------------------------------
echo.

pause
exit /b
