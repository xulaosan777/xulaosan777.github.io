@echo off
echo ==========================================
echo   Git 仓库重置工具 (核弹级修复)
echo   注意：这会把本地当前状态强制覆盖到 GitHub
echo ==========================================

:: 1. 确保 .git 真的删干净了 (防止你没删全)
if exist ".git" (
    echo [1/6] 正在清理旧的 .git 文件夹...
    rmdir /s /q ".git"
)

:: 2. 重新初始化
echo [2/6] 正在重新初始化仓库 (git init)...
git init
:: 这里的 -b main 是为了防止默认叫 master 导致混乱
git checkout -b main

:: 3. 挂梯子 (必须!)
echo [3/6] 设置代理 (7897)...
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897

:: 4. 重新连接 GitHub
echo [4/6] 正在关联远程仓库...
:: 我根据你之前的截图，帮你填好了你的仓库地址
git remote add origin https://github.com/xulaosan777/xulaosan777.github.io.git

:: 5. 重新打包所有文件
echo [5/6] 正在打包当前文件 (干干净净的版本)...
git add .
git commit -m "重置仓库历史，清除敏感信息"

:: 6. 强制推送 (核弹发射)
echo [6/6] 正在强制覆盖远程分支 (git push -f)...
echo ------------------------------------------
echo 注意：这一步会强制把 GitHub 上的 hexo-source 分支
echo 替换成你现在电脑上的样子，之前的脏记录全都会消失。
echo ------------------------------------------
git push -f origin HEAD:hexo-source

echo.
if %errorlevel% neq 0 (
    color 0c
    echo [失败] 还是传不上去？请截图给我。
) else (
    color 0a
    echo ==========================================
    echo  [大功告成] 仓库已起死回生！历史记录已洗白。
    echo  以后你可以继续用之前的“备份源码.bat”了。
    echo ==========================================
)
pause