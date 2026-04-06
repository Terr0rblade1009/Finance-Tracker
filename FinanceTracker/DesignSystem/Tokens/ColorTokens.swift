import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Material 3 Expressive Color Tokens
// Compatible with Figma design variables (--md-sys-color-*)

struct M3Color {

    // MARK: - Primary
    static let primary = Color("Primary", bundle: nil)
    static let onPrimary = Color("OnPrimary", bundle: nil)
    static let primaryContainer = Color("PrimaryContainer", bundle: nil)
    static let onPrimaryContainer = Color("OnPrimaryContainer", bundle: nil)

    // MARK: - Secondary
    static let secondary = Color("Secondary", bundle: nil)
    static let onSecondary = Color("OnSecondary", bundle: nil)
    static let secondaryContainer = Color("SecondaryContainer", bundle: nil)
    static let onSecondaryContainer = Color("OnSecondaryContainer", bundle: nil)

    // MARK: - Tertiary
    static let tertiary = Color("Tertiary", bundle: nil)
    static let onTertiary = Color("OnTertiary", bundle: nil)
    static let tertiaryContainer = Color("TertiaryContainer", bundle: nil)
    static let onTertiaryContainer = Color("OnTertiaryContainer", bundle: nil)

    // MARK: - Error
    static let error = Color("Error", bundle: nil)
    static let onError = Color("OnError", bundle: nil)
    static let errorContainer = Color("ErrorContainer", bundle: nil)
    static let onErrorContainer = Color("OnErrorContainer", bundle: nil)

    // MARK: - Surface
    static let surface = Color("Surface", bundle: nil)
    static let onSurface = Color("OnSurface", bundle: nil)
    static let surfaceVariant = Color("SurfaceVariant", bundle: nil)
    static let onSurfaceVariant = Color("OnSurfaceVariant", bundle: nil)
    static let surfaceContainerLowest = Color("SurfaceContainerLowest", bundle: nil)
    static let surfaceContainerLow = Color("SurfaceContainerLow", bundle: nil)
    static let surfaceContainer = Color("SurfaceContainer", bundle: nil)
    static let surfaceContainerHigh = Color("SurfaceContainerHigh", bundle: nil)
    static let surfaceContainerHighest = Color("SurfaceContainerHighest", bundle: nil)
    static let surfaceTint = Color("SurfaceTint", bundle: nil)

    // MARK: - Outline
    static let outline = Color("Outline", bundle: nil)
    static let outlineVariant = Color("OutlineVariant", bundle: nil)

    // MARK: - Inverse
    static let inverseSurface = Color("InverseSurface", bundle: nil)
    static let inverseOnSurface = Color("InverseOnSurface", bundle: nil)
    static let inversePrimary = Color("InversePrimary", bundle: nil)

    // MARK: - Background
    static let background = Color("Background", bundle: nil)
    static let onBackground = Color("OnBackground", bundle: nil)

    // MARK: - Scrim & Shadow
    static let scrim = Color.black.opacity(0.32)
    static let shadow = Color.black.opacity(0.15)
}

