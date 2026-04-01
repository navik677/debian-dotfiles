#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
update_wal() {
    # Отримуємо шлях до картинки
    img=$(gsettings get org.gnome.desktop.background picture-uri-dark | sed "s/'//g;s/file:\/\///g")
    [ "$img" = "null" ] || [ -z "$img" ] && img=$(gsettings get org.gnome.desktop.background picture-uri | sed "s/'//g;s/file:\/\///g")

    # ПЕРЕВІРКА: Дозволяємо тільки JPG, PNG, WEBP
    if [[ "$img" =~ \.(jpg|jpeg|png|webp)$ ]]; then
        if [ -f "$img" ]; then
            echo "Оновлюю кольори для: $img"
            # Спроба colorthief, якщо ні - стандартний wal
            wal -i "$img" --backend colorthief || wal -i "$img"
        fi
    else
        # Якщо це XML, SVG або інший мотлох - просто ігноруємо
        echo "Пропускаю несумісний формат: $img"
    fi
}

# Перший запуск
update_wal

# Моніторинг обох ключів (світлий/темний)
stdbuf -oL gsettings monitor org.gnome.desktop.background picture-uri-dark | while read -r line; do
    update_wal
done &

stdbuf -oL gsettings monitor org.gnome.desktop.background picture-uri | while read -r line; do
    update_wal
done
