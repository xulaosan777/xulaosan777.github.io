@echo off
:: ==========================================
::   硬核调试版发布脚本
::   特点：不隐藏报错，不猜测原因，直接显示原生日志
:: ==========================================

echo [Step 0] Setting Proxy to 7897...
:: 强制挂梯子
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897

echo.
echo [Step 1] Running: hexo clean
call hexo clean
if %errorlevel% neq 0 goto Error

echo.
echo [Step 2] Running: hexo g
:: 这里去掉了 echo off，保留所有生成日志，万一文章这步就错了能看见
call hexo g
if %errorlevel% neq 0 goto Error

echo.
echo [Step 3] Running: hexo d
echo ---------------------------------------------------
echo 正在连接 GitHub... 如果下方卡住不动，说明在握手
echo 只要出现 "Writing objects: x%" 就是正在上传
echo ---------------------------------------------------
:: 这一步是关键，如果报错，屏幕上会直接显示 fatal: ...
call hexo d
if %errorlevel% neq 0 goto Error

echo.
echo [Success] 全部流程执行成功。
echo ---------------------------------------------------
pause
exit

:Error
color 0c
echo.
echo ===================================================
echo  !!! 发生错误 (ERROR OCCURRED) !!!
echo ===================================================
echo  请向上滚动鼠标，查看上方红色的报错信息 (FATAL/Error)。
echo  截图时请务必包含上方的报错代码。
echo ===================================================
pause
exit