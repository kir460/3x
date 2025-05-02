#!/bin/bash

# Минимальный скрипт для трёх замеров скорости до указанного Speedtest-сервера
# и вывода средних значений Download, Upload и Ping.

# Проверяем наличие Speedtest CLI и устанавливаем, если нужно
if ! command -v speedtest &>/dev/null; then
  echo "Speedtest CLI не найден. Устанавливаю официальную версию..."
  wget -qO- https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-x86_64.tgz \
    | tar xz speedtest
  chmod +x speedtest
  sudo mv speedtest /usr/local/bin/
  echo "✅ Speedtest CLI установлен."
fi

# Запрашиваем у пользователя ID сервера
read -p "Введите Server ID для теста: " SERVER_ID
if [[ -z "$SERVER_ID" ]]; then
  echo "Ошибка: Server ID не может быть пустым."
  exit 1
fi

# Переменные для накопления результатов
TotalDownload=0
TotalUpload=0
TotalPing=0
Count=0

# Три последовательных замера
for i in 1 2 3; do
  echo "=== Тест #$i ==="
  JSON=$(speedtest -s "$SERVER_ID" --format=json 2>/dev/null)
  if [[ -z "$JSON" ]]; then
    echo "⚠️ Сервер $SERVER_ID недоступен или ошибка соединения."
    continue
  fi

  # Выделяем байты/с и миллисекунды из JSON
  DL=$(echo "$JSON" | grep -Po '"download":\s*\K[0-9]+')
  UL=$(echo "$JSON" | grep -Po '"upload":\s*\K[0-9]+')
  P =$(echo "$JSON" | grep -Po '"latency":\s*\K[0-9.]+')

  if [[ -z "$DL" || -z "$UL" || -z "$P" ]]; then
    echo "⚠️ Невалидный ответ от сервера, пропускаем."
    continue
  fi

  # Конвертируем в Mbps и ms
  DL_M=$(awk "BEGIN{printf \"%.2f\", $DL/125000}")
  UL_M=$(awk "BEGIN{printf \"%.2f\", $UL/125000}")
  P_MS=$(awk "BEGIN{printf \"%.2f\", $P}")

  echo "Download: $DL_M Mbps"
  echo "Upload:   $UL_M Mbps"
  echo "Ping:     $P_MS ms"

  TotalDownload=$((TotalDownload + DL))
  TotalUpload=$((TotalUpload + UL))
  TotalPing=$(awk "BEGIN{print $TotalPing + $P}")
  Count=$((Count + 1))
done

# Вывод средних значений
if (( Count > 0 )); then
  AVG_DL=$(awk "BEGIN{printf \"%.2f\", $TotalDownload/Count/125000}")
  AVG_UL=$(awk "BEGIN{printf \"%.2f\", $TotalUpload/Count/125000}")
  AVG_P =$(awk "BEGIN{printf \"%.2f\", $TotalPing/Count}")
else
  AVG_DL=0; AVG_UL=0; AVG_P=0
fi

echo
echo "=== Итог ==="
echo "Средний Download: $AVG_DL Mbps"
echo "Средний Upload:   $AVG_UL Mbps"
echo "Средний Ping:     $AVG_P ms"
