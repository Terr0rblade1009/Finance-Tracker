import SwiftUI
import SwiftData

@main
struct FinanceTrackerApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("colorSchemePreference") private var colorSchemePreference = "system"
    @AppStorage("appLanguage") private var appLanguage = "zh-Hans"
    @State private var authViewModel = AuthViewModel()

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
                if isLoggedIn && authViewModel.currentUser != nil {
                    MainTabView()
                        .environment(authViewModel)
                } else {
                    LoginView()
                        .environment(authViewModel)
                }
            }
            .environment(\.locale, Locale(identifier: appLanguage))
            .preferredColorScheme(preferredScheme)
            .task {
                // C4: Restore user session on app launch
                if isLoggedIn {
                    let context = sharedModelContainer.mainContext
                    authViewModel.restoreSession(modelContext: context)
                }
            }
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
