import SwiftUI

struct VoiceInputView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var voiceService = VoiceRecognitionService()
    @State private var parsedAmount: Double?
    @State private var parsedNote: String?
    @State private var hasPermission = false

    var body: some View {
        NavigationStack {
            VStack(spacing: M3Spacing.xxl) {
                Spacer()

                // Waveform indicator
                waveformView

                // Recognized text
                textDisplay

                // Parsed result
                if let amount = parsedAmount {
                    parsedResultCard(amount: amount)
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
        HStack(spacing: 3) {
            ForEach(0..<20, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
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

    private func parsedResultCard(amount: Double) -> some View {
        DSCard(variant: .outlined) {
            VStack(spacing: M3Spacing.md) {
                HStack {
                    Text(L("识别金额"))
                        .font(M3Typography.labelMedium)
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    Spacer()
                    Text(amount.currencyString)
                        .font(M3Typography.headlineSmall)
                        .foregroundColor(M3Color.Adaptive.primary)
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
                        .font(.system(size: 28))
                        .foregroundColor(.white)
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
            }

            DSButton(
                title: L("确认记录"),
                icon: "checkmark",
                variant: .filled,
                size: .medium
            ) {
                dismiss()
            }
        }
    }

    private func toggleRecording() {
        if voiceService.isRecording {
            voiceService.stopRecording()
            let result = voiceService.parseExpenseFromVoice()
            parsedAmount = result.amount
            parsedNote = result.note
        } else {
            try? voiceService.startRecording()
        }
    }

}
