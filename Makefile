# OSPP 2025 申请书和个人简历 Makefile
# 支持编译主申请书和个人简历

# 编译器选择
PDFLATEX = pdflatex
XELATEX = xelatex

# 源文件
MAIN_SRC = ospp-application.tex
RESUME_SRC = personal-resume.tex

# 输出目录
OUTPUT_DIR = output

# 输出文件
MAIN_PDF = $(OUTPUT_DIR)/ospp-application.pdf
RESUME_PDF = $(OUTPUT_DIR)/personal-resume.pdf

# 默认目标：编译所有文件
.PHONY: all
all: $(MAIN_PDF) $(RESUME_PDF)
	@echo ""
	@echo "✅ 所有文件编译完成！"
	@echo "📄 主申请书: $(MAIN_PDF)"
	@echo "📄 个人简历: $(RESUME_PDF)"

# 编译主申请书
$(MAIN_PDF): $(MAIN_SRC) config.tex
	@echo "🔨 正在编译主申请书..."
	@mkdir -p $(OUTPUT_DIR)
	@$(XELATEX) -output-directory=$(OUTPUT_DIR) $(MAIN_SRC) || \
		(echo "⚠️  XeLaTeX 失败，尝试 PDFLaTeX..." && $(PDFLATEX) -output-directory=$(OUTPUT_DIR) $(MAIN_SRC))
	@echo "🔄 第二次编译（生成目录）..."
	@$(XELATEX) -output-directory=$(OUTPUT_DIR) $(MAIN_SRC) > /dev/null 2>&1 || \
		$(PDFLATEX) -output-directory=$(OUTPUT_DIR) $(MAIN_SRC) > /dev/null 2>&1
	@echo "✅ 主申请书编译完成: $(MAIN_PDF)"

# 编译个人简历
$(RESUME_PDF): $(RESUME_SRC) config.tex
	@echo "🔨 正在编译个人简历..."
	@mkdir -p $(OUTPUT_DIR)
	@$(XELATEX) -output-directory=$(OUTPUT_DIR) $(RESUME_SRC) || \
		(echo "⚠️  XeLaTeX 失败，尝试 PDFLaTeX..." && $(PDFLATEX) -output-directory=$(OUTPUT_DIR) $(RESUME_SRC))
	@echo "🔄 第二次编译（生成目录）..."
	@$(XELATEX) -output-directory=$(OUTPUT_DIR) $(RESUME_SRC) > /dev/null 2>&1 || \
		$(PDFLATEX) -output-directory=$(OUTPUT_DIR) $(RESUME_SRC) > /dev/null 2>&1
	@echo "✅ 个人简历编译完成: $(RESUME_PDF)"

# 单独编译目标
.PHONY: main resume application
main application: $(MAIN_PDF)

resume: $(RESUME_PDF)

# 使用 XeLaTeX 编译（推荐，中文支持更好）
.PHONY: xeall xemain xeresume
xeall: XELATEX = xelatex
xeall: all

xemain: XELATEX = xelatex
xemain: $(MAIN_PDF)

xeresume: XELATEX = xelatex
xeresume: $(RESUME_PDF)

# 使用 PDFLaTeX 编译
.PHONY: pdfall pdfmain pdfresume
pdfall: XELATEX = pdflatex
pdfall: all

pdfmain: XELATEX = pdflatex
pdfmain: $(MAIN_PDF)

pdfresume: XELATEX = pdflatex
pdfresume: $(RESUME_PDF)

# 快速编译（只编译一次，用于预览）
.PHONY: quick quickmain quickresume
quick: quickmain quickresume

quickmain:
	@echo "⚡ 快速编译主申请书..."
	@mkdir -p $(OUTPUT_DIR)
	@$(XELATEX) -output-directory=$(OUTPUT_DIR) $(MAIN_SRC) || \
		$(PDFLATEX) -output-directory=$(OUTPUT_DIR) $(MAIN_SRC)

quickresume:
	@echo "⚡ 快速编译个人简历..."
	@mkdir -p $(OUTPUT_DIR)
	@$(XELATEX) -output-directory=$(OUTPUT_DIR) $(RESUME_SRC) || \
		$(PDFLATEX) -output-directory=$(OUTPUT_DIR) $(RESUME_SRC)

