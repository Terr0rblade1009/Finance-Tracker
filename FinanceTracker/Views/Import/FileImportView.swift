import SwiftUI
import UniformTypeIdentifiers
#if os(iOS)
import PDFKit
#endif

struct FileImportView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ImportViewModel()
    @State private var showFilePicker = false
    @State private var importedCount = 0
    @State private var showResult = false
    @State private var usedAI = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.xl) {
                    importOptionsGrid
                    if viewModel.isProcessing { processingView }
                    if !viewModel.importedExpenses.isEmpty { parsedExpensesList }
                    if showResult { resultBanner }
                }
                .padding(M3Spacing.base)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("导入文件"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("关闭")) { dismiss() }
                }
            }
            .fileImporter(
                isPresented: $showFilePicker,
                allowedContentTypes: [.pdf, .image, .plainText, .commaSeparatedText],
                allowsMultipleSelection: false
            ) { result in
                handleFileImport(result)
            }
        }
    }

    private var importOptionsGrid: some View {
        VStack(spacing: M3Spacing.md) {
            Text(L("选择导入方式"))
                .font(M3Typography.titleMedium)
                .foregroundColor(M3Color.Adaptive.onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: M3Spacing.md) {
                DSImportCard(icon: "doc.text.fill", title: L("CSV文件"), subtitle: L("导入CSV格式"), color: M3Color.Adaptive.primary) {
                    showFilePicker = true
                }
                DSImportCard(icon: "doc.richtext.fill", title: L("PDF文件"), subtitle: L("导入PDF账单"), color: M3Color.Adaptive.primary) {
                    showFilePicker = true
                }
                DSImportCard(icon: "photo.fill", title: L("图片文件"), subtitle: L("JPG/PNG格式"), color: M3Color.Adaptive.primary) {
                    showFilePicker = true
                }
                DSImportCard(icon: "square.and.arrow.down.fill", title: L("其他格式"), subtitle: L("通用导入"), color: M3Color.Adaptive.primary) {
                    showFilePicker = true
                }
            }
        }
    }

    private var processingView: some View {
        VStack(spacing: M3Spacing.md) {
            ProgressView()
            Text(usedAI ? L("AI 识别中...") : L("正在处理文件..."))
                .font(M3Typography.bodyMedium)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
        }
        .padding(M3Spacing.xl)
    }

    private var parsedExpensesList: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            HStack {
                Text(L("解析结果"))
                    .font(M3Typography.titleMedium)
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
                Text("\(viewModel.importedExpenses.count) \(L("条记录"))")
                    .font(M3Typography.labelMedium)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
            }

            ForEach(viewModel.importedExpenses.indices, id: \.self) { index in
                HStack {
                    Toggle("", isOn: $viewModel.importedExpenses[index].isSelected)
                        .labelsHidden()

                    VStack(alignment: .leading) {
                        Text(viewModel.importedExpenses[index].note)
                            .font(M3Typography.bodyMedium)
                            .lineLimit(1)
                        Text(viewModel.importedExpenses[index].date.formatted())
                            .font(M3Typography.labelSmall)
                            .foregroundColor(M3Color.Adaptive.outline)
                    }

                    Spacer()

                    Text(viewModel.importedExpenses[index].amount.currencyString)
                        .font(M3Typography.titleSmall)
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
                isFullWidth: true,
                isDisabled: viewModel.importedExpenses.filter(\.isSelected).isEmpty
            ) {
                importSelected()
            }
        }
    }

    private var resultBanner: some View {
        HStack(spacing: M3Spacing.md) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(M3Color.Adaptive.primary)
            Text(String(format: L("成功导入 %lld 条记录"), importedCount))
                .font(M3Typography.bodyMedium)
        }
        .padding(M3Spacing.base)
        .frame(maxWidth: .infinity)
        .background(M3Color.Adaptive.primaryContainer.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
    }

    private func handleFileImport(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else { return }
            viewModel.isProcessing = true
            usedAI = false

            guard url.startAccessingSecurityScopedResource() else {
                viewModel.isProcessing = false
                return
            }

            let ext = url.pathExtension.lowercased()

            if ext == "csv" {
                if let content = try? String(contentsOf: url, encoding: .utf8) {
                    do {
                        importedCount = try DataExportService.importFromCSV(content, modelContext: modelContext)
                        showResult = true
                    } catch {}
                }
                url.stopAccessingSecurityScopedResource()
                viewModel.isProcessing = false
                return
            }

            Task {
                let hasKey = await OpenAIOCRService.shared.hasAPIKey

                if ext == "pdf" {
                    let images = OpenAIOCRService.renderPDFToImages(url: url)
                    url.stopAccessingSecurityScopedResource()

                    if hasKey && !images.isEmpty {
                        await MainActor.run { usedAI = true }
                        await processImagesWithAI(images)
                    } else if !images.isEmpty {
                        await processImagesWithLocalOCR(images)
                    } else {
                        await MainActor.run {
                            viewModel.errorMessage = L("无法读取PDF文件")
                            viewModel.isProcessing = false
                        }
                    }
                } else if ["jpg", "jpeg", "png", "heic", "heif", "webp"].contains(ext) {
                    let imageData = try? Data(contentsOf: url)
                    url.stopAccessingSecurityScopedResource()

                    if let data = imageData, let image = UIImage(data: data) {
                        if hasKey {
                            await MainActor.run { usedAI = true }
                            await processImagesWithAI([image])
                        } else {
                            await processImagesWithLocalOCR([image])
                        }
                    } else {
                        await MainActor.run {
                            viewModel.errorMessage = L("无法读取图片文件")
                            viewModel.isProcessing = false
                        }
                    }
                } else {
                    let content = try? String(contentsOf: url, encoding: .utf8)
                    url.stopAccessingSecurityScopedResource()

                    if let text = content, !text.isEmpty {
                        if hasKey {
                            await MainActor.run { usedAI = true }
                            await viewModel.parseWithAI(text)
                        } else {
                            await MainActor.run {
                                viewModel.recognizedText = text
                                viewModel.parseRecognizedText()
                                viewModel.isProcessing = false
                            }
                        }
                    } else {
                        await MainActor.run {
                            viewModel.errorMessage = L("无法读取文件内容")
                            viewModel.isProcessing = false
                        }
                    }
                }
            }

        case .failure:
            viewModel.errorMessage = L("文件导入失败")
        }
    }

    private func processImagesWithAI(_ images: [UIImage]) async {
        do {
            let expenses = try await OpenAIOCRService.shared.extractExpensesFromImages(images)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            await MainActor.run {
                viewModel.importedExpenses = expenses.map { item in
                    ImportViewModel.ParsedExpense(
                        amount: item.amount,
                        note: item.note,
                        date: item.date.flatMap { dateFormatter.date(from: $0) } ?? Date(),
                        isIncome: item.isIncome
                    )
                }
                viewModel.isProcessing = false
            }
        } catch {
            await MainActor.run {
                viewModel.errorMessage = L("AI识别失败") + ": \(error.localizedDescription)"
                viewModel.isProcessing = false
            }
        }
    }

    private func processImagesWithLocalOCR(_ images: [UIImage]) async {
        var allText = ""
        for image in images {
            if let text = try? await OCRService.shared.recognizeText(from: image) {
                allText += text + "\n"
            }
        }

        await MainActor.run {
            if allText.isEmpty {
                viewModel.errorMessage = L("无法识别文件内容")
            } else {
                viewModel.recognizedText = allText
                viewModel.parseRecognizedText()
            }
            viewModel.isProcessing = false
        }
    }

    private func importSelected() {
        do {
            try viewModel.saveImportedExpenses(
                modelContext: modelContext,
                category: nil,
                account: nil,
                sourceType: .fileImport
            )
            importedCount = viewModel.importedExpenses.filter(\.isSelected).count
            showResult = true
        } catch {}
    }
}