// MARK: - Hardcoded Fallback Palette (Light)
extension M3Color {
    struct Light {
        static let primary = Color(hex: "1B6C4F")
        static let onPrimary = Color.white
        static let primaryContainer = Color(hex: "A6F5CF")
        static let onPrimaryContainer = Color(hex: "002115")
        static let secondary = Color(hex: "4E6355")
        static let onSecondary = Color.white
        static let secondaryContainer = Color(hex: "D0E8D6")
        static let onSecondaryContainer = Color(hex: "0B1F14")
        static let tertiary = Color(hex: "3C6471")
        static let onTertiary = Color.white
        static let tertiaryContainer = Color(hex: "BFE9F8")
        static let onTertiaryContainer = Color(hex: "001F28")
        static let error = Color(hex: "BA1A1A")
        static let onError = Color.white
        static let errorContainer = Color(hex: "FFDAD6")
        static let onErrorContainer = Color(hex: "410002")
        static let surface = Color(hex: "F5FBF3")
        static let onSurface = Color(hex: "171D19")
        static let surfaceVariant = Color(hex: "DBE5DB")
        static let onSurfaceVariant = Color(hex: "404942")
        static let surfaceContainerLowest = Color.white
        static let surfaceContainerLow = Color(hex: "EFF5ED")
        static let surfaceContainer = Color(hex: "E9EFE8")
        static let surfaceContainerHigh = Color(hex: "E4EAE2")
        static let surfaceContainerHighest = Color(hex: "DEE4DC")
        static let outline = Color(hex: "707971")
        static let outlineVariant = Color(hex: "BFC9BF")
        static let inverseSurface = Color(hex: "2C322D")
        static let inverseOnSurface = Color(hex: "ECF2EA")
        static let inversePrimary = Color(hex: "8AD8B4")
        static let background = Color(hex: "F5FBF3")
        static let onBackground = Color(hex: "171D19")
    }

    struct Dark {
        static let primary = Color(hex: "8AD8B4")
        static let onPrimary = Color(hex: "003827")
        static let primaryContainer = Color(hex: "00513A")
        static let onPrimaryContainer = Color(hex: "A6F5CF")
        static let secondary = Color(hex: "B4CCBA")
        static let onSecondary = Color(hex: "203528")
        static let secondaryContainer = Color(hex: "364B3E")
        static let onSecondaryContainer = Color(hex: "D0E8D6")
        static let tertiary = Color(hex: "A4CDDC")
        static let onTertiary = Color(hex: "043541")
        static let tertiaryContainer = Color(hex: "224C58")
        static let onTertiaryContainer = Color(hex: "BFE9F8")
        static let error = Color(hex: "FFB4AB")
        static let onError = Color(hex: "690005")
        static let errorContainer = Color(hex: "93000A")
        static let onErrorContainer = Color(hex: "FFDAD6")
        static let surface = Color(hex: "0F1511")
        static let onSurface = Color(hex: "DEE4DC")
        static let surfaceVariant = Color(hex: "404942")
        static let onSurfaceVariant = Color(hex: "BFC9BF")
        static let surfaceContainerLowest = Color(hex: "0A0F0C")
        static let surfaceContainerLow = Color(hex: "171D19")
        static let surfaceContainer = Color(hex: "1B211D")
        static let surfaceContainerHigh = Color(hex: "252B27")
        static let surfaceContainerHighest = Color(hex: "303632")
        static let outline = Color(hex: "89938A")
        static let outlineVariant = Color(hex: "404942")
        static let inverseSurface = Color(hex: "DEE4DC")
        static let inverseOnSurface = Color(hex: "2C322D")
        static let inversePrimary = Color(hex: "1B6C4F")
        static let background = Color(hex: "0F1511")
        static let onBackground = Color(hex: "DEE4DC")
    }
}

