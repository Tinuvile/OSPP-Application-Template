@echo off
echo OSPP LaTeX 申请书编译工具
echo ========================

echo 检查 LaTeX 环境...
pdflatex --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：未找到 pdflatex，请安装 MiKTeX 或 TeX Live
    pause
    exit /b 1
)

echo LaTeX 环境正常

if not exist output mkdir output

echo.
echo 选择编译方式：
echo 1. 使用 pdflatex 编译（推荐）
echo 2. 使用 xelatex 编译（中文支持更好，但需要更多时间）
echo 3. 快速编译（只编译一次，用于预览）
echo 4. 清理临时文件
echo 5. 完全清理（包括PDF文件）
echo.

set /p choice=请选择 (1-5): 

if "%choice%"=="1" goto pdflatex
if "%choice%"=="2" goto xelatex  
if "%choice%"=="3" goto quick
if "%choice%"=="4" goto clean
if "%choice%"=="5" goto distclean
echo 无效选择，默认使用 pdflatex
goto pdflatex

:pdflatex
echo.
echo 使用 pdflatex 编译...
pdflatex -output-directory=output ospp-application.tex
pdflatex -output-directory=output ospp-application.tex
echo.
echo 编译完成！输出文件：output\ospp-application.pdf
goto end

:xelatex
echo.
echo 使用 xelatex 编译...
xelatex -output-directory=output ospp-application.tex
xelatex -output-directory=output ospp-application.tex
echo.
echo 编译完成！输出文件：output\ospp-application.pdf
goto end

:quick
echo.
echo 快速编译...
pdflatex -output-directory=output ospp-application.tex
echo.
echo 快速编译完成！输出文件：output\ospp-application.pdf
goto end

:clean
echo.
echo 清理临时文件...
if exist output (
    del /q output\*.aux output\*.log output\*.toc output\*.out output\*.fls output\*.fdb_latexmk output\*.synctex.gz 2>nul
)
echo 临时文件清理完成！
goto end

:distclean
echo.
echo 完全清理...
if exist output rmdir /s /q output
echo 完全清理完成！
goto end

:end
echo.
echo 按任意键退出...
pause >nul 