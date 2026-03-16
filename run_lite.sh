#!/bin/bash
# BallonsTranslator Lite 启动脚本

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "启动 BallonsTranslator Lite..."
echo "工作目录: $SCRIPT_DIR"

# 检查 Python
if ! command -v python3 &> /dev/null; then
    echo "错误: 未找到 Python3"
    exit 1
fi

# 启动 Lite 版本
python3 lite/main.py
