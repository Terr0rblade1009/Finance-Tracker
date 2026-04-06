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

// MARK: - Fixed Expense Icons

struct DSIcon_mortgage: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-29"
    var body: some View { Image(systemName: "building.2.fill").foregroundColor(Color(hex: "8D6E63")) }
}

struct DSIcon_rent: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-32"
    var body: some View { Image(systemName: "house.lodge.fill").foregroundColor(Color(hex: "A1887F")) }
}

struct DSIcon_carLoan: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-35"
    var body: some View { Image(systemName: "car.fill").foregroundColor(Color(hex: "78909C")) }
}

struct DSIcon_insurance: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-38"
    var body: some View { Image(systemName: "shield.checkered").foregroundColor(Color(hex: "90A4AE")) }
}

struct DSIcon_tuition: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-41"
    var body: some View { Image(systemName: "graduationcap.fill").foregroundColor(Color(hex: "7986CB")) }
}

struct DSIcon_utilityBills: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-44"
    var body: some View { Image(systemName: "drop.fill").foregroundColor(Color(hex: "4DB6AC")) }
}

struct DSIcon_internet: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-47"
    var body: some View { Image(systemName: "wifi").foregroundColor(Color(hex: "64B5F6")) }
}

struct DSIcon_phoneBill: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-50"
    var body: some View { Image(systemName: "iphone").foregroundColor(Color(hex: "9575CD")) }
}

struct DSIcon_membership: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=154-53"
    var body: some View { Image(systemName: "star.fill").foregroundColor(Color(hex: "FFD54F")) }
}

// MARK: - Account Type Icons

struct DSIcon_cash: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-5"
    var body: some View { Image(systemName: "banknote.fill").foregroundColor(Color(hex: "66BB6A")) }
}

struct DSIcon_bankCard: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-8"
    var body: some View { Image(systemName: "creditcard.fill").foregroundColor(Color(hex: "42A5F5")) }
}

struct DSIcon_creditCard: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-11"
    var body: some View { Image(systemName: "creditcard.trianglebadge.exclamationmark").foregroundColor(Color(hex: "EF5350")) }
}

struct DSIcon_alipay: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-14"
    var body: some View { Image(systemName: "a.circle.fill").foregroundColor(Color(hex: "1677FF")) }
}

struct DSIcon_wechatPay: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-17"
    var body: some View { Image(systemName: "message.fill").foregroundColor(Color(hex: "07C160")) }
}

struct DSIcon_investAccount: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-20"
    var body: some View { Image(systemName: "chart.line.uptrend.xyaxis").foregroundColor(Color(hex: "FFA726")) }
}

struct DSIcon_otherAccount: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-23"
    var body: some View { Image(systemName: "wallet.pass.fill").foregroundColor(Color(hex: "78909C")) }
}

// MARK: - Navigation & Action Icons

struct DSIcon_add: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-41"
    var body: some View { Image(systemName: "plus") }
}

struct DSIcon_calendar: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-44"
    var body: some View { Image(systemName: "calendar") }
}

struct DSIcon_back: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-47"
    var body: some View { Image(systemName: "chevron.left") }
}

struct DSIcon_forward: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-50"
    var body: some View { Image(systemName: "chevron.right") }
}

struct DSIcon_prevCircle: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-53"
    var body: some View { Image(systemName: "chevron.left.circle.fill") }
}

struct DSIcon_nextCircle: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=155-56"
    var body: some View { Image(systemName: "chevron.right.circle.fill") }
}

// MARK: - Import & Action Icons (extended)

struct DSIcon_wechat: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-11"
    var body: some View { Image(systemName: "message.fill").foregroundColor(Color(hex: "07C160")) }
}

struct DSIcon_fileImport: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-14"
    var body: some View { Image(systemName: "doc.fill").foregroundColor(Color(hex: "42A5F5")) }
}

struct DSIcon_screenshot: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-17"
    var body: some View { Image(systemName: "photo.fill").foregroundColor(Color(hex: "BA68C8")) }
}

struct DSIcon_ocr: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-20"
    var body: some View { Image(systemName: "doc.text.viewfinder").foregroundColor(Color(hex: "FF8A65")) }
}

struct DSIcon_smartImport: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-23"
    var body: some View { Image(systemName: "wand.and.stars") }
}

struct DSIcon_exportData: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-26"
    var body: some View { Image(systemName: "square.and.arrow.up.fill").foregroundColor(Color(hex: "4DB6AC")) }
}

