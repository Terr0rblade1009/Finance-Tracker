import SwiftUI

// MARK: - Design System Icon Catalog

struct DSIcon {

    struct Token: Identifiable {
        let id: String
        let sfSymbol: String
        let defaultColorHex: String?

        var defaultColor: Color? {
            guard let hex = defaultColorHex else { return nil }
            return Color(hex: hex)
        }
    }

    // MARK: - Expense Categories

    static let expenseCategory: [Token] = [
        Token(id: "dining",         sfSymbol: "fork.knife",              defaultColorHex: "FF8A65"),
        Token(id: "transport",      sfSymbol: "car.fill",                defaultColorHex: "4FC3F7"),
        Token(id: "shopping",       sfSymbol: "bag.fill",                defaultColorHex: "BA68C8"),
        Token(id: "entertainment",  sfSymbol: "gamecontroller.fill",     defaultColorHex: "FFD54F"),
        Token(id: "healthcare",     sfSymbol: "cross.case.fill",         defaultColorHex: "81C784"),
        Token(id: "education",      sfSymbol: "book.fill",               defaultColorHex: "7986CB"),
        Token(id: "housing",        sfSymbol: "house.fill",              defaultColorHex: "A1887F"),
        Token(id: "utilities",      sfSymbol: "bolt.fill",               defaultColorHex: "4DB6AC"),
        Token(id: "telecom",        sfSymbol: "phone.fill",              defaultColorHex: "9575CD"),
        Token(id: "clothing",       sfSymbol: "tshirt.fill",             defaultColorHex: "F06292"),
        Token(id: "beauty",         sfSymbol: "sparkles",                defaultColorHex: "FFB74D"),
        Token(id: "social",         sfSymbol: "person.2.fill",           defaultColorHex: "64B5F6"),
        Token(id: "pets",           sfSymbol: "pawprint.fill",           defaultColorHex: "AED581"),
        Token(id: "other",          sfSymbol: "ellipsis.circle.fill",    defaultColorHex: "BDBDBD"),
    ]

    // MARK: - Income Categories

    static let incomeCategory: [Token] = [
        Token(id: "salary",         sfSymbol: "banknote.fill",                       defaultColorHex: "66BB6A"),
        Token(id: "bonus",          sfSymbol: "gift.fill",                           defaultColorHex: "FFA726"),
        Token(id: "investment",     sfSymbol: "chart.line.uptrend.xyaxis",           defaultColorHex: "42A5F5"),
        Token(id: "freelance",      sfSymbol: "briefcase.fill",                      defaultColorHex: "AB47BC"),
        Token(id: "redPacket",      sfSymbol: "giftcard.fill",                       defaultColorHex: "EF5350"),
        Token(id: "refund",         sfSymbol: "arrow.uturn.backward.circle.fill",    defaultColorHex: "26C6DA"),
        Token(id: "otherIncome",    sfSymbol: "plus.circle.fill",                    defaultColorHex: "78909C"),
    ]

    // MARK: - Fixed Expense Categories

    static let fixedExpense: [Token] = [
        Token(id: "mortgage",       sfSymbol: "building.2.fill",     defaultColorHex: "8D6E63"),
        Token(id: "rent",           sfSymbol: "house.lodge.fill",    defaultColorHex: "A1887F"),
        Token(id: "carLoan",        sfSymbol: "car.fill",            defaultColorHex: "78909C"),
        Token(id: "insurance",      sfSymbol: "shield.checkered",    defaultColorHex: "90A4AE"),
        Token(id: "tuition",        sfSymbol: "graduationcap.fill",  defaultColorHex: "7986CB"),
        Token(id: "utilityBills",   sfSymbol: "drop.fill",           defaultColorHex: "4DB6AC"),
        Token(id: "internet",       sfSymbol: "wifi",                defaultColorHex: "64B5F6"),
        Token(id: "phoneBill",      sfSymbol: "iphone",              defaultColorHex: "9575CD"),
        Token(id: "membership",     sfSymbol: "star.fill",           defaultColorHex: "FFD54F"),
    ]

