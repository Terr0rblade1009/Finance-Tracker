import SwiftUI
import SwiftData

struct RegisterView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthViewModel.self) private var viewModel
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var showSuccess = false

    private let avatarOptions = ["😊", "🐱", "🌸", "💰", "🎯", "🌈", "🦊", "🐼", "🎨", "🌿"]
    @State private var selectedAvatar = "😊"

    var body: some View {
        @Bindable var viewModel = viewModel
        ScrollView {
            VStack(spacing: M3Spacing.xl) {
                Spacer().frame(height: M3Spacing.lg)

                // Avatar picker
                VStack(spacing: M3Spacing.md) {
                    ZStack {
                        Circle()
                            .fill(M3Color.Adaptive.primaryContainer)
                            .frame(width: 80, height: 80)
                        Text(selectedAvatar)
                            .font(M3Typography.displaySmall)
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: M3Spacing.sm) {
                            ForEach(avatarOptions, id: \.self) { emoji in
                                Button {
                                    selectedAvatar = emoji
                                } label: {
                                    Text(emoji)
                                        .font(M3Typography.headlineMedium)
                                        .frame(width: 48, height: 48)
                                        .background(
                                            selectedAvatar == emoji
                                                ? M3Color.Adaptive.secondaryContainer
                                                : M3Color.Adaptive.surfaceContainerHigh
                                        )
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .padding(.horizontal, M3Spacing.base)
                    }
                }

                // Form
                VStack(spacing: M3Spacing.base) {
                    DSTextField(
                        label: L("昵称"),
                        text: $viewModel.displayName,
                        icon: "person.fill"
                    )

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

                    DSTextField(
                        label: L("确认密码"),
                        text: $viewModel.confirmPassword,
                        icon: "lock.rotation",
                        isSecure: true
                    )
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(M3Typography.bodySmall)
                        .foregroundColor(M3Color.Adaptive.error)
                }

                DSButton(
                    title: L("注册"),
                    icon: "person.badge.plus",
                    variant: .filled,
                    size: .large,
                    isFullWidth: true,
                    isLoading: viewModel.isLoading
                ) {
                    viewModel.register(modelContext: modelContext)
                    if viewModel.currentUser != nil {
                        withAnimation(.spring) { showSuccess = true }
                    }
                }
            }
            .padding(.horizontal, M3Spacing.xl)
        }
        .background(M3Color.Adaptive.surface)
        .navigationTitle(L("创建账户"))
        .navigationBarTitleDisplayMode(.large)
        .overlay {
            if showSuccess {
                successOverlay
            }
        }
        .onAppear {
            viewModel.displayName = ""
            viewModel.confirmPassword = ""
            viewModel.errorMessage = nil
        }
    }

    private var successOverlay: some View {
        ZStack {
            M3Color.scrim
                .ignoresSafeArea()

            VStack(spacing: M3Spacing.base) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(M3Color.Adaptive.primary)
                Text(L("注册成功"))
                    .font(M3Typography.headlineSmall)
                    .foregroundColor(M3Color.Adaptive.inverseOnSurface)
                Text(L("欢迎使用记账本"))
                    .font(M3Typography.bodyMedium)
                    .foregroundColor(M3Color.Adaptive.inverseOnSurface.opacity(0.7))
            }
            .transition(.scale.combined(with: .opacity))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation { showSuccess = false }
                isLoggedIn = true
            }
        }
    }
}
