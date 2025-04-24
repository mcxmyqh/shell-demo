#!/bin/bash

# 加密函数
encrypt() {
    local input="$1"
    local key="$2"
    local encrypted=""
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        ascii=$(printf "%d" "'$char")
        new_ascii=$(( (ascii + key) % 256 ))
        encrypted+=$(printf "\\$(printf '%03o' "$new_ascii")")
    done
    echo "$encrypted"
}

# 解密函数
decrypt() {
    local input="$1"
    local key="$2"
    local decrypted=""
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        ascii=$(printf "%d" "'$char")
        new_ascii=$(( (ascii - key + 256) % 256 ))
        decrypted+=$(printf "\\$(printf '%03o' "$new_ascii")")
    done
    echo "$decrypted"
}

# 主程序
if [ $# -ne 3 ]; then
    echo "用法: $0 [encrypt|decrypt] <字符串> <密钥>"
    exit 1
fi

action="$1"
string="$2"
key="$3"

case $action in
    en)
        result=$(encrypt "$string" "$key")
        echo "加密后的字符串: $result"
        ;;
    de)
        result=$(decrypt "$string" "$key")
        echo "解密后的字符串: $result"
        ;;
    *)
        echo "无效的操作，请使用 encrypt 或 decrypt"
        ;;
esac