    // MARK: - Account Types

    static let account: [Token] = [
        Token(id: "cash",           sfSymbol: "banknote.fill",                                  defaultColorHex: "66BB6A"),
        Token(id: "bankCard",       sfSymbol: "creditcard.fill",                                defaultColorHex: "42A5F5"),
        Token(id: "creditCard",     sfSymbol: "creditcard.trianglebadge.exclamationmark",       defaultColorHex: "EF5350"),
        Token(id: "alipay",         sfSymbol: "a.circle.fill",                                  defaultColorHex: "1677FF"),
        Token(id: "wechatPay",      sfSymbol: "message.fill",                                   defaultColorHex: "07C160"),
        Token(id: "investAccount",  sfSymbol: "chart.line.uptrend.xyaxis",                      defaultColorHex: "FFA726"),
        Token(id: "otherAccount",   sfSymbol: "wallet.pass.fill",                               defaultColorHex: "78909C"),
    ]

    // MARK: - Navigation & Tabs

    static let navigation: [Token] = [
        Token(id: "tabHome",        sfSymbol: "house.fill",                  defaultColorHex: nil),
        Token(id: "tabAnalysis",    sfSymbol: "chart.pie.fill",              defaultColorHex: nil),
        Token(id: "tabImport",      sfSymbol: "tray.and.arrow.down.fill",   defaultColorHex: nil),
        Token(id: "tabSettings",    sfSymbol: "gearshape.fill",             defaultColorHex: nil),
        Token(id: "add",            sfSymbol: "plus",                        defaultColorHex: nil),
        Token(id: "calendar",       sfSymbol: "calendar",                    defaultColorHex: nil),
        Token(id: "back",           sfSymbol: "chevron.left",                defaultColorHex: nil),
        Token(id: "forward",        sfSymbol: "chevron.right",               defaultColorHex: nil),
        Token(id: "prevCircle",     sfSymbol: "chevron.left.circle.fill",    defaultColorHex: nil),
        Token(id: "nextCircle",     sfSymbol: "chevron.right.circle.fill",   defaultColorHex: nil),
    ]

    // MARK: - Import & Actions

    static let action: [Token] = [
        Token(id: "camera",         sfSymbol: "camera.fill",                     defaultColorHex: "FF8A65"),
        Token(id: "microphone",     sfSymbol: "mic.fill",                        defaultColorHex: "EF5350"),
        Token(id: "wechat",         sfSymbol: "message.fill",                    defaultColorHex: "07C160"),
        Token(id: "fileImport",     sfSymbol: "doc.fill",                        defaultColorHex: "42A5F5"),
        Token(id: "screenshot",     sfSymbol: "photo.fill",                      defaultColorHex: "BA68C8"),
        Token(id: "ocr",            sfSymbol: "doc.text.viewfinder",             defaultColorHex: "FF8A65"),
        Token(id: "smartImport",    sfSymbol: "wand.and.stars",                  defaultColorHex: nil),
        Token(id: "exportData",     sfSymbol: "square.and.arrow.up.fill",        defaultColorHex: "4DB6AC"),
        Token(id: "importData",     sfSymbol: "square.and.arrow.down.fill",      defaultColorHex: "81C784"),
        Token(id: "choosePhoto",    sfSymbol: "photo.on.rectangle",              defaultColorHex: nil),
        Token(id: "recognize",      sfSymbol: "doc.text.magnifyingglass",        defaultColorHex: nil),
        Token(id: "retry",          sfSymbol: "arrow.clockwise",                 defaultColorHex: nil),
    ]

    // MARK: - Status & Feedback

