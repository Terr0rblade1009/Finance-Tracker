import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showInputMethodSheet = false
    @State private var activeInputMethod: InputMethod?

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)

                AnalysisView()
                    .tag(1)

                Color.clear
                    .tag(2)

                ImportHubView()
                    .tag(3)

                SettingsView()
                    .tag(4)
            }

            DSTabBar(selectedTab: $selectedTab) {
                showInputMethodSheet = true
            }

            InputMethodSheet(isPresented: $showInputMethodSheet) { method in
                activeInputMethod = method
            }
        }
        .sheet(item: $activeInputMethod) { method in
            switch method {
            case .manual:
                ExpenseInputView()
            case .camera:
                CameraReceiptView()
            case .voice:
                VoiceInputView()
            }
        }
    }
}
