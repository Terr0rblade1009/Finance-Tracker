import Foundation

#if os(iOS)
import Speech
import AVFoundation

@Observable
class VoiceRecognitionService {
    var isRecording = false
    var recognizedText = ""
    var errorMessage: String?
    var audioLevel: Float = 0

    private var audioEngine: AVAudioEngine?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var speechRecognizer: SFSpeechRecognizer?

    static let supportedLocales: [String: Locale] = [
        "zh-Hans": Locale(identifier: "zh-Hans"),
        "en": Locale(identifier: "en-US"),
    ]

    init(localeIdentifier: String = "zh-Hans") {
        self.speechRecognizer = SFSpeechRecognizer(locale: Self.supportedLocales[localeIdentifier] ?? Locale(identifier: "zh-Hans"))
    }

    func switchLocale(_ identifier: String) {
        stopRecording()
        speechRecognizer = SFSpeechRecognizer(locale: Self.supportedLocales[identifier] ?? Locale(identifier: identifier))
    }

    func requestPermission() async -> Bool {
        let speechStatus = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }

        guard speechStatus == .authorized else {
            errorMessage = L("请授权语音识别权限")
            return false
        }

        let audioStatus = await AVAudioApplication.requestRecordPermission()
        guard audioStatus else {
            errorMessage = L("请授权麦克风权限")
            return false
        }

        return true
    }

    func startRecording() throws {
        recognitionTask?.cancel()
        recognitionTask = nil

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        audioEngine = AVAudioEngine()
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        guard let audioEngine = audioEngine,
              let recognitionRequest = recognitionRequest,
              let speechRecognizer = speechRecognizer else {
            throw VoiceError.notAvailable
        }

        recognitionRequest.shouldReportPartialResults = true

        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, _ in
            self?.recognitionRequest?.append(buffer)
            let level = buffer.floatChannelData?[0]
            if let level {
                var sum: Float = 0
                let count = Int(buffer.frameLength)
                for i in 0..<count {
                    sum += abs(level[i])
                }
                DispatchQueue.main.async {
                    self?.audioLevel = sum / Float(count) * 10
                }
            }
        }

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            if let result {
                DispatchQueue.main.async {
                    self?.recognizedText = result.bestTranscription.formattedString
                }
            }
            if error != nil || (result?.isFinal ?? false) {
                DispatchQueue.main.async {
                    self?.stopRecording()
                }
            }
        }

        audioEngine.prepare()
        try audioEngine.start()
        isRecording = true
    }

    func stopRecording() {
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        isRecording = false
        audioLevel = 0
    }

    func parseExpenseFromVoice() -> (amount: Double?, note: String?) {
        let text = recognizedText
        let isChinese = speechRecognizer?.locale.language.languageCode?.identifier == "zh"

        let amountPatterns: [String] = isChinese
            ? [
                #"(\d+\.?\d{0,2})\s*[元块]"#,
                #"[花了用了消费]*\s*(\d+\.?\d{0,2})"#,
            ]
            : [
                #"\$?\s*(\d+\.?\d{0,2})\s*(?:dollars?|bucks?)?"#,
                #"(?:spent|paid|cost)\s*\$?\s*(\d+\.?\d{0,2})"#,
                #"(\d+\.?\d{0,2})"#,
            ]

        var amount: Double?
        for pattern in amountPatterns {
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
               let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
               let range = Range(match.range(at: 1), in: text) {
                amount = Double(String(text[range]))
                if amount != nil { break }
            }
        }

        let noteKeywords: [String] = isChinese
            ? ["买", "吃", "打车", "购", "充值", "缴费", "转账"]
            : ["bought", "ate", "taxi", "paid", "for", "at"]

        var note: String?
        for keyword in noteKeywords {
            if text.lowercased().contains(keyword) {
                note = text
                break
            }
        }

        return (amount, note ?? text)
    }

    enum VoiceError: LocalizedError {
        case notAvailable
        case permissionDenied

        var errorDescription: String? {
            switch self {
            case .notAvailable: return L("语音识别不可用")
            case .permissionDenied: return L("需要语音识别权限")
            }
        }
    }
}
#endif
