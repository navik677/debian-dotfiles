#!/bin/bash

# Папка, де лежать твої шпалери (зміни шлях, якщо вони в іншому місці)
WALL_DIR="$HOME/Wallpapers"

# Вибираємо випадковий файл (підтримує jpg, png, webp)
RANDOM_WALL=$(find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

# Перевіряємо, чи знайшли щось
if [ -z "$RANDOM_WALL" ]; then
    echo "Помилка: Не знайдено зображень у $WALL_DIR"
    exit 1
fi

# Встановлюємо шпалеру через налаштування GNOME
# Наш wal-watch.sh це помітить і сам запустить pywal!
gsettings set org.gnome.desktop.background picture-uri "file://$RANDOM_WALL"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$RANDOM_WALL"

echo "Нова шпалера: $RANDOM_WALL"
