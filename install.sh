#!/bin/bash

# Кольори для красивого виводу
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Починаємо встановлення твого Debian...${NC}"

# 1. Встановлення необхідних пакунків
echo -e "${BLUE}📦 Встановлюємо залежності...${NC}"
sudo apt update
sudo apt install -y kitty python3-pip pipx imagemagick python3-setuptools
pipx install pywal16 --force

# 2. Створення структури папок
echo -e "${BLUE}📂 Створюємо папки конфігів...${NC}"
mkdir -p ~/.config/kitty
mkdir -p ~/.local/bin
mkdir -p ~/.config/autostart
mkdir -p ~/Wallpapers

# 3. Копіювання файлів (символічні посилання для зручності)
echo -e "${BLUE}🔗 Прив'язуємо конфіги...${NC}"
# Використовуємо -sf для примусового створення посилання
ln -sf ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/local/bin/wal-watch.sh ~/.local/bin/wal-watch.sh
ln -sf ~/dotfiles/local/bin/random-wall.sh ~/.local/bin/random-wall.sh
ln -sf ~/dotfiles/config/wallpaper-watcher.desktop ~/.config/autostart/wallpaper-watcher.desktop

# 4. Даємо права на виконання
echo -e "${BLUE}🔑 Надаємо права скриптам...${NC}"
chmod +x ~/.local/bin/*.sh
chmod +x ~/.config/autostart/*.desktop

# 5. Перевірка Kitty config для Pywal
if ! grep -q "include ~/.cache/wal/colors-kitty.conf" ~/.config/kitty/kitty.conf; then
    echo 'include ~/.cache/wal/colors-kitty.conf' >> ~/.config/kitty/kitty.conf
    echo -e "${GREEN}✅ Додано імпорт кольорів у kitty.conf${NC}"
fi

echo -e "${GREEN}✨ Встановлення завершено! Перезавантаж систему або зроби Logout/Login.${NC}"
