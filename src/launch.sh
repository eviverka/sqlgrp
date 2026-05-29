#!/bin/bash

# Жирные цвета (Bold ANSI escape-sequences)
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
PURPLE='\033[1;35m'C
NC='\033[0m'          # Сброс цвета (остается обычным)

# 2. Перебираем все папки exXX по порядку и запускаем launchSolo.sh
for folder in $(ls -d ex* 2>/dev/null | sort); do
    echo -e "${GREEN}\n=== Выполняю задание из папки $folder ===${NC}"
    # sleep 1
    
    # Вызываем ваш скрипт и передаем ему имя папки
    ./soloLaunch.sh "$folder"
    # sleep 7
done