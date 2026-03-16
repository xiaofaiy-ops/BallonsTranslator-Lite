#!/bin/bash
# BallonsTranslator Lite Build Script for macOS
# 在 macOS 上运行此脚本生成 DMG

set -e

echo "========================================="
echo "  BallonsTranslator Lite - DMG Builder"
echo "========================================="

# 检查系统
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "错误: 此脚本需要在 macOS 上运行"
    exit 1
fi

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$SCRIPT_DIR"

echo "项目目录: $PROJECT_DIR"

# 检查 Python
if ! command -v python3 &> /dev/null; then
    echo "错误: 未找到 Python3，请先安装"
    exit 1
fi

echo "Python 版本: $(python3 --version)"

# 安装依赖
echo "正在安装依赖..."
cd "$PROJECT_DIR"

# 安装 PyQt6
pip3 install PyQt6

# 安装 PyInstaller
pip3 install pyinstaller

# 创建 .app bundle
echo "正在创建应用包..."

# 创建 Info.plist
mkdir -p BallonsTranslatorLite.app/Contents
mkdir -p BallonsTranslatorLite.app/Contents/MacOS
mkdir -p BallonsTranslatorLite.app/Contents/Resources

cat > BallonsTranslatorLite.app/Contents/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>BallonsTranslatorLite</string>
    <key>CFBundleIconFile</key>
    <string>icon.icns</string>
    <key>CFBundleIdentifier</key>
    <string>com.ballonstranslator.lite</string>
    <key>CFBundleName</key>
    <string>BallonsTranslator Lite</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
EOF

# 创建启动脚本
cat > BallonsTranslatorLite.app/Contents/MacOS/BallonsTranslatorLite << 'EOF'
#!/bin/bash
cd "$(dirname "$0)/../Resources"
python3 "$SCRIPT_DIR/lite/main.py"
EOF

chmod +x BallonsTranslatorLite.app/Contents/MacOS/BallonsTranslatorLite

# 复制资源
cp -r lite BallonsTranslatorLite.app/Contents/Resources/

# 使用 PyInstaller 打包
echo "正在使用 PyInstaller 打包..."
pyinstaller --name BallonsTranslatorLite \
    --onefile \
    --windowed \
    --add-data "lite:lite" \
    --osx-bundle-identifier "com.ballonstranslator.lite" \
    lite/main.py

# 创建 DMG
echo "正在创建 DMG..."
if command -v create-dmg &> /dev/null; then
    create-dmg BallonsTranslatorLite.dmg "dist/BallonsTranslatorLite.app"
else
    # 使用内置工具
    hdiutil create -volname "BallonsTranslatorLite" -srcfolder "dist/BallonsTranslatorLite.app" -ov -format UDZO BallonsTranslatorLite.dmg
fi

echo ""
echo "========================================="
echo "  ✅ 构建完成!"
echo "========================================="
echo "输出文件: BallonsTranslatorLite.dmg"
echo ""
echo "双击 .dmg 文件，将 BallonsTranslatorLite.app 拖到 Applications 即可使用"