# 清理临时文件
.PHONY: clean
clean:
	@echo "🧹 清理临时文件..."
	@rm -f $(OUTPUT_DIR)/*.aux $(OUTPUT_DIR)/*.log $(OUTPUT_DIR)/*.toc $(OUTPUT_DIR)/*.out 
	@rm -f $(OUTPUT_DIR)/*.fls $(OUTPUT_DIR)/*.fdb_latexmk $(OUTPUT_DIR)/*.synctex.gz
	@echo "✅ 临时文件清理完成"

# 完全清理（包括生成的PDF）
.PHONY: distclean
distclean:
	@echo "🗑️  完全清理..."
	@rm -rf $(OUTPUT_DIR)
	@echo "✅ 完全清理完成"

# 打开生成的PDF文件
.PHONY: open view show
open view show:
	@if [ -f $(MAIN_PDF) ]; then \
		echo "📖 打开主申请书..."; \
		if command -v xdg-open > /dev/null; then \
			xdg-open $(MAIN_PDF); \
		elif command -v open > /dev/null; then \
			open $(MAIN_PDF); \
		else \
			echo "请手动打开: $(MAIN_PDF)"; \
		fi; \
	else \
		echo "❌ 未找到主申请书文件，请先编译"; \
	fi
	@if [ -f $(RESUME_PDF) ]; then \
		echo "📖 打开个人简历..."; \
		if command -v xdg-open > /dev/null; then \
			xdg-open $(RESUME_PDF); \
		elif command -v open > /dev/null; then \
			open $(RESUME_PDF); \
		else \
			echo "请手动打开: $(RESUME_PDF)"; \
		fi; \
	else \
		echo "❌ 未找到个人简历文件，请先编译"; \
	fi

# 检查文件状态
.PHONY: status
status:
	@echo "📊 文件状态检查"
	@echo "=================="
	@if [ -f $(MAIN_SRC) ]; then \
		echo "✅ 主申请书源文件: $(MAIN_SRC)"; \
	else \
		echo "❌ 主申请书源文件: $(MAIN_SRC) 不存在"; \
	fi
	@if [ -f $(RESUME_SRC) ]; then \
		echo "✅ 个人简历源文件: $(RESUME_SRC)"; \
	else \
		echo "❌ 个人简历源文件: $(RESUME_SRC) 不存在"; \
	fi
	@if [ -f config.tex ]; then \
		echo "✅ 配置文件: config.tex"; \
	else \
		echo "⚠️  配置文件: config.tex 不存在"; \
	fi
	@if [ -f $(MAIN_PDF) ]; then \
		echo "✅ 主申请书PDF: $(MAIN_PDF)"; \
	else \
		echo "❌ 主申请书PDF: $(MAIN_PDF) 不存在"; \
	fi
	@if [ -f $(RESUME_PDF) ]; then \
		echo "✅ 个人简历PDF: $(RESUME_PDF)"; \
	else \
		echo "❌ 个人简历PDF: $(RESUME_PDF) 不存在"; \
	fi

# 帮助信息
.PHONY: help
help:
	@echo "OSPP 2025 申请书和个人简历编译工具"
	@echo "=================================="
	@echo ""
	@echo "编译目标："
	@echo "  all          - 编译所有文件（主申请书 + 个人简历）"
	@echo "  main         - 只编译主申请书"
	@echo "  resume       - 只编译个人简历"
	@echo ""
	@echo "编译器选择："
	@echo "  xeall        - 使用 XeLaTeX 编译所有文件（推荐）"
	@echo "  xemain       - 使用 XeLaTeX 编译主申请书"
	@echo "  xeresume     - 使用 XeLaTeX 编译个人简历"
	@echo "  pdfall       - 使用 PDFLaTeX 编译所有文件"
	@echo "  pdfmain      - 使用 PDFLaTeX 编译主申请书"
	@echo "  pdfresume    - 使用 PDFLaTeX 编译个人简历"
	@echo ""
	@echo "快速操作："
	@echo "  quick        - 快速编译所有文件（单次编译）"
	@echo "  quickmain    - 快速编译主申请书"
	@echo "  quickresume  - 快速编译个人简历"
	@echo ""
	@echo "文件管理："
	@echo "  clean        - 清理临时文件"
	@echo "  distclean    - 完全清理（包括PDF）"
	@echo "  open         - 打开生成的PDF文件"
	@echo "  status       - 检查文件状态"
	@echo ""
	@echo "示例："
	@echo "  make         - 编译所有文件"
	@echo "  make main    - 只编译主申请书"
	@echo "  make resume  - 只编译个人简历"
	@echo "  make clean   - 清理临时文件" 