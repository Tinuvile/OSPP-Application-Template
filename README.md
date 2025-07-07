# OSPP 申请书 LaTeX 模板

这是一个专门为**开源软件供应链点亮计划（OSPP）** 设计的 LaTeX 申请书模板。

## 📁 文件结构

```
OSPP-Application-Template/
├── ospp-application.tex    # 主模板文件
├── personal-resume.tex     # 独立个人简历文件
├── config.tex             # 配置文件（个人信息设置）
├── examples.tex           # 示例代码库
├── README.md              # 使用说明
├── Makefile              # Linux/macOS 编译脚本
├── compile.bat           # Windows 编译脚本
├── image/                # 图片资源目录
│   └── OSPP.png          # OSPP官方图标
└── output/               # 编译输出目录
    ├── ospp-application.pdf
    └── personal-resume.pdf
```

## 🚀 快速开始

### 环境要求

- Windows: MiKTeX 或 TeX Live
- macOS: MacTeX
- Linux: TeX Live

### 编译方法

1. **使用编译脚本（推荐）**：

   - Windows: 双击运行 `compile.bat`
   - Linux/macOS: 运行 `make` 或 `make all`

2. **单独编译主申请书**：

   ```bash
   # Linux/macOS
   make main

   # Windows 手动编译
   xelatex -output-directory=output ospp-application.tex
   xelatex -output-directory=output ospp-application.tex
   ```

3. **单独编译个人简历**：

   ```bash
   # Linux/macOS
   make resume

   # Windows 手动编译
   xelatex -output-directory=output personal-resume.tex
   xelatex -output-directory=output personal-resume.tex
   ```

4. **使用 XeLaTeX（推荐，中文支持更好）**：

   ```bash
   # 编译所有文件
   make xeall

   # 或分别编译
   make xemain    # 主申请书
   make xeresume  # 个人简历
   ```

## ⚙️ 个人信息配置

在 `config.tex` 文件中修改您的信息：

```latex
% 个人基本信息
\renewcommand{\studentname}{张三}
\renewcommand{\studentid}{2021123456}
\renewcommand{\studentemail}{zhangsan@example.com}
\renewcommand{\studentphone}{138-0000-0000}
\renewcommand{\studentuniversity}{某某大学}
\renewcommand{\studentmajor}{计算机科学与技术}

% 项目相关信息
\renewcommand{\projecttitle}{基于深度学习的开源项目漏洞检测系统}
\renewcommand{\communityname}{Apache Software Foundation}
\renewcommand{\mentorname}{李导师}
\renewcommand{\mentoremail}{liteacher@apache.org}
\renewcommand{\projectdifficulty}{进阶}
\renewcommand{\projectreward}{12000元}
```

### 彩色文本框

模板提供了三种样式的文本框：

```latex
% 提示框（蓝色）
\begin{tipbox}
这里是重要提示信息
\end{tipbox}

% 警告框（橙色）
\begin{warningbox}
这里是需要注意的事项
\end{warningbox}

% 信息框（蓝色）
\begin{infobox}
这里是补充信息
\end{infobox}
```

### 自定义命令

```latex
\highlight{重要内容}      % 蓝色加粗
\important{重要警告}      % 红色加粗
\note{备注信息}          % 灰色斜体
\code{代码内容}          % 等宽字体
```

## 📝 内容填写指南

### 1. 项目概述

- **项目背景**：描述技术领域、存在问题、重要性
- **项目目标**：明确具体目标
- **预期成果**：代码贡献、文档更新、性能提升等

### 2. 技术方案

- **现有项目架构分析**：拆解目标项目，描述各模块功能
- **需求分析**：功能需求和非功能需求
- **解决方案设计**：详细的实现方案
- **技术难点与解决策略**：预期困难和应对方法
- **参考资料**：相关论文、项目、文档（提升申请竞争力）

### 3. 时间规划

- **项目阶段划分**：4 个大阶段，每阶段 4 周
- **详细周计划**：每周具体任务，粒度不超过 1 周
- **风险评估**：预留 15%弹性时间

