import SwiftUI

// MARK: - Unified Theme Object
// Single access point for all design tokens, Figma-compatible

struct AppTheme {
    let color: ThemeColors
    let typography: ThemeTypography
    let spacing: ThemeSpacing
    let radius: ThemeRadius

    static let shared = AppTheme(
        color: ThemeColors(),
        typography: ThemeTypography(),
        spacing: ThemeSpacing(),
        radius: ThemeRadius()
    )
}

struct ThemeColors {
    var primary: Color { M3Color.Adaptive.primary }
    var onPrimary: Color { M3Color.Adaptive.onPrimary }
    var primaryContainer: Color { M3Color.Adaptive.primaryContainer }
    var onPrimaryContainer: Color { M3Color.Adaptive.onPrimaryContainer }
    var secondary: Color { M3Color.Adaptive.secondary }
    var onSecondary: Color { M3Color.Adaptive.onSecondary }
    var secondaryContainer: Color { M3Color.Adaptive.secondaryContainer }
    var onSecondaryContainer: Color { M3Color.Adaptive.onSecondaryContainer }
    var tertiary: Color { M3Color.Adaptive.tertiary }
    var surface: Color { M3Color.Adaptive.surface }
    var onSurface: Color { M3Color.Adaptive.onSurface }
    var surfaceVariant: Color { M3Color.Adaptive.surfaceVariant }
    var onSurfaceVariant: Color { M3Color.Adaptive.onSurfaceVariant }
    var surfaceContainer: Color { M3Color.Adaptive.surfaceContainer }
    var surfaceContainerLow: Color { M3Color.Adaptive.surfaceContainerLow }
    var surfaceContainerHigh: Color { M3Color.Adaptive.surfaceContainerHigh }
    var surfaceContainerHighest: Color { M3Color.Adaptive.surfaceContainerHighest }
    var outline: Color { M3Color.Adaptive.outline }
    var outlineVariant: Color { M3Color.Adaptive.outlineVariant }
    var error: Color { M3Color.Adaptive.error }
    var onError: Color { M3Color.Adaptive.onError }
    var errorContainer: Color { M3Color.Adaptive.errorContainer }
    var background: Color { M3Color.Adaptive.background }
    var onBackground: Color { M3Color.Adaptive.onBackground }
}

struct ThemeTypography {
    var displayLarge: Font { M3Typography.displayLarge }
    var displayMedium: Font { M3Typography.displayMedium }
    var displaySmall: Font { M3Typography.displaySmall }
    var headlineLarge: Font { M3Typography.headlineLarge }
    var headlineMedium: Font { M3Typography.headlineMedium }
    var headlineSmall: Font { M3Typography.headlineSmall }
    var titleLarge: Font { M3Typography.titleLarge }
    var titleMedium: Font { M3Typography.titleMedium }
    var titleSmall: Font { M3Typography.titleSmall }
    var bodyLarge: Font { M3Typography.bodyLarge }
    var bodyMedium: Font { M3Typography.bodyMedium }
    var bodySmall: Font { M3Typography.bodySmall }
    var labelLarge: Font { M3Typography.labelLarge }
    var labelMedium: Font { M3Typography.labelMedium }
    var labelSmall: Font { M3Typography.labelSmall }
    var amountLarge: Font { M3Typography.amountLarge }
    var amountMedium: Font { M3Typography.amountMedium }
    var amountSmall: Font { M3Typography.amountSmall }
}

struct ThemeSpacing {
    var xs: CGFloat { M3Spacing.xs }
    var sm: CGFloat { M3Spacing.sm }
    var md: CGFloat { M3Spacing.md }
    var base: CGFloat { M3Spacing.base }
    var lg: CGFloat { M3Spacing.lg }
    var xl: CGFloat { M3Spacing.xl }
    var xxl: CGFloat { M3Spacing.xxl }
}

struct ThemeRadius {
    var small: CGFloat { M3Radius.small }
    var medium: CGFloat { M3Radius.medium }
    var large: CGFloat { M3Radius.large }
    var extraLarge: CGFloat { M3Radius.extraLarge }
    var full: CGFloat { M3Radius.full }
}

// MARK: - Environment Key

private struct ThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme.shared
}

extension EnvironmentValues {
    var theme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
