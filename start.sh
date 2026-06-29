#!/usr/bin/env bash
# ============================================================
#  Пульт управления микрофонами — запуск на Linux (вкл. РЕД ОС 7.3)
#  Требуется только Node.js 18+. Внешних библиотек нет (npm install НЕ нужен).
# ============================================================

cd "$(dirname "$0")" || exit 1

# Проверка наличия Node.js
if ! command -v node >/dev/null 2>&1; then
  echo ""
  echo "  ОШИБКА: не найден Node.js."
  echo ""
  if command -v dnf >/dev/null 2>&1; then
    echo "  РЕД ОС / RHEL-совместимая система. Установите Node.js командой:"
    echo "      sudo dnf module install nodejs:18"
    echo "  или (если модули недоступны):"
    echo "      sudo dnf install -y nodejs"
  elif command -v apt >/dev/null 2>&1; then
    echo "  Ubuntu/Debian. Установите Node.js командой:"
    echo "      sudo apt update && sudo apt install -y nodejs"
  else
    echo "  Установите Node.js версии 18 или новее с https://nodejs.org"
  fi
  echo "  Проверка после установки:  node -v"
  echo ""
  exit 1
fi

PORT="$(node -e "try{console.log(require('./data/config.json').server.httpPort)}catch(e){console.log(8080)}" 2>/dev/null)"
[ -z "$PORT" ] && PORT=8080

echo "================================================"
echo "  Пульт управления микрофонами — запуск"
echo "  Откройте в браузере:  http://localhost:$PORT"
echo "  (с других устройств:  http://<IP-сервера>:$PORT )"
echo "  Остановка: Ctrl+C"
echo "================================================"

exec node backend/src/server.js
