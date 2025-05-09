#!/bin/bash

if [ ! -f "MANIFEST" ]; then
    echo "Ошибка: MANIFEST файл не найден в текущей директории."
    exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
    [ -z "$line" ] && continue
    line=$(echo "$line" | xargs)
    name=$(basename "$line")
    symlink_path="$HOME/$name"

    if [ -L "$symlink_path" ]; then
        echo "Удаляем symlink: $symlink_path"
        rm "$symlink_path"
    elif [ -e "$symlink_path" ]; then
        echo "Предупреждение: '$symlink_path' существует, но это не symlink, пропускаем."
    else
        echo "Инфо: '$symlink_path' не существует, пропускаем."
    fi
    
done < "MANIFEST"

echo "Готово!"