// MARK: - Adaptive Color Helper
extension M3Color {
    static func adaptive(light: Color, dark: Color) -> Color {
        #if canImport(UIKit)
        return Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(dark) : UIColor(light)
        })
        #else
        return light
        #endif
    }

    struct Adaptive {
        static var primary: Color { adaptive(light: Light.primary, dark: Dark.primary) }
        static var onPrimary: Color { adaptive(light: Light.onPrimary, dark: Dark.onPrimary) }
        static var primaryContainer: Color { adaptive(light: Light.primaryContainer, dark: Dark.primaryContainer) }
        static var onPrimaryContainer: Color { adaptive(light: Light.onPrimaryContainer, dark: Dark.onPrimaryContainer) }
        static var secondary: Color { adaptive(light: Light.secondary, dark: Dark.secondary) }
        static var onSecondary: Color { adaptive(light: Light.onSecondary, dark: Dark.onSecondary) }
        static var secondaryContainer: Color { adaptive(light: Light.secondaryContainer, dark: Dark.secondaryContainer) }
        static var onSecondaryContainer: Color { adaptive(light: Light.onSecondaryContainer, dark: Dark.onSecondaryContainer) }
        static var tertiary: Color { adaptive(light: Light.tertiary, dark: Dark.tertiary) }
        static var onTertiary: Color { adaptive(light: Light.onTertiary, dark: Dark.onTertiary) }
        static var tertiaryContainer: Color { adaptive(light: Light.tertiaryContainer, dark: Dark.tertiaryContainer) }
        static var onTertiaryContainer: Color { adaptive(light: Light.onTertiaryContainer, dark: Dark.onTertiaryContainer) }
        static var error: Color { adaptive(light: Light.error, dark: Dark.error) }
        static var onError: Color { adaptive(light: Light.onError, dark: Dark.onError) }
        static var errorContainer: Color { adaptive(light: Light.errorContainer, dark: Dark.errorContainer) }
        static var onErrorContainer: Color { adaptive(light: Light.onErrorContainer, dark: Dark.onErrorContainer) }
        static var surface: Color { adaptive(light: Light.surface, dark: Dark.surface) }
        static var onSurface: Color { adaptive(light: Light.onSurface, dark: Dark.onSurface) }
        static var surfaceVariant: Color { adaptive(light: Light.surfaceVariant, dark: Dark.surfaceVariant) }
        static var onSurfaceVariant: Color { adaptive(light: Light.onSurfaceVariant, dark: Dark.onSurfaceVariant) }
        static var surfaceContainerLowest: Color { adaptive(light: Light.surfaceContainerLowest, dark: Dark.surfaceContainerLowest) }
        static var surfaceContainerLow: Color { adaptive(light: Light.surfaceContainerLow, dark: Dark.surfaceContainerLow) }
        static var surfaceContainer: Color { adaptive(light: Light.surfaceContainer, dark: Dark.surfaceContainer) }
        static var surfaceContainerHigh: Color { adaptive(light: Light.surfaceContainerHigh, dark: Dark.surfaceContainerHigh) }
        static var surfaceContainerHighest: Color { adaptive(light: Light.surfaceContainerHighest, dark: Dark.surfaceContainerHighest) }
        static var outline: Color { adaptive(light: Light.outline, dark: Dark.outline) }
        static var outlineVariant: Color { adaptive(light: Light.outlineVariant, dark: Dark.outlineVariant) }
        static var inverseSurface: Color { adaptive(light: Light.inverseSurface, dark: Dark.inverseSurface) }
        static var inverseOnSurface: Color { adaptive(light: Light.inverseOnSurface, dark: Dark.inverseOnSurface) }
        static var inversePrimary: Color { adaptive(light: Light.inversePrimary, dark: Dark.inversePrimary) }
        static var background: Color { adaptive(light: Light.background, dark: Dark.background) }
        static var onBackground: Color { adaptive(light: Light.onBackground, dark: Dark.onBackground) }
    }
}

// MARK: - Hex Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Category Colors
struct CategoryColors {
    static let food = Color(hex: "FF8A65")
    static let transport = Color(hex: "4FC3F7")
    static let shopping = Color(hex: "BA68C8")
    static let entertainment = Color(hex: "FFD54F")
    static let health = Color(hex: "81C784")
    static let education = Color(hex: "7986CB")
    static let housing = Color(hex: "A1887F")
    static let utilities = Color(hex: "4DB6AC")
    static let insurance = Color(hex: "90A4AE")
    static let salary = Color(hex: "66BB6A")
    static let investment = Color(hex: "42A5F5")
    static let other = Color(hex: "BDBDBD")

    static let all: [Color] = [
        food, transport, shopping, entertainment,
        health, education, housing, utilities,
        insurance, salary, investment, other
    ]
}
