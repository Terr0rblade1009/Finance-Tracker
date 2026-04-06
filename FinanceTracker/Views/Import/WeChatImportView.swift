import SwiftUI

struct WeChatImportView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ImportViewModel()
    @State private var inputText = ""
    @State private var showResult = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.xl) {
                    instructionCard
                    textInputSection
                    if !viewModel.importedExpenses.isEmpty {
                        parsedResultSection
                    }
                }
                .padding(M3Spacing.base)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("微信导入"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("关闭")) { dismiss() }
                }
            }
        }
    }

    private var instructionCard: some View {
        DSCard(variant: .outlined) {
            VStack(alignment: .leading, spacing: M3Spacing.md) {
                HStack(spacing: M3Spacing.md) {
                    Image(systemName: "message.fill")
                        .font(.system(size: M3IconSize.medium))
                        .foregroundColor(Color(hex: "07C160"))
                    Text(L("从微信导入"))
                        .font(M3Typography.titleMedium)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                }

                VStack(alignment: .leading, spacing: M3Spacing.sm) {
                    instructionStep(number: "1", text: L("打开微信，进入账单或对话"))
                    instructionStep(number: "2", text: L("复制包含金额的文字内容"))
                    instructionStep(number: "3", text: L("粘贴到下方输入框"))
                    instructionStep(number: "4", text: L("系统自动识别金额和内容"))
                }
            }
            .padding(M3Spacing.base)
        }
    }

    private func instructionStep(number: String, text: String) -> some View {
        HStack(alignment: .top, spacing: M3Spacing.md) {
            Text(number)
                .font(M3Typography.labelSmall)
                .foregroundColor(M3Color.Adaptive.onPrimary)
                .frame(width: 20, height: 20)
                .background(M3Color.Adaptive.primary)
                .clipShape(Circle())

            Text(text)
                .font(M3Typography.bodySmall)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
        }
    }

    private var textInputSection: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            Text(L("粘贴内容"))
                .font(M3Typography.labelLarge)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

            TextEditor(text: $inputText)
                .font(M3Typography.bodyMedium)
                .frame(minHeight: 150)
                .padding(M3Spacing.md)
                .background(M3Color.Adaptive.surfaceContainerHigh)
                .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
                .overlay(
                    RoundedRectangle(cornerRadius: M3Radius.medium)
                        .strokeBorder(M3Color.Adaptive.outline, lineWidth: 1)
                )

            DSButton(
                title: L("识别内容"),
                icon: "doc.text.magnifyingglass",
                variant: .filled,
                size: .large,
                isFullWidth: true,
                isDisabled: inputText.isEmpty
            ) {
                viewModel.parseWeChatText(inputText)
            }
        }
    }

    private var parsedResultSection: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            HStack {
                Text(L("识别结果"))
                    .font(M3Typography.titleMedium)
                Spacer()
                Text("\(viewModel.importedExpenses.count) \(L("条"))")
                    .font(M3Typography.labelMedium)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
            }

            ForEach(viewModel.importedExpenses.indices, id: \.self) { index in
                HStack {
                    Toggle("", isOn: $viewModel.importedExpenses[index].isSelected)
                        .labelsHidden()
                    Text(viewModel.importedExpenses[index].note)
                        .font(M3Typography.bodyMedium)
                        .lineLimit(1)
                    Spacer()
                    Text(viewModel.importedExpenses[index].amount.currencyString)
                        .font(M3Typography.titleSmall)
                        .foregroundColor(M3Color.Adaptive.primary)
                }
                .padding(M3Spacing.md)
                .background(M3Color.Adaptive.surfaceContainerLow)
                .clipShape(RoundedRectangle(cornerRadius: M3Radius.small))
            }

            DSButton(
                title: L("导入选中项"),
                icon: "square.and.arrow.down",
                variant: .filled,
                size: .large,
                isFullWidth: true
            ) {
                try? viewModel.saveImportedExpenses(
                    modelContext: modelContext,
                    category: nil,
                    account: nil,
                    sourceType: .wechat
                )
                dismiss()
            }
        }
    }

}
