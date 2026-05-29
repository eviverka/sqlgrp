#!/bin/bash

# Жирные цвета (Bold ANSI escape-sequences)
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m' # Жирный фиолетовый
NC='\033[0m'          # Сброс цвета (остается обычным)

# Проверяем, передан ли аргумент (название папки, например ex06)
if [ -z "$1" ]; then
    echo "${RED}Ошибка: Укажите папку. ${YELLOW}Пример: ./launchSolo ex06${NC}"
    exit 1
fi

# Сохраняем имя папки из аргумента
FOLDER=$1

# Ищем SQL-файл, подходящий под маску внутри этой папки
# Например, внутри ex06 ищет day*_ex06.sql
SQL_FILE=$(ls "$FOLDER"/day*_"$FOLDER".sql 2>/dev/null)

# Проверяем, нашли ли мы файл
if [ -z "$SQL_FILE" ]; then
    echo "${RED}Ошибка: В папке '$FOLDER' не найден файл, соответствующий шаблону ${YELLOW}day*_$FOLDER.sql${NC}"
    exit 1
fi

echo -e "${CYAN}=== Запуск скрипта: $SQL_FILE ===\n${NC}"
echo -e "${PURPLE}\n===КОД===\n${NC}"
cat $SQL_FILE

# sleep 2

echo -e "${PURPLE}\n\n===ВЫВОД===\n${NC}"
# Запускаем psql для найденного файла
psql -d pizza_db -f "$SQL_FILE"
