#!/bin/bash

if [ ! -f "MANIFEST" ]; then
    echo "Ошибка: MANIFEST файл не найден в текущей директории."
    exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
    [ -z "$line" ] && continue
    line=$(echo "$line" | xargs)
    
    if [ ! -e "$line" ]; then
        echo "Предупреждение: '$line' не существует в текущей директории, пропускаем."
        continue
    fi
    
    target="$HOME/$(basename "$line")"
    
    if [ -L "$target" ]; then
        echo "Symlink для '$line' уже существует в $target, пропускаем."
        continue
    fi
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Ошибка: '$target' уже существует и это не symlink, пропускаем."
        continue
    fi
    
    echo "Создаем symlink для '$line' в $target"
    ln -s "$(pwd)/$line" "$target"
    
done < "MANIFEST"

echo "Готово!"
