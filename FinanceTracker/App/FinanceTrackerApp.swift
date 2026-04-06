import SwiftUI
import SwiftData

@main
struct FinanceTrackerApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("colorSchemePreference") private var colorSchemePreference = "system"
    @AppStorage("appLanguage") private var appLanguage = "zh-Hans"

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            Expense.self,
            ExpenseCategory.self,
            Account.self,
            Budget.self,
            FixedExpense.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
            .environment(\.locale, Locale(identifier: appLanguage))
            .preferredColorScheme(preferredScheme)
        }
        .modelContainer(sharedModelContainer)
    }

    private var preferredScheme: ColorScheme? {
        switch colorSchemePreference {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }
}
