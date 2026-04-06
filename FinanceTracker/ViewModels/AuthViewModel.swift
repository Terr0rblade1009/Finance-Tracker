import Foundation
import SwiftUI
import SwiftData
import CryptoKit

@Observable
class AuthViewModel {
    var email = ""
    var password = ""
    var confirmPassword = ""
    var displayName = ""
    var isLoading = false
    var errorMessage: String?
    var currentUser: User?

    func login(modelContext: ModelContext) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = L("请填写邮箱和密码")
            return
        }

        isLoading = true
        errorMessage = nil

        let hash = hashPassword(password)
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.email == email && $0.passwordHash == hash }
        )

        do {
            let users = try modelContext.fetch(descriptor)
            if let user = users.first {
                user.lastLoginAt = Date()
                try modelContext.save()
                currentUser = user
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(user.id.uuidString, forKey: "currentUserId")
            } else {
                errorMessage = L("邮箱或密码错误")
            }
        } catch {
            errorMessage = L("登录失败") + "：\(error.localizedDescription)"
        }

        isLoading = false
    }

    func register(modelContext: ModelContext) {
        guard !email.isEmpty, !password.isEmpty, !displayName.isEmpty else {
            errorMessage = L("请填写所有必填项")
            return
        }
        guard password == confirmPassword else {
            errorMessage = L("两次密码不一致")
            return
        }
        guard password.count >= 6 else {
            errorMessage = L("密码至少6位")
            return
        }

        isLoading = true
        errorMessage = nil

        let existCheck = FetchDescriptor<User>(
            predicate: #Predicate { $0.email == email }
        )

        do {
            let existing = try modelContext.fetch(existCheck)
            if !existing.isEmpty {
                errorMessage = L("该邮箱已注册")
                isLoading = false
                return
            }

            let user = User(
                email: email,
                displayName: displayName,
                passwordHash: hashPassword(password)
            )
            modelContext.insert(user)

            let defaultExpenseCategories = ExpenseCategory.defaultExpenseCategories()
            let defaultIncomeCategories = ExpenseCategory.defaultIncomeCategories()
            let defaultAccounts = Account.defaultAccounts()

            for cat in defaultExpenseCategories { modelContext.insert(cat) }
            for cat in defaultIncomeCategories { modelContext.insert(cat) }
            for acc in defaultAccounts {
                acc.user = user
                modelContext.insert(acc)
            }

            try modelContext.save()

            currentUser = user
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(user.id.uuidString, forKey: "currentUserId")
        } catch {
            errorMessage = L("注册失败") + "：\(error.localizedDescription)"
        }

        isLoading = false
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "currentUserId")
    }

    private func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
