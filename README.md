# 记账本 - Finance Tracker

一款基于 **SwiftUI + SwiftData** 构建的 iOS 记账应用，采用 **Material 3 Expressive** 设计系统，界面极简优美。

## 功能特性

### 核心功能
- **数字键盘记账** - 快速输入支出/收入金额
- **二级分类系统** - 14+ 支出分类、7+ 收入分类，支持自定义
- **固定开支管理** - 输入年度金额，自动计算月/季费用（房贷、保险、学费等）
- **多账户管理** - 现金、银行卡、支付宝、微信等，支持账户间转账

### 智能导入
- **拍照记账** - 拍摄收据，OCR 自动识别金额
- **截图记账** - 导入截图识别账单
- **语音记账** - 说出消费信息，自动解析金额
- **微信导入** - 粘贴微信对话/账单，自动提取
- **文件导入** - 支持 CSV、PDF、JPG、PNG 格式

### 数据分析
- **多维度统计** - 月度/季度/年度分析
- **图表可视化** - 饼图（分类构成）、柱状图（收支趋势）
- **分类排行** - 各分类支出占比和明细
- **数据导出** - CSV/JSON 格式导出

### 用户系统
- 本地注册/登录（SwiftData 存储）
- 个性化头像选择
- 深色/浅色模式切换

## 技术架构

### 技术栈
| 层级 | 技术 |
|------|------|
| UI 框架 | SwiftUI (iOS 17+) |
| 数据持久化 | SwiftData |
| 图表 | Swift Charts |
| OCR | Vision Framework |
| 语音识别 | Speech Framework |
| 设计系统 | Material 3 Expressive |

### 项目结构
```
FinanceTracker/
├── App/                          # App 入口
│   └── FinanceTrackerApp.swift
├── DesignSystem/                 # 设计系统
│   ├── Tokens/                   # 设计 Token
│   │   ├── ColorTokens.swift     # M3 色彩（Light/Dark）
│   │   ├── TypographyTokens.swift # M3 字体
│   │   ├── SpacingTokens.swift   # 间距 + 圆角 + 阴影
│   │   └── FigmaTokenExport.swift # Figma 兼容导出
│   ├── Components/               # 通用组件
│   │   ├── DSButton.swift        # 按钮（5种变体）
│   │   ├── DSCard.swift          # 卡片（3种变体）
│   │   ├── DSTextField.swift     # 输入框
│   │   ├── DSChip.swift          # 标签
│   │   ├── DSNumericKeypad.swift # 数字键盘
│   │   ├── DSSearchBar.swift     # 搜索栏
│   │   ├── DSFab.swift           # FAB 按钮
│   │   └── DSBottomSheet.swift   # 底部弹窗
│   └── Theme/
│       └── Theme.swift           # 主题配置
├── Models/                       # SwiftData 模型
│   ├── User.swift
│   ├── Expense.swift
│   ├── ExpenseCategory.swift
│   ├── Account.swift
│   ├── Budget.swift
│   └── FixedExpense.swift
├── Views/                        # 视图层
│   ├── Auth/                     # 登录/注册
│   ├── Home/                     # 首页/仪表盘
│   ├── Input/                    # 记账输入
│   ├── Import/                   # 导入（相机/文件/语音/微信）
│   ├── Analysis/                 # 数据分析
│   ├── Categories/               # 分类管理
│   ├── Accounts/                 # 账户管理
│   ├── Settings/                 # 设置
│   └── MainTabView.swift         # 主导航
├── ViewModels/                   # 视图模型
│   ├── AuthViewModel.swift
│   ├── ExpenseViewModel.swift
│   ├── AnalysisViewModel.swift
│   └── ImportViewModel.swift
├── Services/                     # 服务层
│   ├── OCRService.swift          # OCR 文字识别
│   ├── VoiceRecognitionService.swift # 语音识别
│   └── DataExportService.swift   # 数据导出
└── Utilities/
    └── Extensions.swift          # 通用扩展
```

## 设计系统

### Material 3 Expressive 设计 Token

完全兼容 Figma 设计变量，支持通过 Figma Token Studio 同步：

- **Color Tokens**: `md-sys-color-*` 命名，Light/Dark 双模式
- **Typography**: `md-sys-typescale-*` 完整字体系统
- **Spacing**: `md-sys-spacing-*` 8pt 网格系统
- **Shape**: `md-sys-shape-corner-*` 圆角系统
- **Elevation**: `md-sys-elevation-level*` 阴影层级

### Figma 同步

项目内置 `FigmaTokenExport.swift`，可生成 Figma Token Studio 兼容的 JSON：

```swift
let colorTokens = FigmaDesignTokens.generateColorTokensJSON()
let typographyTokens = FigmaDesignTokens.generateTypographyTokensJSON()
let fullTokens = FigmaDesignTokens.generateFullTokensJSON()
```

## 开始使用

### 环境要求
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### 构建步骤

1. 在 Xcode 中打开项目：
   ```bash
   open FinanceTracker.xcodeproj
   ```
   
   或创建新 Xcode 项目并将 `FinanceTracker/` 文件夹拖入。

2. 选择 iOS 模拟器或真机目标

3. 按 `Cmd + R` 运行

### 权限配置
应用需要以下权限（已在 Info.plist 中配置）：
- 相机（拍照记账）
- 麦克风（语音记账）
- 语音识别
- 相册访问

## 许可证

MIT License