struct DSIcon_importData: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-29"
    var body: some View { Image(systemName: "square.and.arrow.down.fill").foregroundColor(Color(hex: "81C784")) }
}

struct DSIcon_choosePhoto: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-32"
    var body: some View { Image(systemName: "photo.on.rectangle") }
}

struct DSIcon_recognize: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-35"
    var body: some View { Image(systemName: "doc.text.magnifyingglass") }
}

struct DSIcon_retry: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-38"
    var body: some View { Image(systemName: "arrow.clockwise") }
}

// MARK: - Status & Feedback Icons (extended)

struct DSIcon_confirm: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-47"
    var body: some View { Image(systemName: "checkmark") }
}

struct DSIcon_delete: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-50"
    var body: some View { Image(systemName: "trash") }
}

struct DSIcon_deleteFill: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-53"
    var body: some View { Image(systemName: "trash.fill").foregroundColor(Color(hex: "EF5350")) }
}

struct DSIcon_search: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-56"
    var body: some View { Image(systemName: "magnifyingglass") }
}

struct DSIcon_clearField: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-59"
    var body: some View { Image(systemName: "xmark.circle.fill") }
}

struct DSIcon_backspace: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-62"
    var body: some View { Image(systemName: "delete.left") }
}

struct DSIcon_edit: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-65"
    var body: some View { Image(systemName: "pencil") }
}

struct DSIcon_emptyTray: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-68"
    var body: some View { Image(systemName: "tray") }
}

struct DSIcon_emptyChart: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=156-71"
    var body: some View { Image(systemName: "chart.bar") }
}

// MARK: - Settings Icons

struct DSIcon_accounts: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-5"
    var body: some View { Image(systemName: "wallet.pass.fill").foregroundColor(Color(hex: "42A5F5")) }
}

struct DSIcon_categories: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-8"
    var body: some View { Image(systemName: "square.grid.2x2.fill").foregroundColor(Color(hex: "BA68C8")) }
}

struct DSIcon_fixedExpenses: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-11"
    var body: some View { Image(systemName: "repeat.circle.fill").foregroundColor(Color(hex: "FF8A65")) }
}

struct DSIcon_language: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-14"
    var body: some View { Image(systemName: "globe").foregroundColor(Color(hex: "42A5F5")) }
}

struct DSIcon_theme: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-17"
    var body: some View { Image(systemName: "paintpalette.fill").foregroundColor(Color(hex: "9575CD")) }
}

struct DSIcon_logout: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-20"
    var body: some View { Image(systemName: "rectangle.portrait.and.arrow.right").foregroundColor(Color(hex: "78909C")) }
}

// MARK: - Auth Icons

struct DSIcon_person: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-26"
    var body: some View { Image(systemName: "person.fill") }
}

struct DSIcon_email: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-29"
    var body: some View { Image(systemName: "envelope.fill") }
}

struct DSIcon_password: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-32"
    var body: some View { Image(systemName: "lock.fill") }
}

struct DSIcon_confirmPass: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-35"
    var body: some View { Image(systemName: "lock.rotation") }
}

struct DSIcon_register: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-38"
    var body: some View { Image(systemName: "person.badge.plus") }
}

struct DSIcon_appLogo: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-41"
    var body: some View { Image(systemName: "yensign.circle.fill") }
}

// MARK: - Picker Extra Icons

struct DSIcon_tag: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-47"
    var body: some View { Image(systemName: "tag.fill") }
}

struct DSIcon_cart: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-50"
    var body: some View { Image(systemName: "cart.fill") }
}

struct DSIcon_cup: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-53"
    var body: some View { Image(systemName: "cup.and.saucer.fill") }
}

struct DSIcon_airplane: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-56"
    var body: some View { Image(systemName: "airplane") }
}

struct DSIcon_bus: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-59"
    var body: some View { Image(systemName: "bus.fill") }
}

struct DSIcon_tram: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-62"
    var body: some View { Image(systemName: "tram.fill") }
}

struct DSIcon_heart: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-65"
    var body: some View { Image(systemName: "heart.fill") }
}

struct DSIcon_music: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-68"
    var body: some View { Image(systemName: "music.note") }
}

struct DSIcon_tv: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-71"
    var body: some View { Image(systemName: "tv.fill") }
}

struct DSIcon_computer: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-74"
    var body: some View { Image(systemName: "desktopcomputer") }
}

struct DSIcon_leaf: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-77"
    var body: some View { Image(systemName: "leaf.fill") }
}

struct DSIcon_flame: FigmaConnect {
    let component = Image.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=157-80"
    var body: some View { Image(systemName: "flame.fill") }
}
