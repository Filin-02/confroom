@echo off
chcp 65001 >nul
rem Удаление автозапуска приложения на Windows.
rem Запускать ОТ ИМЕНИ АДМИНИСТРАТОРА.

net session >nul 2>nul
if errorlevel 1 (
  echo  ОШИБКА: запустите этот файл от имени администратора.
  pause
  exit /b 1
)

schtasks /Delete /TN "VKS-Control" /F
echo.
echo  Автозапуск удалён.
pause
