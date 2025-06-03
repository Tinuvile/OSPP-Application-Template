# OSPP LaTeX 申请书 Makefile
# 支持 Windows PowerShell 和 Unix 系统

# 检测操作系统
ifeq ($(OS),Windows_NT)
    # Windows 系统
    RM = powershell -Command "Remove-Item -Force -Recurse"
    LATEX = pdflatex
    XELATEX = xelatex
    MKDIR = powershell -Command "New-Item -ItemType Directory -Force"
else
    # Unix 系统 (Linux/macOS)
    RM = rm -f
    LATEX = pdflatex
    XELATEX = xelatex
    MKDIR = mkdir -p
endif

# 主文件名（不含扩展名）
MAIN = ospp-application

# 输出目录
OUTPUT_DIR = output

# 默认目标：编译 PDF
all: $(OUTPUT_DIR)/$(MAIN).pdf

# 使用 pdflatex 编译
pdf: $(OUTPUT_DIR)/$(MAIN).pdf

# 使用 xelatex 编译（推荐，中文支持更好）
xepdf: $(OUTPUT_DIR)/$(MAIN)-xe.pdf

# pdflatex 编译规则
$(OUTPUT_DIR)/$(MAIN).pdf: $(MAIN).tex
	@echo "开始使用 pdflatex 编译..."
	@$(MKDIR) $(OUTPUT_DIR)
	$(LATEX) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	$(LATEX) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	@echo "编译完成！输出文件: $(OUTPUT_DIR)/$(MAIN).pdf"

# xelatex 编译规则
$(OUTPUT_DIR)/$(MAIN)-xe.pdf: $(MAIN).tex
	@echo "开始使用 xelatex 编译..."
	@$(MKDIR) $(OUTPUT_DIR)
	$(XELATEX) -output-directory=$(OUTPUT_DIR) -jobname=$(MAIN)-xe $(MAIN).tex
	$(XELATEX) -output-directory=$(OUTPUT_DIR) -jobname=$(MAIN)-xe $(MAIN).tex
	@echo "编译完成！输出文件: $(OUTPUT_DIR)/$(MAIN)-xe.pdf"

# 快速编译（只编译一次，用于快速预览）
quick: $(MAIN).tex
	@echo "快速编译..."
	@$(MKDIR) $(OUTPUT_DIR)
	$(LATEX) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	@echo "快速编译完成！"

# 清理临时文件
clean:
	@echo "清理临时文件..."
ifeq ($(OS),Windows_NT)
	@powershell -Command "if (Test-Path '$(OUTPUT_DIR)') { Remove-Item -Force -Recurse '$(OUTPUT_DIR)/*.aux', '$(OUTPUT_DIR)/*.log', '$(OUTPUT_DIR)/*.toc', '$(OUTPUT_DIR)/*.out', '$(OUTPUT_DIR)/*.fls', '$(OUTPUT_DIR)/*.fdb_latexmk', '$(OUTPUT_DIR)/*.synctex.gz' -ErrorAction SilentlyContinue }"
else
	@find $(OUTPUT_DIR) -name "*.aux" -o -name "*.log" -o -name "*.toc" -o -name "*.out" -o -name "*.fls" -o -name "*.fdb_latexmk" -o -name "*.synctex.gz" | xargs rm -f 2>/dev/null || true
endif
	@echo "临时文件清理完成！"

# 完全清理（包括 PDF 文件）
distclean:
	@echo "完全清理..."
ifeq ($(OS),Windows_NT)
	@powershell -Command "if (Test-Path '$(OUTPUT_DIR)') { Remove-Item -Force -Recurse '$(OUTPUT_DIR)' }"
else
	$(RM) -r $(OUTPUT_DIR)
endif
	@echo "完全清理完成！"

# 创建示例目录和文件
example:
	@echo "创建示例..."
	@$(MKDIR) example
	@echo "示例目录创建完成！"

# 检查 LaTeX 环境
check:
	@echo "检查 LaTeX 环境..."
	@echo "=== pdflatex 版本 ==="
	@$(LATEX) --version || echo "pdflatex 未安装"
	@echo ""
	@echo "=== xelatex 版本 ==="
	@$(XELATEX) --version || echo "xelatex 未安装"
	@echo ""
	@echo "环境检查完成！"

# 帮助信息
help:
	@echo "OSPP LaTeX 申请书编译工具"
	@echo ""
	@echo "可用命令："
	@echo "  make          - 使用 pdflatex 编译 PDF（默认）"
	@echo "  make pdf      - 使用 pdflatex 编译 PDF"
	@echo "  make xepdf    - 使用 xelatex 编译 PDF（推荐）"
	@echo "  make quick    - 快速编译预览"
	@echo "  make clean    - 清理临时文件"
	@echo "  make distclean- 完全清理（包括 PDF）"
	@echo "  make check    - 检查 LaTeX 环境"
	@echo "  make example  - 创建示例目录"
	@echo "  make help     - 显示此帮助信息"
	@echo ""
	@echo "推荐使用 'make xepdf' 编译，中文支持更好！"

# 声明伪目标
.PHONY: all pdf xepdf quick clean distclean example check help 