    static let status: [Token] = [
        Token(id: "success",        sfSymbol: "checkmark.circle.fill",   defaultColorHex: nil),
        Token(id: "confirm",        sfSymbol: "checkmark",               defaultColorHex: nil),
        Token(id: "delete",         sfSymbol: "trash",                   defaultColorHex: nil),
        Token(id: "deleteFill",     sfSymbol: "trash.fill",              defaultColorHex: "EF5350"),
        Token(id: "search",         sfSymbol: "magnifyingglass",         defaultColorHex: nil),
        Token(id: "clearField",     sfSymbol: "xmark.circle.fill",       defaultColorHex: nil),
        Token(id: "backspace",      sfSymbol: "delete.left",             defaultColorHex: nil),
        Token(id: "edit",           sfSymbol: "pencil",                  defaultColorHex: nil),
        Token(id: "emptyTray",      sfSymbol: "tray",                    defaultColorHex: nil),
        Token(id: "emptyChart",     sfSymbol: "chart.bar",               defaultColorHex: nil),
    ]

    // MARK: - Settings

    static let settings: [Token] = [
        Token(id: "accounts",       sfSymbol: "wallet.pass.fill",                            defaultColorHex: "42A5F5"),
        Token(id: "categories",     sfSymbol: "square.grid.2x2.fill",                        defaultColorHex: "BA68C8"),
        Token(id: "fixedExpenses",  sfSymbol: "repeat.circle.fill",                          defaultColorHex: "FF8A65"),
        Token(id: "language",       sfSymbol: "globe",                                       defaultColorHex: "42A5F5"),
        Token(id: "theme",          sfSymbol: "paintpalette.fill",                           defaultColorHex: "9575CD"),
        Token(id: "logout",         sfSymbol: "rectangle.portrait.and.arrow.right",          defaultColorHex: "78909C"),
    ]

    // MARK: - Auth

    static let auth: [Token] = [
        Token(id: "person",         sfSymbol: "person.fill",         defaultColorHex: nil),
        Token(id: "email",          sfSymbol: "envelope.fill",       defaultColorHex: nil),
        Token(id: "password",       sfSymbol: "lock.fill",           defaultColorHex: nil),
        Token(id: "confirmPass",    sfSymbol: "lock.rotation",       defaultColorHex: nil),
        Token(id: "register",       sfSymbol: "person.badge.plus",   defaultColorHex: nil),
        Token(id: "appLogo",        sfSymbol: "yensign.circle.fill",    defaultColorHex: nil),
    ]

    // MARK: - Extra Picker Icons (for category creation)

    static let pickerExtras: [Token] = [
        Token(id: "tag",            sfSymbol: "tag.fill",                defaultColorHex: nil),
        Token(id: "cart",           sfSymbol: "cart.fill",               defaultColorHex: nil),
        Token(id: "cup",            sfSymbol: "cup.and.saucer.fill",     defaultColorHex: nil),
        Token(id: "airplane",       sfSymbol: "airplane",                defaultColorHex: nil),
        Token(id: "bus",            sfSymbol: "bus.fill",                defaultColorHex: nil),
        Token(id: "tram",           sfSymbol: "tram.fill",               defaultColorHex: nil),
        Token(id: "heart",          sfSymbol: "heart.fill",              defaultColorHex: nil),
        Token(id: "music",          sfSymbol: "music.note",              defaultColorHex: nil),
        Token(id: "tv",             sfSymbol: "tv.fill",                 defaultColorHex: nil),
        Token(id: "computer",       sfSymbol: "desktopcomputer",         defaultColorHex: nil),
        Token(id: "leaf",           sfSymbol: "leaf.fill",               defaultColorHex: nil),
        Token(id: "flame",          sfSymbol: "flame.fill",              defaultColorHex: nil),
    ]

    // MARK: - All tokens flat

    static var all: [Token] {
        expenseCategory + incomeCategory + fixedExpense + account
        + navigation + action + status + settings + auth + pickerExtras
    }
}
