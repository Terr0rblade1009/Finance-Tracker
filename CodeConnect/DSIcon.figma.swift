import SwiftUI
import Figma

// MARK: - Expense Category Icons

struct DSIcon_dining: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-5"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "fork.knife"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "FF8A65"))
    }
}

struct DSIcon_transport: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-8"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "car.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "4FC3F7"))
    }
}

struct DSIcon_shopping: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-11"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "bag.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "BA68C8"))
    }
}

struct DSIcon_entertainment: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-14"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "gamecontroller.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "FFD54F"))
    }
}

struct DSIcon_healthcare: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-17"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "cross.case.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "81C784"))
    }
}

struct DSIcon_education: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-20"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "book.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "7986CB"))
    }
}

struct DSIcon_housing: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-23"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "house.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "A1887F"))
    }
}

struct DSIcon_utilities: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-26"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "bolt.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "4DB6AC"))
    }
}

struct DSIcon_telecom: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-29"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "phone.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "9575CD"))
    }
}

struct DSIcon_clothing: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-32"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "tshirt.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "F06292"))
    }
}

struct DSIcon_beauty: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-35"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "sparkles"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "FFB74D"))
    }
}

struct DSIcon_social: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-38"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "person.2.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "64B5F6"))
    }
}

struct DSIcon_pets: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-41"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "pawprint.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "AED581"))
    }
}

struct DSIcon_other: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=151-44"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "ellipsis.circle.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "BDBDBD"))
    }
}

// MARK: - Income Category Icons

struct DSIcon_salary: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-5"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "banknote.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "66BB6A"))
    }
}

struct DSIcon_bonus: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-8"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "gift.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "FFA726"))
    }
}

struct DSIcon_investment: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-11"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "chart.line.uptrend.xyaxis"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "42A5F5"))
    }
}

struct DSIcon_freelance: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-14"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "briefcase.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "AB47BC"))
    }
}

struct DSIcon_redPacket: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-17"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "giftcard.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "EF5350"))
    }
}

struct DSIcon_refund: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-20"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "arrow.uturn.backward.circle.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "26C6DA"))
    }
}

struct DSIcon_otherIncome: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-23"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "plus.circle.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "78909C"))
    }
}

// MARK: - Navigation Icons

struct DSIcon_tabHome: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-29"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "house.fill"

    var body: some View {
        Image(systemName: sfSymbol)
    }
}

struct DSIcon_tabAnalysis: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-32"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "chart.pie.fill"

    var body: some View {
        Image(systemName: sfSymbol)
    }
}

struct DSIcon_tabImport: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-35"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "tray.and.arrow.down.fill"

    var body: some View {
        Image(systemName: sfSymbol)
    }
}

struct DSIcon_tabSettings: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-38"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "gearshape.fill"

    var body: some View {
        Image(systemName: sfSymbol)
    }
}

struct DSIcon_camera: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-5"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "camera.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "FF8A65"))
    }
}

struct DSIcon_microphone: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-8"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "mic.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(Color(hex: "EF5350"))
    }
}

struct DSIcon_success: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-44"

    @FigmaString("sfSymbol")
    var sfSymbol: String = "checkmark.circle.fill"

    var body: some View {
        Image(systemName: sfSymbol)
            .foregroundColor(M3Color.Adaptive.primary)
    }
}
