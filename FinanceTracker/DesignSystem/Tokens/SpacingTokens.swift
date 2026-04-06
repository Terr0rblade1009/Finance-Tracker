import SwiftUI

// MARK: - Material 3 Spacing Scale
// Figma variable: --md-sys-spacing-*

struct M3Spacing {
    static let none: CGFloat = 0
    static let xxs: CGFloat = 2
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let base: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let xxxl: CGFloat = 40
    static let huge: CGFloat = 48
    static let massive: CGFloat = 64
}

// MARK: - Material 3 Shape / Corner Radius
// Figma variable: --md-sys-shape-corner-*

struct M3Radius {
    static let none: CGFloat = 0
    static let extraSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let extraLarge: CGFloat = 28
    static let full: CGFloat = 9999
}

// MARK: - Material 3 Elevation
// Maps to Figma shadow styles

struct M3Elevation {
    static let level0 = ShadowStyle(radius: 0, y: 0, opacity: 0)
    static let level1 = ShadowStyle(radius: 3, y: 1, opacity: 0.15)
    static let level2 = ShadowStyle(radius: 6, y: 3, opacity: 0.15)
    static let level3 = ShadowStyle(radius: 8, y: 6, opacity: 0.15)
    static let level4 = ShadowStyle(radius: 12, y: 8, opacity: 0.15)
    static let level5 = ShadowStyle(radius: 16, y: 12, opacity: 0.15)

    struct ShadowStyle {
        let radius: CGFloat
        let y: CGFloat
        let opacity: Double
    }
}

extension View {
    func m3Shadow(_ style: M3Elevation.ShadowStyle) -> some View {
        self.shadow(
            color: Color.black.opacity(style.opacity),
            radius: style.radius,
            x: 0,
            y: style.y
        )
    }
}

// MARK: - Icon Sizes

struct M3IconSize {
    static let small: CGFloat = 18
    static let medium: CGFloat = 24
    static let large: CGFloat = 36
    static let extraLarge: CGFloat = 48
}
