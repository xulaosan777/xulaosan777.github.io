@echo off
setlocal
echo ==========================================
echo   Hexo 终极净化脚本
echo   (自动屏蔽 node_modules 并强制重置)
echo ==========================================

:: 1. 暴力清理旧仓库 (防止旧记录干扰)
echo [1/7] 正在清除旧的 .git 记录...
if exist ".git" rmdir /s /q ".git"

:: 2. 创建黑名单 .gitignore (最关键的一步！)
echo [2/7] 正在创建黑名单 (.gitignore)...
:: 只要这行命令执行了，node_modules 就再也进不去仓库了
(
echo .DS_Store
echo Thumbs.db
echo db.json
echo *.log
echo node_modules/
echo public/
echo .deploy*/
) > .gitignore
echo   - 黑名单已生成，node_modules 已被屏蔽。

:: 3. 重新初始化仓库
echo.
echo [3/7] 重新初始化 (git init)...
git init
git checkout -b main

:: 4. 挂梯子 (必须!)
echo [4/7] 设置代理 (7897)...
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897

:: 5. 重新添加文件
echo.
echo [5/7] 正在添加文件...
:: 这一步会自动忽略 node_modules，所以速度会变快，也不会报错
git add .

:: 6. 打包
echo [6/7] 正在打包...
git commit -m "重置仓库：已移除 node_modules 违禁文件"

:: 7. 强制推送
echo.
echo [7/7] 正在连接 GitHub 发射...
echo ------------------------------------------
git remote add origin https://github.com/xulaosan777/xulaosan777.github.io.git
git push -f origin HEAD:hexo-source

echo.
if %errorlevel% neq 0 (
    color 0c
    echo [失败] 还是不行？请截图。
) else (
    color 0a
    echo ==========================================
    echo  [大功告成] 终于传上去了！
    echo  那个该死的 node_modules 已经被彻底甩掉了。
    echo  以后请直接用“备份源码.bat”即可。
    echo ==========================================
)
pause