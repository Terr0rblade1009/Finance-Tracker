[English](README.md) | [中文](README_zh.md)

# Finance Tracker

A personal finance tracking iOS app built with **SwiftUI + SwiftData**, featuring **GPT-4o** powered smart recognition and a **Material 3 Expressive** design system.

## Figma

| Resource | Link |
|----------|------|
| Component Library (Design System) | [Figma File](https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker) |
| App Screens | [Figma File](https://www.figma.com/design/WtLHNC43uTh6c8jZDiLLUz/FinanceTracker-App-Screens) |
| Dev Mode (inspect components) | [Dev Mode](https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?m=dev) |

## Features

### Core
- **Numeric keypad** for quick expense/income entry
- **Category system** — 14+ expense and 7+ income categories, fully customizable
- **Fixed expenses** — annual amounts auto-calculated to monthly/quarterly (mortgage, insurance, tuition, etc.)
- **Multi-account** — cash, bank card, Alipay, WeChat Pay with inter-account transfers

### AI-Powered Smart Import (OpenAI GPT-4o)
- **Receipt scanning** — camera or photo library → GPT-4o Vision extracts merchant, items, and totals
- **Voice input** — speak naturally, AI parses amount, note, and income/expense type
- **WeChat import** — paste chat/bill text, AI extracts all transactions
- **File import** — CSV, PDF, JPG, PNG — AI-powered OCR for images and PDFs, regex fallback without API key
- **Auto-categorization** — after recognition, AI matches each expense to the closest category from the user's list

### Analytics
- **Multi-period stats** — monthly, quarterly, yearly
- **Charts** — pie chart (category breakdown), bar chart (income/expense trends)
- **Category ranking** — per-category spend percentage and details
- **Data export** — CSV and JSON formats

### User System
- Local registration/login with salted SHA-256 hashing (SwiftData)
- Registration success animation before navigation
- Personalized avatar selection
- Dark / Light / System theme switching
- Chinese / English language support

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI | SwiftUI (iOS 17+) |
| Persistence | SwiftData |
| Charts | Swift Charts |
| AI / OCR | OpenAI GPT-4o-mini API |
| Local OCR | Apple Vision Framework |
| Speech | Apple Speech Framework |
| Design System | Material 3 Expressive |
| Build | XcodeGen (`project.yml`) |

## Project Structure

```
FinanceTracker/
├── App/                          # App entry point
│   └── FinanceTrackerApp.swift
├── DesignSystem/                 # Design system
│   ├── Tokens/                   # Design tokens
│   │   ├── ColorTokens.swift     # M3 colors (Light/Dark)
│   │   ├── TypographyTokens.swift
│   │   ├── SpacingTokens.swift   # Spacing + corner radii + elevation
│   │   └── FigmaTokenExport.swift
│   ├── Components/               # Reusable DS components
│   │   ├── DSButton.swift        # 5 variants
│   │   ├── DSCard.swift          # 3 variants
│   │   ├── DSTextField.swift
│   │   ├── DSChip.swift
│   │   ├── DSNumericKeypad.swift
│   │   ├── DSSearchBar.swift
│   │   ├── DSFab.swift
│   │   └── DSBottomSheet.swift
│   └── Theme/
│       └── Theme.swift
├── Models/                       # SwiftData models
│   ├── User.swift
│   ├── Expense.swift
│   ├── ExpenseCategory.swift
│   ├── Account.swift
│   ├── Budget.swift
│   └── FixedExpense.swift
├── Views/
│   ├── Auth/                     # Login / Register
│   ├── Home/                     # Dashboard + calendar
│   ├── Input/                    # Expense input + fixed expenses
│   ├── Import/                   # Camera / File / Voice / WeChat
│   ├── Analysis/                 # Charts and stats
│   ├── Categories/               # Category management
│   ├── Accounts/                 # Account management
│   ├── Settings/                 # Settings + API key config
│   └── MainTabView.swift
├── ViewModels/
│   ├── AuthViewModel.swift
│   ├── ExpenseViewModel.swift
│   ├── AnalysisViewModel.swift
│   └── ImportViewModel.swift
├── Services/
│   ├── OpenAIOCRService.swift    # GPT-4o Vision + text parsing + category matching
│   ├── OCRService.swift          # Apple Vision local OCR
│   ├── VoiceRecognitionService.swift
│   └── DataExportService.swift
└── Utilities/
    ├── Extensions.swift
    └── LanguageManager.swift
```

## OpenAI Integration

The app optionally integrates with OpenAI's API for enhanced accuracy. Configure your API key in **Settings → AI Recognition → OpenAI API Key**.

| Feature | With API Key | Without API Key |
|---------|-------------|----------------|
| Receipt scanning | GPT-4o Vision (merchant, items, total) | Apple Vision OCR + regex |
| Voice input | GPT parses amount + note + type | Local regex extraction |
| File import (PDF/image) | GPT-4o Vision multi-page | Apple Vision + regex |
| Text import | GPT extracts all transactions | Regex line-by-line |
| Category matching | GPT auto-selects best category | Manual selection |

All AI features degrade gracefully — the app is fully functional without an API key.

## Getting Started

### Requirements
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### Build

```bash
open FinanceTracker.xcodeproj
```

Select an iOS simulator or device, then press `Cmd + R`.

### Permissions
The app requests the following permissions (configured in Info.plist):
- Camera (receipt scanning)
- Microphone (voice input)
- Speech Recognition
- Photo Library

### TestFlight

```bash
# Archive
xcodebuild clean archive \
  -project FinanceTracker.xcodeproj \
  -scheme FinanceTracker \
  -configuration Release \
  -archivePath ./build/FinanceTracker.xcarchive \
  -destination "generic/platform=iOS"

# Export IPA
xcodebuild -exportArchive \
  -archivePath ./build/FinanceTracker.xcarchive \
  -exportPath ./build/export \
  -exportOptionsPlist ExportOptions.plist
```

Then upload via Xcode Organizer or `xcrun altool`.

## Design System

### Material 3 Expressive Tokens

Fully compatible with Figma design variables, synced via Figma Token Studio:

- **Color**: `md-sys-color-*` — Light/Dark modes
- **Typography**: `md-sys-typescale-*` — full type scale
- **Spacing**: `md-sys-spacing-*` — 8pt grid
- **Shape**: `md-sys-shape-corner-*` — corner radii
- **Elevation**: `md-sys-elevation-level*` — shadow levels

### Figma Sync

Built-in `FigmaTokenExport.swift` generates Figma Token Studio compatible JSON:

```swift
let tokens = FigmaDesignTokens.generateFullTokensJSON()
```

## Figma

| Resource | Link |
|----------|------|
| Component Library (Design System) | [Figma File](https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker) |
| App Screens | [Figma File](https://www.figma.com/design/WtLHNC43uTh6c8jZDiLLUz/FinanceTracker-App-Screens) |
| Dev Mode (inspect components) | [Dev Mode](https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?m=dev) |

### Figma Code Connect

This project uses [Figma Code Connect](https://github.com/figma/code-connect) with the **Swift parser** to link every design system component in Figma to its SwiftUI implementation. When developers inspect a component in Figma Dev Mode, they see the actual SwiftUI code snippet instead of generic CSS.

**118 components connected** across 29 Code Connect files.

#### Connected Components

| Category | Components |
|----------|-----------|
| **Inputs** | `DSButton` · `DSTextField` · `DSSearchBar` · `DSChip` · `DSNumericKeypad` · `DSFab` |
| **Layout** | `DSCard` · `DSBottomSheet` · `DSDialog` · `DSSectionHeader` · `DSNavBar` · `DSTabBar` · `DSSegmentedControl` |
| **Data Display** | `DSTransactionRow` · `DSTransactionListSection` · `DSSummaryCard` · `DSStatRow` · `DSPieChartCard` · `DSAmountDisplay` · `DSMonthNavigator` |
| **Categories** | `DSCategoryCell` · `DSCategoryProgressRow` · `DSCategoryGridSection` · `DSChipRowSection` |
| **Content** | `DSEmptyState` · `DSSettingsRow` · `DSImportCard` · `DSMethodCard` |
| **Icons** | `DSIcon` — 70+ system icons for categories, accounts, navigation, and actions |

#### Prop Mapping Features

- `@FigmaString` — maps text properties (titles, labels, amounts)
- `@FigmaBoolean` with `hideDefault` — conditionally shows/hides parameters (e.g. subtitle, icon)
- `@FigmaEnum` — maps variant and size properties to Swift enums
- `@FigmaInstance` — maps nested component instances
- Variant mapping via `let variant` — different code per Figma variant (e.g. TextField states, FAB sizes)

#### Publishing

```bash
# Build the Swift parser and publish all Code Connect files to Figma
npx figma connect publish
```

Configuration is in `figma.config.json`:

```json
{
  "codeConnect": {
    "parser": "swift",
    "include": ["CodeConnect/**/*.figma.swift"],
    "swiftPackagePath": "Package.swift"
  }
}
```

Code Connect files live in `CodeConnect/` and the Swift package is defined in `Package.swift` (used only by the Figma CLI parser, not by the Xcode project).

## License

MIT License
