import SwiftUI

@Observable
final class LanguageManager {
    static let shared = LanguageManager()

    var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "appLanguage")
            reloadBundle()
        }
    }

    private(set) var bundle: Bundle = .main
    var locale: Locale { Locale(identifier: currentLanguage) }

    private init() {
        let lang = UserDefaults.standard.string(forKey: "appLanguage") ?? "zh-Hans"
        self.currentLanguage = lang
        reloadBundle()
    }

    private func reloadBundle() {
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
           let b = Bundle(path: path) {
            bundle = b
        } else {
            bundle = .main
        }
    }
}

/// Runtime-localized string lookup that respects the in-app language setting.
func L(_ key: String) -> String {
    NSLocalizedString(key, bundle: LanguageManager.shared.bundle, comment: "")
}
