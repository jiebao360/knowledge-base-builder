#!/bin/bash

# 个人知识库建设技能 - 安装脚本 (Mac/Linux)
# 版本：v1.0.0
# 作者：来合火
# 创建时间：2026-03-18

set -e

echo "🦞 开始安装个人知识库建设技能..."

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ 错误：未找到 Node.js，请先安装 Node.js"
    exit 1
fi

echo "✅ Node.js 版本：$(node -v)"

# 检查 npm
if ! command -v npm &> /dev/null; then
    echo "❌ 错误：未找到 npm"
    exit 1
fi

echo "✅ npm 版本：$(npm -v)"

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 安装目录
INSTALL_DIR="$HOME/.agents/skills/knowledge-base-builder"

echo "📁 安装目录：$INSTALL_DIR"

# 创建安装目录
mkdir -p "$INSTALL_DIR"

# 复制文件
echo "📦 复制技能文件..."
cp -r "$SCRIPT_DIR"/* "$INSTALL_DIR/"

# 安装依赖
echo "📦 安装依赖..."
cd "$INSTALL_DIR"
npm install --production

# 设置执行权限
chmod +x index.js

# 验证安装
echo "✅ 验证安装..."
if [ -f "$INSTALL_DIR/index.js" ] && [ -f "$INSTALL_DIR/SKILL.md" ]; then
    echo "✅ 技能安装成功！"
    echo ""
    echo "📖 使用方法："
    echo "  在 OpenClaw 对话中发送：帮我搭建个人知识库"
    echo ""
    echo "📚 查看文档："
    echo "  cat $INSTALL_DIR/README.md"
    echo ""
    echo "🔧 配置文件："
    echo "  $INSTALL_DIR/config/"
    echo ""
else
    echo "❌ 技能安装失败！"
    exit 1
fi

echo "🎉 安装完成！"
