import SwiftUI
import SwiftData

struct VoiceInputView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(filter: #Predicate<ExpenseCategory> { !$0.isIncome }) private var expenseCategories: [ExpenseCategory]
    @Query(filter: #Predicate<ExpenseCategory> { $0.isIncome }) private var incomeCategories: [ExpenseCategory]
    @State private var voiceService = VoiceRecognitionService()
    @State private var parsedAmount: Decimal?
    @State private var parsedNote: String?
    @State private var parsedIsIncome = false
    @State private var parsedCategory: ExpenseCategory?
    @State private var hasPermission = false
    @State private var saveError: String?
    @State private var isParsingWithAI = false
    @State private var usedAI = false

    var body: some View {
        NavigationStack {
            VStack(spacing: M3Spacing.xxl) {
                Spacer()

                // Waveform indicator
                waveformView

                // Recognized text
                textDisplay

                if isParsingWithAI {
                    VStack(spacing: M3Spacing.md) {
                        ProgressView()
                            .controlSize(.small)
                        Text(L("AI 解析中..."))
                            .font(M3Typography.bodySmall)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    }
                }

                if let amount = parsedAmount {
                    parsedResultCard(amount: amount)
                }

                if let error = saveError {
                    Text(error)
                        .font(M3Typography.bodySmall)
                        .foregroundColor(M3Color.Adaptive.error)
                }

                Spacer()

                // Record button
                recordButton

                // Action buttons
                if parsedAmount != nil {
                    actionButtons
                }
            }
            .padding(M3Spacing.xl)
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("语音记账"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("关闭")) { dismiss() }
                }
            }
            .task {
                hasPermission = await voiceService.requestPermission()
            }
        }
    }

    private var waveformView: some View {
        HStack(spacing: M3Spacing.xxs) {
            ForEach(0..<20, id: \.self) { i in
                RoundedRectangle(cornerRadius: M3Spacing.xxs)
                    .fill(M3Color.Adaptive.primary.opacity(voiceService.isRecording ? 0.8 : 0.2))
                    .frame(width: 4, height: barHeight(for: i))
                    .animation(
                        .easeInOut(duration: 0.15)
                            .delay(Double(i) * 0.02),
                        value: voiceService.audioLevel
                    )
            }
        }
        .frame(height: 60)
    }

    private func barHeight(for index: Int) -> CGFloat {
        if voiceService.isRecording {
            let base: CGFloat = 8
            let variation = CGFloat(voiceService.audioLevel) * 50
            let offset = sin(Double(index) * 0.5 + Date().timeIntervalSince1970 * 3) * 0.5 + 0.5
            return base + variation * CGFloat(offset)
        }
        return 8
    }

    private var textDisplay: some View {
        VStack(spacing: M3Spacing.md) {
            if voiceService.recognizedText.isEmpty {
                Text(voiceService.isRecording ? L("正在聆听...") : L("点击麦克风开始语音输入"))
                    .font(M3Typography.bodyLarge)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
            } else {
                Text(voiceService.recognizedText)
                    .font(M3Typography.titleMedium)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                    .multilineTextAlignment(.center)
                    .padding(M3Spacing.base)
                    .background(M3Color.Adaptive.surfaceContainerHigh)
                    .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
            }
        }
    }

    private func parsedResultCard(amount: Decimal) -> some View {
        DSCard(variant: .outlined) {
            VStack(spacing: M3Spacing.md) {
                HStack {
                    Text(L("识别金额"))
                        .font(M3Typography.labelMedium)
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    if usedAI {
                        Text("GPT")
                            .font(M3Typography.labelSmall)
                            .foregroundColor(.white)
                            .padding(.horizontal, M3Spacing.sm)
                            .padding(.vertical, 2)
                            .background(Color(hex: "10A37F"))
                            .clipShape(Capsule())
                    }
                    Spacer()
                    Text(amount.currencyString)
                        .font(M3Typography.headlineSmall)
                        .foregroundColor(parsedIsIncome ? .green : M3Color.Adaptive.primary)
                }
                if parsedIsIncome {
                    HStack {
                        Text(L("类型"))
                            .font(M3Typography.labelMedium)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        Spacer()
                        Text(L("收入"))
                            .font(M3Typography.bodyMedium)
                            .foregroundColor(.green)
                    }
                }
                if let note = parsedNote, !note.isEmpty {
                    HStack {
                        Text(L("备注"))
                            .font(M3Typography.labelMedium)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        Spacer()
                        Text(note)
                            .font(M3Typography.bodyMedium)
                            .foregroundColor(M3Color.Adaptive.onSurface)
                            .multilineTextAlignment(.trailing)
                    }
                }
                if let cat = parsedCategory {
                    HStack {
                        Text(L("分类"))
                            .font(M3Typography.labelMedium)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        Spacer()
                        Label(cat.localizedName, systemImage: cat.icon)
                            .font(M3Typography.bodyMedium)
                            .foregroundColor(Color(hex: cat.colorHex))
                    }
                }
            }
            .padding(M3Spacing.base)
        }
    }

    private var recordButton: some View {
        Button {
            toggleRecording()
        } label: {
            ZStack {
                Circle()
                    .fill(voiceService.isRecording ? M3Color.Adaptive.error : M3Color.Adaptive.primary)
                    .frame(width: 72, height: 72)
                    .m3Shadow(M3Elevation.level3)

                if voiceService.isRecording {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .frame(width: 24, height: 24)
                } else {
                    Image(systemName: "mic.fill")
                        .font(.system(size: M3IconSize.medium))
                        .foregroundColor(M3Color.Adaptive.onPrimary)
                }
            }
        }
        .disabled(!hasPermission)
        .padding(.bottom, M3Spacing.base)
    }

    private var actionButtons: some View {
        HStack(spacing: M3Spacing.md) {
            DSButton(
                title: L("重新录制"),
                icon: "arrow.clockwise",
                variant: .outlined,
                size: .medium
            ) {
                voiceService.recognizedText = ""
                parsedAmount = nil
                parsedNote = nil
                parsedCategory = nil
                saveError = nil
            }

            DSButton(
                title: L("确认记录"),
                icon: "checkmark",
                variant: .filled,
                size: .medium
            ) {
                saveVoiceExpense()
            }
        }
    }

    private func toggleRecording() {
        if voiceService.isRecording {
            voiceService.stopRecording()

            let localResult = voiceService.parseExpenseFromVoice()
            parsedAmount = localResult.amount
            parsedNote = localResult.note
            parsedIsIncome = false
            usedAI = false

            Task {
                let hasKey = await OpenAIOCRService.shared.hasAPIKey
                guard hasKey, !voiceService.recognizedText.isEmpty else { return }

                await MainActor.run { isParsingWithAI = true }

                do {
                    let aiResult = try await OpenAIOCRService.shared.parseExpenseFromText(voiceService.recognizedText)
                    let isIncome = aiResult.isIncome
                    let description = aiResult.note ?? voiceService.recognizedText
                    let cats = await MainActor.run {
                        isIncome ? incomeCategories : expenseCategories
                    }
                    let matched = await OpenAIOCRService.shared.suggestCategory(
                        for: description, isIncome: isIncome, categories: cats.map(\.name)
                    )

                    await MainActor.run {
                        if let amount = aiResult.amount {
                            parsedAmount = amount
                        }
                        if let note = aiResult.note, !note.isEmpty {
                            parsedNote = note
                        }
                        parsedIsIncome = isIncome
                        if let matched {
                            parsedCategory = cats.first {
                                $0.name == matched || $0.localizedName == matched
                            }
                        }
                        usedAI = true
                        isParsingWithAI = false
                    }
                } catch {
                    await MainActor.run { isParsingWithAI = false }
                }
            }
        } else {
            parsedAmount = nil
            parsedNote = nil
            parsedIsIncome = false
            parsedCategory = nil
            usedAI = false
            saveError = nil
            try? voiceService.startRecording()
        }
    }

    private func saveVoiceExpense() {
        guard let amount = parsedAmount, amount > 0 else { return }

        let expense = Expense(
            amount: amount,
            note: parsedNote ?? voiceService.recognizedText,
            date: Date(),
            isIncome: parsedIsIncome,
            category: parsedCategory,
            sourceType: .voice
        )
        modelContext.insert(expense)
        do {
            try modelContext.save()
            dismiss()
        } catch {
            saveError = L("保存失败") + "：\(error.localizedDescription)"
        }
    }
}
