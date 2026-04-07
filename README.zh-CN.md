<p align="center">
  <img src="FinanceTracker/Assets.xcassets/AppIcon.appiconset/AppIcon.png" width="120" height="120" alt="记账本应用图标" style="border-radius: 24px;" />
</p>

<h1 align="center">记账本</h1>

<p align="center">
  中文 | <a href="README.md">English</a>
</p>

<p align="center">
  一款基于 <strong>SwiftUI + SwiftData</strong> 构建的精美 iOS 记账应用，<br/>
  采用 <strong>Material 3 Expressive</strong> 设计系统，支持智能导入功能。
</p>

<p align="center">
  <img src="https://img.shields.io/badge/平台-iOS%2017%2B-blue?style=flat-square" alt="iOS 17+" />
  <img src="https://img.shields.io/badge/Swift-5.9-orange?style=flat-square" alt="Swift 5.9" />
  <img src="https://img.shields.io/badge/设计-Material%203-green?style=flat-square" alt="Material 3" />
  <img src="https://img.shields.io/badge/数据-SwiftData-purple?style=flat-square" alt="SwiftData" />
  <img src="https://img.shields.io/badge/许可证-MIT-lightgrey?style=flat-square" alt="MIT License" />
</p>

---

## 应用截图

<p align="center">
  <img src="screenshots/home-dashboard.svg" width="220" alt="首页仪表盘" />
  &nbsp;&nbsp;
  <img src="screenshots/expense-input.svg" width="220" alt="记账输入" />
  &nbsp;&nbsp;
  <img src="screenshots/analysis.svg" width="220" alt="数据分析" />
  &nbsp;&nbsp;
  <img src="screenshots/smart-import.svg" width="220" alt="智能导入" />
</p>

<p align="center">
  <em>首页仪表盘 &nbsp;|&nbsp; 记账输入 &nbsp;|&nbsp; 数据分析 &nbsp;|&nbsp; 智能导入</em>
</p>

---

## 功能特性

### 核心功能
- **数字键盘记账** — 快速输入支出/收入金额
- **二级分类系统** — 14+ 支出分类、7+ 收入分类，支持自定义
- **固定开支管理** — 输入年度金额，自动计算月/季费用（房贷、保险、学费等）
- **多账户管理** — 现金、银行卡、支付宝、微信等，支持账户间转账

### 智能导入
- **拍照记账** — 拍摄收据，基于 Vision 框架的 OCR 自动识别金额
- **截图记账** — 导入截图，自动识别账单信息
- **语音记账** — 说出消费信息，通过 Speech 框架自动解析
- **微信导入** — 粘贴微信对话/账单，自动提取交易数据
- **文件导入** — 支持 CSV、PDF、JPG、PNG 格式

### 数据分析
- **多维度统计** — 月度/季度/年度分析报告
- **图表可视化** — 饼图（分类构成）、柱状图（收支趋势），基于 Swift Charts
- **分类排行** — 各分类支出占比和明细
- **数据导出** — CSV/JSON 格式导出

### 用户体验
- **本地认证** — 注册/登录，SwiftData 本地存储
- **个性化头像** — 自选头像图标
- **深色/浅色模式** — 完整主题支持
- **双语支持** — 简体中文和英文本地化

---

## 技术栈

| 层级 | 技术 |
|---|---|
| **UI 框架** | SwiftUI (iOS 17+) |
| **数据持久化** | SwiftData |
| **图表** | Swift Charts |
| **OCR** | Vision Framework |
| **语音识别** | Speech Framework |
| **设计系统** | Material 3 Expressive |
| **设计同步** | Figma Code Connect |

---

## 项目结构

```
FinanceTracker/
├── App/                        # 应用入口
├── DesignSystem/
│   ├── Tokens/                 # M3 色彩、字体、间距 Token
│   ├── Components/             # 30 个可复用 UI 组件
│   └── Theme/                  # 主题配置
├── Models/                     # SwiftData 模型（用户、支出、账户、预算…）
├── Views/
│   ├── Auth/                   # 登录与注册
│   ├── Home/                   # 首页仪表盘与日历
│   ├── Input/                  # 数字键盘记账输入
│   ├── Import/                 # 相机、语音、文件、微信导入
│   ├── Analysis/               # 数据分析与图表
│   ├── Categories/             # 分类管理
│   ├── Accounts/               # 账户管理
│   └── Settings/               # 应用设置
├── ViewModels/                 # MVVM 视图逻辑
├── Services/                   # OCR、语音识别、数据导出
└── Utilities/                  # 扩展工具与本地化
```

---

## 设计系统

基于 **Material 3 Expressive** 构建，完整支持 Figma 同步：

- **色彩 Token** — `md-sys-color-*` 命名，Light/Dark 双模式色板
- **字体** — `md-sys-typescale-*` 完整字体系统
- **间距** — `md-sys-spacing-*` 8pt 网格系统
- **圆角** — `md-sys-shape-corner-*` 圆角系统
- **阴影** — `md-sys-elevation-level*` 阴影层级
- **30 个组件** — 按钮、卡片、标签、FAB、弹窗、对话框、图表等

内置 Figma Token Studio 兼容的 JSON 导出：

```swift
let tokens = FigmaDesignTokens.generateFullTokensJSON()
```

---

## 开始使用

### 环境要求
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### 构建与运行

```bash
# 克隆仓库
git clone https://github.com/Terr0rblade1009/Finance-Tracker.git

# 在 Xcode 中打开
open FinanceTracker.xcodeproj

# 选择模拟器或真机目标，按 Cmd + R 运行
```

### 权限配置
应用需要以下权限（已在 Info.plist 中预配置）：
- **相机** — 拍照记账
- **麦克风** — 语音输入
- **语音识别** — 语音转文字解析
- **相册访问** — 图片导入

---

## 许可证

[MIT License](LICENSE) — 可自由使用、修改和分发。
