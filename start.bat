@echo off
chcp 65001 >nul
rem ============================================================
rem  Пульт управления микрофонами - запуск сервера на Windows
rem  Работает БЕЗ интернета. Нужен только Node.js.
rem  Node.js берётся одним из двух способов:
rem    1) портативный - папка "node" рядом с этим файлом (ничего ставить не надо)
rem    2) установленный в системе Node.js
rem ============================================================

cd /d "%~dp0"

rem --- Способ 1: портативный Node.js в папке .\node\ ---
set "NODE_EXE="
if exist "%~dp0node\node.exe" set "NODE_EXE=%~dp0node\node.exe"

rem --- Способ 2: системный Node.js ---
if not defined NODE_EXE (
  where node >nul 2>nul && set "NODE_EXE=node"
)

if not defined NODE_EXE (
  echo.
  echo  ОШИБКА: не найден Node.js.
  echo.
  echo  Вариант А (без установки^): положите рядом с этим файлом папку "node"
  echo  с портативным Node.js (внутри должен быть node.exe^).
  echo.
  echo  Вариант Б: установите Node.js (файл node-setup.msi из этого комплекта,
  echo  либо с https://nodejs.org на компьютере с интернетом^).
  echo.
  pause
  exit /b 1
)

set "PORT=8080"
if exist "data\config.json" (
  for /f "usebackq tokens=*" %%p in (`"%NODE_EXE%" -e "try{process.stdout.write(String(require('./data/config.json').server.httpPort))}catch(e){process.stdout.write('8080')}"`) do set "PORT=%%p"
)

echo ================================================
echo   Пульт управления микрофонами - сервер запущен
echo.
echo   На этом ПК откройте:   http://localhost:%PORT%
echo   С планшета/устройств:  http://(IP-этого-ПК):%PORT%
echo.
echo   IP этого ПК узнать командой ipconfig (строка IPv4)
echo   Остановка: закройте это окно
echo ================================================
echo.

"%NODE_EXE%" backend\src\server.js

echo.
echo Сервер остановлен.
pause
