[English](README.md) | [中文](README_zh.md)

# 记账本

一款基于 **SwiftUI + SwiftData** 构建的 iOS 个人记账应用，集成 **GPT-4o** 智能识别，采用 **Material 3 Expressive** 设计系统。

## 功能特性

### 核心功能
- **数字键盘** — 快速输入支出/收入
- **分类系统** — 14+ 支出分类、7+ 收入分类，完全自定义
- **固定支出** — 年度金额自动换算为月度/季度（房贷、保险、学费等）
- **多账户** — 现金、银行卡、支付宝、微信支付，支持账户间转账

### AI 智能导入（OpenAI GPT-4o）
- **小票扫描** — 拍照或从相册选取 → GPT-4o Vision 提取商家、商品、金额
- **语音输入** — 自然语音，AI 解析金额、备注、收支类型
- **微信导入** — 粘贴聊天记录/账单文本，AI 提取所有交易
- **文件导入** — CSV、PDF、JPG、PNG — AI 驱动的 OCR 识别图片和 PDF，无 API Key 时降级为正则匹配
- **自动分类** — 识别后，AI 从用户分类列表中自动匹配最接近的分类

### 数据分析
- **多周期统计** — 月度、季度、年度
- **图表** — 饼图（分类占比）、柱状图（收支趋势）
- **分类排行** — 各分类消费占比及明细
- **数据导出** — CSV 和 JSON 格式

### 用户系统
- 本地注册/登录，使用加盐 SHA-256 哈希加密（SwiftData）
- 注册成功动画过渡
- 个性化头像选择
- 深色 / 浅色 / 跟随系统 主题切换
- 中文 / 英文 语言支持

## 技术栈

| 层级 | 技术 |
|------|-----|
| UI | SwiftUI (iOS 17+) |
| 持久化 | SwiftData |
| 图表 | Swift Charts |
| AI / OCR | OpenAI GPT-4o-mini API |
| 本地 OCR | Apple Vision 框架 |
| 语音 | Apple Speech 框架 |
| 设计系统 | Material 3 Expressive |
| 构建 | XcodeGen (`project.yml`) |

## 项目结构

```
FinanceTracker/
├── App/                          # 应用入口
│   └── FinanceTrackerApp.swift
├── DesignSystem/                 # 设计系统
│   ├── Tokens/                   # 设计令牌
│   │   ├── ColorTokens.swift     # M3 颜色（浅色/深色）
│   │   ├── TypographyTokens.swift
│   │   ├── SpacingTokens.swift   # 间距 + 圆角 + 阴影
│   │   └── FigmaTokenExport.swift
│   ├── Components/               # 可复用设计系统组件
│   │   ├── DSButton.swift        # 5 种样式
│   │   ├── DSCard.swift          # 3 种样式
│   │   ├── DSTextField.swift
│   │   ├── DSChip.swift
│   │   ├── DSNumericKeypad.swift
│   │   ├── DSSearchBar.swift
│   │   ├── DSFab.swift
│   │   └── DSBottomSheet.swift
│   └── Theme/
│       └── Theme.swift
├── Models/                       # SwiftData 数据模型
│   ├── User.swift
│   ├── Expense.swift
│   ├── ExpenseCategory.swift
│   ├── Account.swift
│   ├── Budget.swift
│   └── FixedExpense.swift
├── Views/
│   ├── Auth/                     # 登录 / 注册
│   ├── Home/                     # 首页 + 日历
│   ├── Input/                    # 记账输入 + 固定支出
│   ├── Import/                   # 拍照 / 文件 / 语音 / 微信
│   ├── Analysis/                 # 图表与统计
│   ├── Categories/               # 分类管理
│   ├── Accounts/                 # 账户管理
│   ├── Settings/                 # 设置 + API Key 配置
│   └── MainTabView.swift
├── ViewModels/
│   ├── AuthViewModel.swift
│   ├── ExpenseViewModel.swift
│   ├── AnalysisViewModel.swift
│   └── ImportViewModel.swift
├── Services/
│   ├── OpenAIOCRService.swift    # GPT-4o Vision + 文本解析 + 分类匹配
│   ├── OCRService.swift          # Apple Vision 本地 OCR
│   ├── VoiceRecognitionService.swift
│   └── DataExportService.swift
└── Utilities/
    ├── Extensions.swift
    └── LanguageManager.swift
```

## OpenAI 集成

应用可选集成 OpenAI API 以提升识别准确率。在 **设置 → AI 识别 → OpenAI API Key** 中配置密钥。

| 功能 | 有 API Key | 无 API Key |
|------|-----------|-----------|
| 小票扫描 | GPT-4o Vision（商家、商品、总价） | Apple Vision OCR + 正则 |
| 语音输入 | GPT 解析金额 + 备注 + 类型 | 本地正则提取 |
| 文件导入（PDF/图片） | GPT-4o Vision 多页识别 | Apple Vision + 正则 |
| 文本导入 | GPT 提取所有交易 | 正则逐行匹配 |
| 分类匹配 | GPT 自动选择最佳分类 | 手动选择 |

