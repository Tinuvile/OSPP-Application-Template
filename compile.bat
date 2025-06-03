@echo off
chcp 65001 > nul
title OSPP 2025 申请书编译工具

echo ============================================================
echo             OSPP 2025 申请书和个人简历编译工具
echo ============================================================
echo.

:: 检查文件是否存在
if not exist "ospp-application.tex" (
    echo 错误：未找到 ospp-application.tex 文件！
    pause
    exit /b 1
)

if not exist "personal-resume.tex" (
    echo 错误：未找到 personal-resume.tex 文件！
    pause
    exit /b 1
)

:: 创建输出目录
if not exist "output" mkdir output

echo 开始编译 OSPP 申请书...
echo ============================================================

:: 编译主申请书（使用 xelatex 以获得更好的中文支持）
echo 正在编译主申请书 (第1次)...
xelatex -output-directory=output ospp-application.tex
if %errorlevel% neq 0 (
    echo 编译失败！尝试使用 pdflatex...
    pdflatex -output-directory=output ospp-application.tex
    if %errorlevel% neq 0 (
        echo 主申请书编译失败！
        pause
        exit /b 1
    )
)

echo 正在编译主申请书 (第2次，生成目录)...
xelatex -output-directory=output ospp-application.tex > nul 2>&1
if %errorlevel% neq 0 (
    pdflatex -output-directory=output ospp-application.tex > nul 2>&1
)

echo ============================================================
echo 开始编译个人简历...
echo ============================================================

:: 编译个人简历
echo 正在编译个人简历 (第1次)...
xelatex -output-directory=output personal-resume.tex
if %errorlevel% neq 0 (
    echo 编译失败！尝试使用 pdflatex...
    pdflatex -output-directory=output personal-resume.tex
    if %errorlevel% neq 0 (
        echo 个人简历编译失败！
        pause
        exit /b 1
    )
)

echo 正在编译个人简历 (第2次，生成目录)...
xelatex -output-directory=output personal-resume.tex > nul 2>&1
if %errorlevel% neq 0 (
    pdflatex -output-directory=output personal-resume.tex > nul 2>&1
)

echo ============================================================
echo 编译完成！
echo ============================================================
echo.

:: 检查生成的文件
if exist "output\ospp-application.pdf" (
    echo ✅ 主申请书编译成功: output\ospp-application.pdf
) else (
    echo ❌ 主申请书编译失败
)

if exist "output\personal-resume.pdf" (
    echo ✅ 个人简历编译成功: output\personal-resume.pdf
) else (
    echo ❌ 个人简历编译失败
)

echo.
echo 清理临时文件...
cd output
del *.aux *.log *.out *.toc 2>nul
cd ..

echo.
echo 编译完成！生成的文件位于 output 目录中：
echo - OSPP 申请书: ospp-application.pdf
echo - 个人简历: personal-resume.pdf
echo.

:: 询问是否打开文件
echo 是否打开生成的 PDF 文件？ (Y/N)
set /p choice=
if /i "%choice%"=="Y" (
    if exist "output\ospp-application.pdf" start "" "output\ospp-application.pdf"
    if exist "output\personal-resume.pdf" start "" "output\personal-resume.pdf"
)

pause 