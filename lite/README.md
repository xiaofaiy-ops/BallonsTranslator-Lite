# BallonsTranslator Lite

简化版漫画翻译工具，基于 [BallonsTranslator](https://github.com/dmMaze/BallonsTranslator) 开发。

## 功能特点

- 🎨 **简洁界面** - 去除复杂编辑功能，保留核心翻译
- 📁 **拖放支持** - 拖放图片或点击选择
- 🌐 **多语言支持** - 日/英/中/韩互译
- ⚡ **一键翻译** - 简单快捷

---

## macOS 安装指南 (DMG)

### 方式一: 下载预构建的 DMG (推荐)

1. 从 Release 页面下载 `BallonsTranslatorLite.dmg`
2. 双击打开 DMG
3. 将 `BallonsTranslatorLite.app` 拖到 Applications 文件夹
4. 首次运行可能需要在系统偏好设置中允许"任何来源"应用

### 方式二: 自行构建 DMG

如果需要自定义，可以从源码构建：

```bash
# 1. 克隆或下载源码
git clone https://github.com/your-repo/BallonsTranslator.git
cd BallonsTranslator/lite

# 2. 运行构建脚本
chmod +x build_dmg.sh
./build_dmg.sh
```

构建需要:
- macOS 10.15+
- Python 3.9+
- Xcode Command Line Tools

---

## 开发运行

```bash
# 安装依赖
pip install -r ../requirements.txt
pip install PyQt6

# 运行
python3 main.py
```

---

## 项目结构

```
lite/
├── main.py          # 主程序
├── SPEC.md          # 规格说明
├── build_dmg.sh     # macOS DMG 构建脚本
├── build.spec       # PyInstaller 配置
└── README.md        # 本文件
```

---

## 注意事项

- 首次运行需要下载翻译模型，请确保网络连接
- 如果遇到权限问题，在终端运行: `sudo spctl --master-disable`
- 翻译核心功能需要安装完整的 BallonsTranslator 依赖