所有 AI 功能均可优雅降级 — 没有 API Key 也能完整使用应用。

## 快速开始

### 环境要求
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### 构建

```bash
open FinanceTracker.xcodeproj
```

选择 iOS 模拟器或真机，按 `Cmd + R` 运行。

### 权限
应用会请求以下权限（在 Info.plist 中配置）：
- 相机（小票扫描）
- 麦克风（语音输入）
- 语音识别
- 相册

### TestFlight

```bash
# 归档
xcodebuild clean archive \
  -project FinanceTracker.xcodeproj \
  -scheme FinanceTracker \
  -configuration Release \
  -archivePath ./build/FinanceTracker.xcarchive \
  -destination "generic/platform=iOS"

# 导出 IPA
xcodebuild -exportArchive \
  -archivePath ./build/FinanceTracker.xcarchive \
  -exportPath ./build/export \
  -exportOptionsPlist ExportOptions.plist
```

然后通过 Xcode Organizer 或 `xcrun altool` 上传。

## 设计系统

### Material 3 Expressive 令牌

完全兼容 Figma 设计变量，通过 Figma Token Studio 同步：

- **颜色**：`md-sys-color-*` — 浅色/深色模式
- **字体**：`md-sys-typescale-*` — 完整字体比例尺
- **间距**：`md-sys-spacing-*` — 8pt 栅格
- **形状**：`md-sys-shape-corner-*` — 圆角半径
- **阴影**：`md-sys-elevation-level*` — 阴影层级

### Figma 同步

内置 `FigmaTokenExport.swift` 可生成兼容 Figma Token Studio 的 JSON：

```swift
let tokens = FigmaDesignTokens.generateFullTokensJSON()
```

## Figma

| 资源 | 链接 |
|------|------|
| 组件库（设计系统） | [Figma 文件](https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker) |
| 应用页面 | [Figma 文件](https://www.figma.com/design/WtLHNC43uTh6c8jZDiLLUz/FinanceTracker-App-Screens) |
| 开发模式（查看组件） | [开发模式](https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?m=dev) |

### Figma Code Connect

本项目使用 [Figma Code Connect](https://github.com/figma/code-connect) 的 **Swift 解析器**，将 Figma 中每个设计系统组件与 SwiftUI 实现关联。开发者在 Figma Dev Mode 中查看组件时，会直接看到实际的 SwiftUI 代码片段，而非通用 CSS。

已连接 **118 个组件**，分布在 29 个 Code Connect 文件中。

#### 已连接组件

| 类别 | 组件 |
|------|-----|
| **输入** | `DSButton` · `DSTextField` · `DSSearchBar` · `DSChip` · `DSNumericKeypad` · `DSFab` |
| **布局** | `DSCard` · `DSBottomSheet` · `DSDialog` · `DSSectionHeader` · `DSNavBar` · `DSTabBar` · `DSSegmentedControl` |
| **数据展示** | `DSTransactionRow` · `DSTransactionListSection` · `DSSummaryCard` · `DSStatRow` · `DSPieChartCard` · `DSAmountDisplay` · `DSMonthNavigator` |
| **分类** | `DSCategoryCell` · `DSCategoryProgressRow` · `DSCategoryGridSection` · `DSChipRowSection` |
| **内容** | `DSEmptyState` · `DSSettingsRow` · `DSImportCard` · `DSMethodCard` |
| **图标** | `DSIcon` — 70+ 系统图标，涵盖分类、账户、导航和操作 |

#### 属性映射特性

- `@FigmaString` — 映射文本属性（标题、标签、金额）
- `@FigmaBoolean` + `hideDefault` — 条件显示/隐藏参数（如副标题、图标）
- `@FigmaEnum` — 映射变体和尺寸属性到 Swift 枚举
- `@FigmaInstance` — 映射嵌套组件实例
- 通过 `let variant` 进行变体映射 — 不同 Figma 变体对应不同代码（如 TextField 状态、FAB 尺寸）

#### 发布

```bash
# 构建 Swift 解析器并将所有 Code Connect 文件发布到 Figma
npx figma connect publish
```

配置文件为 `figma.config.json`：

```json
{
  "codeConnect": {
    "parser": "swift",
    "include": ["CodeConnect/**/*.figma.swift"],
    "swiftPackagePath": "Package.swift"
  }
}
```

Code Connect 文件位于 `CodeConnect/` 目录，Swift Package 定义在 `Package.swift`（仅供 Figma CLI 解析器使用，不用于 Xcode 工程）。

## 许可证

MIT 许可证
