import Foundation

// MARK: - Figma Design Token Export
// This file generates JSON-compatible token definitions
// for syncing with Figma Variables and Styles

struct FigmaDesignTokens {

    static func generateColorTokensJSON() -> String {
        """
        {
          "color": {
            "md-sys-color-primary": { "light": "#1B6C4F", "dark": "#8AD8B4" },
            "md-sys-color-on-primary": { "light": "#FFFFFF", "dark": "#003827" },
            "md-sys-color-primary-container": { "light": "#A6F5CF", "dark": "#00513A" },
            "md-sys-color-on-primary-container": { "light": "#002115", "dark": "#A6F5CF" },
            "md-sys-color-secondary": { "light": "#4E6355", "dark": "#B4CCBA" },
            "md-sys-color-on-secondary": { "light": "#FFFFFF", "dark": "#203528" },
            "md-sys-color-secondary-container": { "light": "#D0E8D6", "dark": "#364B3E" },
            "md-sys-color-on-secondary-container": { "light": "#0B1F14", "dark": "#D0E8D6" },
            "md-sys-color-tertiary": { "light": "#3C6471", "dark": "#A4CDDC" },
            "md-sys-color-on-tertiary": { "light": "#FFFFFF", "dark": "#043541" },
            "md-sys-color-tertiary-container": { "light": "#BFE9F8", "dark": "#224C58" },
            "md-sys-color-on-tertiary-container": { "light": "#001F28", "dark": "#BFE9F8" },
            "md-sys-color-error": { "light": "#BA1A1A", "dark": "#FFB4AB" },
            "md-sys-color-on-error": { "light": "#FFFFFF", "dark": "#690005" },
            "md-sys-color-error-container": { "light": "#FFDAD6", "dark": "#93000A" },
            "md-sys-color-on-error-container": { "light": "#410002", "dark": "#FFDAD6" },
            "md-sys-color-surface": { "light": "#F5FBF3", "dark": "#0F1511" },
            "md-sys-color-on-surface": { "light": "#171D19", "dark": "#DEE4DC" },
            "md-sys-color-surface-variant": { "light": "#DBE5DB", "dark": "#404942" },
            "md-sys-color-on-surface-variant": { "light": "#404942", "dark": "#BFC9BF" },
            "md-sys-color-surface-container-lowest": { "light": "#FFFFFF", "dark": "#0A0F0C" },
            "md-sys-color-surface-container-low": { "light": "#EFF5ED", "dark": "#171D19" },
            "md-sys-color-surface-container": { "light": "#E9EFE8", "dark": "#1B211D" },
            "md-sys-color-surface-container-high": { "light": "#E4EAE2", "dark": "#252B27" },
            "md-sys-color-surface-container-highest": { "light": "#DEE4DC", "dark": "#303632" },
            "md-sys-color-outline": { "light": "#707971", "dark": "#89938A" },
            "md-sys-color-outline-variant": { "light": "#BFC9BF", "dark": "#404942" },
            "md-sys-color-inverse-surface": { "light": "#2C322D", "dark": "#DEE4DC" },
            "md-sys-color-inverse-on-surface": { "light": "#ECF2EA", "dark": "#2C322D" },
            "md-sys-color-inverse-primary": { "light": "#8AD8B4", "dark": "#1B6C4F" }
          }
        }
        """
    }

