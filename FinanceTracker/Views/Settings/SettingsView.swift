import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("colorSchemePreference") private var colorSchemePreference = "system"
    @AppStorage("appLanguage") private var appLanguage = "zh-Hans"
    @Environment(\.modelContext) private var modelContext
    @Query private var expenses: [Expense]
    @State private var showExportSheet = false
    @State private var showDeleteConfirm = false
    @State private var exportContent = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        AccountManagementView()
                    } label: {
                        DSSettingsRow(icon: "wallet.pass.fill", title: L("账户管理"), color: "42A5F5")
                    }

                    NavigationLink {
                        CategoryManagementView()
                    } label: {
                        DSSettingsRow(icon: "square.grid.2x2.fill", title: L("分类管理"), color: "BA68C8")
                    }

                    NavigationLink {
                        FixedExpenseView()
                    } label: {
                        DSSettingsRow(icon: "repeat.circle.fill", title: L("固定开支"), color: "FF8A65")
                    }
                }

                Section(L("外观")) {
                    Picker(selection: $appLanguage) {
                        Text(L("中文")).tag("zh-Hans")
                        Text(L("English")).tag("en")
                    } label: {
                        DSSettingsRow(icon: "globe", title: L("语言"), color: "42A5F5")
                    }
                    .onChange(of: appLanguage) { _, newValue in
                        LanguageManager.shared.currentLanguage = newValue
                    }

                    Picker(selection: $colorSchemePreference) {
                        Text(L("跟随系统")).tag("system")
                        Text(L("浅色模式")).tag("light")
                        Text(L("深色模式")).tag("dark")
                    } label: {
                        DSSettingsRow(icon: "paintpalette.fill", title: L("主题"), color: "9575CD")
                    }
                }

                Section(L("数据")) {
                    Button {
                        exportData()
                    } label: {
                        DSSettingsRow(icon: "square.and.arrow.up.fill", title: L("导出数据 (CSV)"), color: "4DB6AC")
                    }

                    Button {
                        exportJSON()
                    } label: {
                        DSSettingsRow(icon: "doc.text.fill", title: L("导出数据 (JSON)"), color: "64B5F6")
                    }

                    NavigationLink {
                        FileImportView()
                    } label: {
                        DSSettingsRow(icon: "square.and.arrow.down.fill", title: L("导入数据"), color: "81C784")
                    }
                }

                Section(L("快捷记账")) {
                    NavigationLink {
                        CameraReceiptView()
                    } label: {
                        DSSettingsRow(icon: "camera.fill", title: L("拍照记账"), color: "FF8A65")
                    }

                    NavigationLink {
                        VoiceInputView()
                    } label: {
                        DSSettingsRow(icon: "mic.fill", title: L("语音记账"), color: "EF5350")
                    }

                    NavigationLink {
                        WeChatImportView()
                    } label: {
                        DSSettingsRow(icon: "message.fill", title: L("微信导入"), color: "07C160")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showDeleteConfirm = true
                    } label: {
                        DSSettingsRow(icon: "trash.fill", title: L("清除所有数据"), color: "EF5350")
                    }

                    Button(role: .destructive) {
                        isLoggedIn = false
                    } label: {
                        DSSettingsRow(icon: "rectangle.portrait.and.arrow.right", title: L("退出登录"), color: "78909C")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(L("设置"))
            .alert(L("确认删除"), isPresented: $showDeleteConfirm) {
                Button(L("取消"), role: .cancel) {}
                Button(L("删除"), role: .destructive) {
                    deleteAllData()
                }
            } message: {
                Text(L("此操作不可恢复，将删除所有记账数据。"))
            }
            .sheet(isPresented: $showExportSheet) {
                ShareSheet(text: exportContent)
            }
        }
    }

    private func exportData() {
        exportContent = DataExportService.exportToCSV(expenses: expenses)
        showExportSheet = true
    }

    private func exportJSON() {
        if let data = try? DataExportService.exportToJSON(expenses: expenses),
           let text = String(data: data, encoding: .utf8) {
            exportContent = text
            showExportSheet = true
        }
    }

    private func deleteAllData() {
        for expense in expenses {
            modelContext.delete(expense)
        }
        try? modelContext.save()
    }
}

// MARK: - Share Sheet

#if os(iOS)
struct ShareSheet: UIViewControllerRepresentable {
    let text: String

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("finance_export.csv")
        try? text.write(to: tempURL, atomically: true, encoding: .utf8)
        return UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
#endif
