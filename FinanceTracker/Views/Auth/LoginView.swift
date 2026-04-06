import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = AuthViewModel()
    @State private var showRegister = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.xxl) {
                    Spacer().frame(height: M3Spacing.huge)

                    // Logo & welcome
                    VStack(spacing: M3Spacing.md) {
                        ZStack {
                            Circle()
                                .fill(M3Color.Adaptive.primaryContainer)
                                .frame(width: 88, height: 88)
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(M3Color.Adaptive.onPrimaryContainer)
                        }

                        Text(L("记账本"))
                            .font(M3Typography.headlineLarge)
                            .foregroundColor(M3Color.Adaptive.onSurface)

                        Text(L("简约生活，清晰财务"))
                            .font(M3Typography.bodyLarge)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    }

                    // Form
                    VStack(spacing: M3Spacing.base) {
                        DSTextField(
                            label: L("邮箱"),
                            text: $viewModel.email,
                            icon: "envelope.fill",
                            keyboardType: .emailAddress
                        )

                        DSTextField(
                            label: L("密码"),
                            text: $viewModel.password,
                            icon: "lock.fill",
                            isSecure: true
                        )
                    }

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(M3Typography.bodySmall)
                            .foregroundColor(M3Color.Adaptive.error)
                            .padding(.horizontal)
                    }

                    // Actions
                    VStack(spacing: M3Spacing.md) {
                        DSButton(
                            title: L("登录"),
                            variant: .filled,
                            size: .large,
                            isFullWidth: true,
                            isLoading: viewModel.isLoading
                        ) {
                            viewModel.login(modelContext: modelContext)
                        }

                        DSButton(
                            title: L("创建账户"),
                            variant: .text,
                            size: .medium
                        ) {
                            showRegister = true
                        }
                    }
                }
                .padding(.horizontal, M3Spacing.xl)
            }
            .background(M3Color.Adaptive.surface)
            .navigationDestination(isPresented: $showRegister) {
                RegisterView()
            }
        }
    }
}
