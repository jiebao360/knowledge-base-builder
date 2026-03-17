@echo off
REM 个人知识库建设技能 - 安装脚本 (Windows)
REM 版本：v1.0.0
REM 作者：来合火
REM 创建时间：2026-03-18

echo 🦞 开始安装个人知识库建设技能...

REM 检查 Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ 错误：未找到 Node.js，请先安装 Node.js
    exit /b 1
)

for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
echo ✅ Node.js 版本：%NODE_VERSION%

REM 检查 npm
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ 错误：未找到 npm
    exit /b 1
)

for /f "tokens=*" %%i in ('npm -v') do set NPM_VERSION=%%i
echo ✅ npm 版本：%NPM_VERSION%

REM 获取脚本所在目录
set SCRIPT_DIR=%~dp0

REM 安装目录
set INSTALL_DIR=%USERPROFILE%\.agents\skills\knowledge-base-builder

echo 📁 安装目录：%INSTALL_DIR%

REM 创建安装目录
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)

REM 复制文件
echo 📦 复制技能文件...
xcopy /E /I /Y "%SCRIPT_DIR%"* "%INSTALL_DIR%"

REM 安装依赖
echo 📦 安装依赖...
cd /d "%INSTALL_DIR%"
call npm install --production

REM 验证安装
echo ✅ 验证安装...
if exist "%INSTALL_DIR%\index.js" (
    if exist "%INSTALL_DIR%\SKILL.md" (
        echo ✅ 技能安装成功！
        echo.
        echo 📖 使用方法：
        echo   在 OpenClaw 对话中发送：帮我搭建个人知识库
        echo.
        echo 📚 查看文档：
        echo   type "%INSTALL_DIR%\README.md"
        echo.
        echo 🔧 配置文件：
        echo   %INSTALL_DIR%\config\
        echo.
    ) else (
        echo ❌ 技能安装失败！
        exit /b 1
    )
) else (
    echo ❌ 技能安装失败！
    exit /b 1
)

echo 🎉 安装完成！
pause