### 4. 个人简历

- **基本信息**：必填 GitHub/Gitee 用户 ID
- **教育背景**：学校、专业、成绩
- **技术技能**：编程语言、框架、工具
- **项目经验**：开源贡献、个人项目
- **竞赛获奖**：相关比赛和荣誉

### 5. 申请动机

- **选择原因**：为什么选择这个项目
- **期望目标**：技术和个人发展目标
- **承诺保证**：时间投入和质量保证

## 🎨 自定义样式

### 颜色设置

```latex
% OSPP 官方主题色
\definecolor{osppblue}{RGB}{51, 122, 183}      % 主蓝色
\definecolor{osppgray}{RGB}{108, 117, 125}     % 灰色
\definecolor{ospplight}{RGB}{248, 249, 250}    % 浅色背景
\definecolor{osppdark}{RGB}{52, 58, 64}        % 深色文字

% 辅助颜色
\definecolor{successgreen}{RGB}{40, 167, 69}   % 成功绿色
\definecolor{warningorange}{RGB}{255, 193, 7}  % 警告橙色
\definecolor{dangerred}{RGB}{220, 53, 69}      % 危险红色
```

### 页面布局

```latex
\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}
```

## 📊 图表和表格

### 甘特图示例

模板包含使用 `pgfgantt` 包创建的项目时间规划甘特图。

### 技术架构图

使用 `tikz` 包创建的系统架构图示例。

### 表格

各种表格样式用于：

- 项目模块分析
- 现有模块修改计划
- 新增模块设计
- 项目阶段划分
- 技能评估矩阵
- 风险评估矩阵

## 🔧 故障排除

### 常见问题

1. **中文显示问题**

   ```bash
   # 使用XeLaTeX编译
   xelatex ospp-application.tex
   ```

2. **字体缺失**

   - Windows: 安装中文字体包
   - macOS: 使用系统自带字体
   - Linux: 安装 `fonts-wqy-microhei` 包

3. **包缺失错误**

   ```bash
   # MiKTeX自动安装
   # TeX Live手动安装
   tlmgr install pgfgantt tikz ctex fontawesome5 tcolorbox
   ```

4. **编译缓慢**
   - 第一次编译需要下载包，较慢
   - 后续编译速度会提升

## 📋 检查清单

申请书提交前请检查：

- [ ] 个人信息填写完整准确
- [ ] 项目技术方案详细具体
- [ ] 时间规划合理可行
- [ ] 简历信息与项目相关
- [ ] GitHub/Gitee 链接有效
- [ ] 文档编译无错误
- [ ] PDF 格式正确
- [ ] 使用了模板提供的美化功能
- [ ] 参考了示例代码库中的格式

## 🎯 基于 Gonzalo Medina 等优秀模板

本模板参考了以下优秀的 LaTeX 模板和技术：

- **Gonzalo Medina** 的甘特图模板设计
- **pgfgantt** 包的时间规划图表
- **tcolorbox** 包的现代化文本框设计
- **Material Design** 的配色方案
- 各种开源项目申请书的最佳实践

## 🤝 贡献与反馈

如果您有任何建议或发现问题，欢迎：

- 提交 Issue
- 发起 Pull Request

## 📜 许可证

本模板基于 MIT 许可证开源，您可以自由使用、修改和分享。

## 🔗 相关链接

- [OSPP 官方网站](https://summer-ospp.ac.cn/)
- [申请建议文档](https://blog.summer-ospp.ac.cn/help/student%20application%20advice)
- [LaTeX 官方文档](https://www.latex-project.org/)
- [CTex 宏包说明](https://ctan.org/pkg/ctex)
- [PGF/TikZ 文档](https://ctan.org/pkg/pgf)
- [tcolorbox 文档](https://ctan.org/pkg/tcolorbox)

---

**祝申请成功！🎉**

如有疑问，请查看官方申请指南或联系 OSPP 组委会。
