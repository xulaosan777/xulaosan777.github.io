@echo off
echo ==========================================
echo   终极驱魔版备份脚本
echo   (专治各种疑难杂症)
echo ==========================================

:: Step 1: 杀掉所有僵尸进程 (关键！)
echo.
echo [1] 正在清理后台卡死的 Git 进程...
:: 这行命令会强制关闭所有 git.exe，防止它们占着文件
taskkill /F /IM git.exe >nul 2>&1
echo   - 后台清理完毕。

:: Step 2: 再次尝试删除锁文件
echo.
echo [2] 正在粉碎锁文件 (index.lock)...
if exist ".git\index.lock" (
    del /f /q /a ".git\index.lock"
    echo   - 锁文件已强制删除！
) else (
    echo   - 没发现锁文件，很安全。
)

:: Step 3: 挂梯子
echo.
echo [3] 设置代理 (7897)...
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897

:: Step 4: 打包
echo.
echo [4] 正在打包 (git commit)...
git add .
set /p msg="请输入更新说明(回车默认): "
if "%msg%"=="" set msg=ForceUpdate-%date:~0,4%%date:~5,2%%date:~8,2%
git commit -m "%msg%"

:: Step 5: 推送
echo.
echo [5] 正在推送 (git push)...
echo ------------------------------------------
echo 只要看到下面的 "Writing objects" 进度条，就是成功了！
echo ------------------------------------------
git push origin HEAD:hexo-source

echo.
echo ==========================================
echo  执行结束。
echo ==========================================
pause