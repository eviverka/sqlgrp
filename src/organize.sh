#!/bin/bash

# Перебираем все SQL-файлы, которые соответствуют шаблону dayXX_exXX.sql
for file in day*_ex*.sql; do
    # Проверяем, существует ли файл (на случай, если в папке вообще нет таких файлов)
    [ -e "$file" ] || continue

    # Извлекаем имя папки: убираем .sql и всё, что идет до _exXX
    # Например, из "day04_ex01.sql" останется только "ex01"
    folder_name=$(basename "$file" .sql | sed 's/.*_//')

    # Создаем папку (флаг -p не выдаст ошибку, если папка уже есть)
    mkdir -p "$folder_name"

    # Переносим файл в созданную папку
    mv "$file" "$folder_name/"

    echo "Файл $file успешно перенесен в папку $folder_name"
done

