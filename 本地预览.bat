@echo off
:: ==========================================
::   硬核版本地预览脚本
::   特点：自动打开浏览器、报错死磕、清理缓存
:: ==========================================

echo [Step 1] Cleaning cache (hexo clean)...
call hexo clean
if %errorlevel% neq 0 goto Error

echo.
echo [Step 2] Starting Local Server (hexo s)...
echo ---------------------------------------------------
echo  [提示] 服务器启动需要几秒钟...
echo  [提示] 3秒后将自动尝试打开浏览器 (http://localhost:4000)
echo  [提示] 如果想停止预览，请在这个黑框里按 Ctrl + C
echo ---------------------------------------------------

:: --- 骚操作：启动一个独立的倒计时任务，3秒后自动打开网页 ---
start "" cmd /c "timeout /t 3 >nul && start http://localhost:4000"

:: --- 启动 Hexo 服务器 (这一步会一直运行，直到你关闭窗口) ---
call hexo s
if %errorlevel% neq 0 goto Error

:: 正常关闭
exit

:Error
color 0c
echo.
echo ===================================================
echo  !!! 启动失败 (ERROR) !!!
echo ===================================================
echo  常见原因：
echo  1. 端口 4000 被占用了（你是不是开了另一个预览窗口没关？）
echo  2. _config.yml 配置文件里有语法错误
echo ===================================================
echo  具体报错信息请看上方：
echo.
pause
exit