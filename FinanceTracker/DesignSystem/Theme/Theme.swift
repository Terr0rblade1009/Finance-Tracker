import SwiftUI

// MARK: - Unified Theme Object
// Single access point for all design tokens, Figma-compatible

struct AppTheme {
    let color: ThemeColors
    let typography: ThemeTypography
    let spacing: ThemeSpacing
    let radius: ThemeRadius
    let elevation: ThemeElevation

    static let shared = AppTheme(
        color: ThemeColors(),
        typography: ThemeTypography(),
        spacing: ThemeSpacing(),
        radius: ThemeRadius(),
        elevation: ThemeElevation()
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
    var onTertiary: Color { M3Color.Adaptive.onTertiary }
    var tertiaryContainer: Color { M3Color.Adaptive.tertiaryContainer }
    var onTertiaryContainer: Color { M3Color.Adaptive.onTertiaryContainer }
    var surface: Color { M3Color.Adaptive.surface }
    var onSurface: Color { M3Color.Adaptive.onSurface }
    var surfaceVariant: Color { M3Color.Adaptive.surfaceVariant }
    var onSurfaceVariant: Color { M3Color.Adaptive.onSurfaceVariant }
    var surfaceContainerLowest: Color { M3Color.Adaptive.surfaceContainerLowest }
    var surfaceContainerLow: Color { M3Color.Adaptive.surfaceContainerLow }
    var surfaceContainer: Color { M3Color.Adaptive.surfaceContainer }
    var surfaceContainerHigh: Color { M3Color.Adaptive.surfaceContainerHigh }
    var surfaceContainerHighest: Color { M3Color.Adaptive.surfaceContainerHighest }
    var outline: Color { M3Color.Adaptive.outline }
    var outlineVariant: Color { M3Color.Adaptive.outlineVariant }
    var error: Color { M3Color.Adaptive.error }
    var onError: Color { M3Color.Adaptive.onError }
    var errorContainer: Color { M3Color.Adaptive.errorContainer }
    var onErrorContainer: Color { M3Color.Adaptive.onErrorContainer }
    var inverseSurface: Color { M3Color.Adaptive.inverseSurface }
    var inverseOnSurface: Color { M3Color.Adaptive.inverseOnSurface }
    var inversePrimary: Color { M3Color.Adaptive.inversePrimary }
    var background: Color { M3Color.Adaptive.background }
    var onBackground: Color { M3Color.Adaptive.onBackground }
    var scrim: Color { M3Color.scrim }
    var shadow: Color { M3Color.shadow }
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
    var amountDisplay: Font { M3Typography.amountDisplay }
    var amountLarge: Font { M3Typography.amountLarge }
    var amountMedium: Font { M3Typography.amountMedium }
    var amountSmall: Font { M3Typography.amountSmall }

    struct LineHeight {
        var displayLarge: CGFloat { M3LineHeight.displayLarge }
        var displayMedium: CGFloat { M3LineHeight.displayMedium }
        var displaySmall: CGFloat { M3LineHeight.displaySmall }
        var headlineLarge: CGFloat { M3LineHeight.headlineLarge }
        var headlineMedium: CGFloat { M3LineHeight.headlineMedium }
        var headlineSmall: CGFloat { M3LineHeight.headlineSmall }
        var titleLarge: CGFloat { M3LineHeight.titleLarge }
        var titleMedium: CGFloat { M3LineHeight.titleMedium }
        var titleSmall: CGFloat { M3LineHeight.titleSmall }
        var bodyLarge: CGFloat { M3LineHeight.bodyLarge }
        var bodyMedium: CGFloat { M3LineHeight.bodyMedium }
        var bodySmall: CGFloat { M3LineHeight.bodySmall }
        var labelLarge: CGFloat { M3LineHeight.labelLarge }
        var labelMedium: CGFloat { M3LineHeight.labelMedium }
        var labelSmall: CGFloat { M3LineHeight.labelSmall }
        var amountDisplay: CGFloat { M3LineHeight.amountDisplay }
        var amountLarge: CGFloat { M3LineHeight.amountLarge }
        var amountMedium: CGFloat { M3LineHeight.amountMedium }
        var amountSmall: CGFloat { M3LineHeight.amountSmall }
    }

    struct LetterSpacing {
        var displayLarge: CGFloat { M3LetterSpacing.displayLarge }
        var displayMedium: CGFloat { M3LetterSpacing.displayMedium }
        var displaySmall: CGFloat { M3LetterSpacing.displaySmall }
        var headlineLarge: CGFloat { M3LetterSpacing.headlineLarge }
        var headlineMedium: CGFloat { M3LetterSpacing.headlineMedium }
        var headlineSmall: CGFloat { M3LetterSpacing.headlineSmall }
        var titleLarge: CGFloat { M3LetterSpacing.titleLarge }
        var titleMedium: CGFloat { M3LetterSpacing.titleMedium }
        var titleSmall: CGFloat { M3LetterSpacing.titleSmall }
        var bodyLarge: CGFloat { M3LetterSpacing.bodyLarge }
        var bodyMedium: CGFloat { M3LetterSpacing.bodyMedium }
        var bodySmall: CGFloat { M3LetterSpacing.bodySmall }
        var labelLarge: CGFloat { M3LetterSpacing.labelLarge }
        var labelMedium: CGFloat { M3LetterSpacing.labelMedium }
        var labelSmall: CGFloat { M3LetterSpacing.labelSmall }
        var amountDisplay: CGFloat { M3LetterSpacing.amountDisplay }
        var amountLarge: CGFloat { M3LetterSpacing.amountLarge }
        var amountMedium: CGFloat { M3LetterSpacing.amountMedium }
        var amountSmall: CGFloat { M3LetterSpacing.amountSmall }
    }

    var lineHeight: LineHeight { LineHeight() }
    var letterSpacing: LetterSpacing { LetterSpacing() }
}

struct ThemeSpacing {
    var none: CGFloat { M3Spacing.none }
    var xxs: CGFloat { M3Spacing.xxs }
    var xs: CGFloat { M3Spacing.xs }
    var sm: CGFloat { M3Spacing.sm }
    var md: CGFloat { M3Spacing.md }
    var base: CGFloat { M3Spacing.base }
    var lg: CGFloat { M3Spacing.lg }
    var xl: CGFloat { M3Spacing.xl }
    var xxl: CGFloat { M3Spacing.xxl }
    var xxxl: CGFloat { M3Spacing.xxxl }
    var huge: CGFloat { M3Spacing.huge }
    var massive: CGFloat { M3Spacing.massive }
}

struct ThemeRadius {
    var none: CGFloat { M3Radius.none }
    var extraSmall: CGFloat { M3Radius.extraSmall }
    var small: CGFloat { M3Radius.small }
    var medium: CGFloat { M3Radius.medium }
    var large: CGFloat { M3Radius.large }
    var extraLarge: CGFloat { M3Radius.extraLarge }
    var full: CGFloat { M3Radius.full }
}

struct ThemeElevation {
    var level0: M3Elevation.ShadowStyle { M3Elevation.level0 }
    var level1: M3Elevation.ShadowStyle { M3Elevation.level1 }
    var level2: M3Elevation.ShadowStyle { M3Elevation.level2 }
    var level3: M3Elevation.ShadowStyle { M3Elevation.level3 }
    var level4: M3Elevation.ShadowStyle { M3Elevation.level4 }
    var level5: M3Elevation.ShadowStyle { M3Elevation.level5 }
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
