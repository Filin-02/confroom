@echo off
chcp 65001 >nul
rem ============================================================
rem  Установка автозапуска приложения на Windows
rem  Создаёт задачу в Планировщике, запускающую сервер при старте ПК.
rem  Запускать ОТ ИМЕНИ АДМИНИСТРАТОРА (правый клик -> Запуск от имени администратора).
rem ============================================================

cd /d "%~dp0"

net session >nul 2>nul
if errorlevel 1 (
  echo  ОШИБКА: запустите этот файл от имени администратора.
  pause
  exit /b 1
)

set "TASK=VKS-Control"
set "RUN=%~dp0start.bat"

schtasks /Create /TN "%TASK%" /TR "\"%RUN%\"" /SC ONSTART /RU SYSTEM /RL HIGHEST /F
if errorlevel 1 (
  echo  Не удалось создать задачу.
  pause
  exit /b 1
)

echo.
echo  Готово. Приложение будет запускаться автоматически при включении компьютера.
echo  Запустить прямо сейчас:  schtasks /Run /TN "%TASK%"
echo  Удалить автозапуск:      удалите_автозапуск_windows.bat
echo.
pause