    static func generateTypographyTokensJSON() -> String {
        """
        {
          "typography": {
            "md-sys-typescale-display-large": { "size": 57, "weight": 400, "lineHeight": 64, "letterSpacing": -0.25 },
            "md-sys-typescale-display-medium": { "size": 45, "weight": 400, "lineHeight": 52, "letterSpacing": 0 },
            "md-sys-typescale-display-small": { "size": 36, "weight": 400, "lineHeight": 44, "letterSpacing": 0 },
            "md-sys-typescale-headline-large": { "size": 32, "weight": 600, "lineHeight": 40, "letterSpacing": 0 },
            "md-sys-typescale-headline-medium": { "size": 28, "weight": 600, "lineHeight": 36, "letterSpacing": 0 },
            "md-sys-typescale-headline-small": { "size": 24, "weight": 600, "lineHeight": 32, "letterSpacing": 0 },
            "md-sys-typescale-title-large": { "size": 22, "weight": 500, "lineHeight": 28, "letterSpacing": 0 },
            "md-sys-typescale-title-medium": { "size": 16, "weight": 500, "lineHeight": 24, "letterSpacing": 0.15 },
            "md-sys-typescale-title-small": { "size": 14, "weight": 500, "lineHeight": 20, "letterSpacing": 0.1 },
            "md-sys-typescale-body-large": { "size": 16, "weight": 400, "lineHeight": 24, "letterSpacing": 0.5 },
            "md-sys-typescale-body-medium": { "size": 14, "weight": 400, "lineHeight": 20, "letterSpacing": 0.25 },
            "md-sys-typescale-body-small": { "size": 12, "weight": 400, "lineHeight": 16, "letterSpacing": 0.4 },
            "md-sys-typescale-label-large": { "size": 14, "weight": 500, "lineHeight": 20, "letterSpacing": 0.1 },
            "md-sys-typescale-label-medium": { "size": 12, "weight": 500, "lineHeight": 16, "letterSpacing": 0.5 },
            "md-sys-typescale-label-small": { "size": 11, "weight": 500, "lineHeight": 16, "letterSpacing": 0.5 }
          }
        }
        """
    }

    static func generateSpacingTokensJSON() -> String {
        """
        {
          "spacing": {
            "md-sys-spacing-none": 0,
            "md-sys-spacing-xxs": 2,
            "md-sys-spacing-xs": 4,
            "md-sys-spacing-sm": 8,
            "md-sys-spacing-md": 12,
            "md-sys-spacing-base": 16,
            "md-sys-spacing-lg": 20,
            "md-sys-spacing-xl": 24,
            "md-sys-spacing-xxl": 32,
            "md-sys-spacing-xxxl": 40,
            "md-sys-spacing-huge": 48,
            "md-sys-spacing-massive": 64
          },
          "shape": {
            "md-sys-shape-corner-none": 0,
            "md-sys-shape-corner-extra-small": 4,
            "md-sys-shape-corner-small": 8,
            "md-sys-shape-corner-medium": 12,
            "md-sys-shape-corner-large": 16,
            "md-sys-shape-corner-extra-large": 28,
            "md-sys-shape-corner-full": 9999
          },
          "elevation": {
            "md-sys-elevation-level0": { "shadow": "none" },
            "md-sys-elevation-level1": { "shadow": "0 1px 3px rgba(0,0,0,0.15)" },
            "md-sys-elevation-level2": { "shadow": "0 3px 6px rgba(0,0,0,0.15)" },
            "md-sys-elevation-level3": { "shadow": "0 6px 8px rgba(0,0,0,0.15)" },
            "md-sys-elevation-level4": { "shadow": "0 8px 12px rgba(0,0,0,0.15)" },
            "md-sys-elevation-level5": { "shadow": "0 12px 16px rgba(0,0,0,0.15)" }
          }
        }
        """
    }

    // Generates a Figma Token Studio-compatible JSON export
    static func generateFullTokensJSON() -> String {
        """
        {
          "$themes": [
            { "name": "Light", "selectedTokenSets": { "global": "enabled", "light": "enabled" } },
            { "name": "Dark", "selectedTokenSets": { "global": "enabled", "dark": "enabled" } }
          ],
          "$metadata": {
            "tokenSetOrder": ["global", "light", "dark"]
          },
          "global": {
            "spacing": {
              "xs": { "value": "4", "type": "spacing" },
              "sm": { "value": "8", "type": "spacing" },
              "md": { "value": "12", "type": "spacing" },
              "base": { "value": "16", "type": "spacing" },
              "lg": { "value": "20", "type": "spacing" },
              "xl": { "value": "24", "type": "spacing" },
              "xxl": { "value": "32", "type": "spacing" }
            },
            "borderRadius": {
              "sm": { "value": "8", "type": "borderRadius" },
              "md": { "value": "12", "type": "borderRadius" },
              "lg": { "value": "16", "type": "borderRadius" },
              "xl": { "value": "28", "type": "borderRadius" },
              "full": { "value": "9999", "type": "borderRadius" }
            },
            "fontFamilies": {
              "rounded": { "value": "SF Pro Rounded", "type": "fontFamilies" },
              "mono": { "value": "SF Mono", "type": "fontFamilies" }
            }
          }
        }
        """
    }
}
