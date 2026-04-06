import SwiftUI

// MARK: - Material 3 Type Scale
// Figma variable: --md-sys-typescale-*

struct M3Typography {

    // MARK: - Display
    static let displayLarge = Font.system(size: 57, weight: .regular, design: .rounded)
    static let displayMedium = Font.system(size: 45, weight: .regular, design: .rounded)
    static let displaySmall = Font.system(size: 36, weight: .regular, design: .rounded)

    // MARK: - Headline
    static let headlineLarge = Font.system(size: 32, weight: .semibold, design: .rounded)
    static let headlineMedium = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let headlineSmall = Font.system(size: 24, weight: .semibold, design: .rounded)

    // MARK: - Title
    static let titleLarge = Font.system(size: 22, weight: .medium, design: .rounded)
    static let titleMedium = Font.system(size: 16, weight: .medium, design: .rounded)
    static let titleSmall = Font.system(size: 14, weight: .medium, design: .rounded)

    // MARK: - Body
    static let bodyLarge = Font.system(size: 16, weight: .regular, design: .rounded)
    static let bodyMedium = Font.system(size: 14, weight: .regular, design: .rounded)
    static let bodySmall = Font.system(size: 12, weight: .regular, design: .rounded)

    // MARK: - Label
    static let labelLarge = Font.system(size: 14, weight: .medium, design: .rounded)
    static let labelMedium = Font.system(size: 12, weight: .medium, design: .rounded)
    static let labelSmall = Font.system(size: 11, weight: .medium, design: .rounded)

    // MARK: - Numeric (for amounts)
    static let amountDisplay = Font.system(size: 40, weight: .bold, design: .rounded)
    static let amountLarge = Font.system(size: 48, weight: .bold, design: .monospaced)
    static let amountMedium = Font.system(size: 32, weight: .bold, design: .monospaced)
    static let amountSmall = Font.system(size: 20, weight: .medium, design: .monospaced)
}

// MARK: - Line Heights (Figma-compatible)
struct M3LineHeight {
    static let displayLarge: CGFloat = 64
    static let displayMedium: CGFloat = 52
    static let displaySmall: CGFloat = 44
    static let headlineLarge: CGFloat = 40
    static let headlineMedium: CGFloat = 36
    static let headlineSmall: CGFloat = 32
    static let titleLarge: CGFloat = 28
    static let titleMedium: CGFloat = 24
    static let titleSmall: CGFloat = 20
    static let bodyLarge: CGFloat = 24
    static let bodyMedium: CGFloat = 20
    static let bodySmall: CGFloat = 16
    static let labelLarge: CGFloat = 20
    static let labelMedium: CGFloat = 16
    static let labelSmall: CGFloat = 16
    static let amountDisplay: CGFloat = 48
    static let amountLarge: CGFloat = 56
    static let amountMedium: CGFloat = 40
    static let amountSmall: CGFloat = 28
}

// MARK: - Letter Spacing (Figma-compatible)
struct M3LetterSpacing {
    static let displayLarge: CGFloat = -0.25
    static let displayMedium: CGFloat = 0
    static let displaySmall: CGFloat = 0
    static let headlineLarge: CGFloat = 0
    static let headlineMedium: CGFloat = 0
    static let headlineSmall: CGFloat = 0
    static let titleLarge: CGFloat = 0
    static let titleMedium: CGFloat = 0.15
    static let titleSmall: CGFloat = 0.1
    static let bodyLarge: CGFloat = 0.5
    static let bodyMedium: CGFloat = 0.25
    static let bodySmall: CGFloat = 0.4
    static let labelLarge: CGFloat = 0.1
    static let labelMedium: CGFloat = 0.5
    static let labelSmall: CGFloat = 0.5
    static let amountDisplay: CGFloat = 0
    static let amountLarge: CGFloat = 0
    static let amountMedium: CGFloat = 0
    static let amountSmall: CGFloat = 0
}
