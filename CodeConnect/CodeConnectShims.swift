import Foundation

/// Shim for Code Connect target — mirrors the app's `L()` function.
func L(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}
