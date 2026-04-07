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

        // Find user by email first, then verify password with their salt
        let emailToFind = email
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.email == emailToFind }
        )

        do {
            let users = try modelContext.fetch(descriptor)
            if let user = users.first {
                let hash = hashPassword(password, salt: user.passwordSalt)
                if hash == user.passwordHash {
                    user.lastLoginAt = Date()
                    try modelContext.save()
                    currentUser = user
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    UserDefaults.standard.set(user.id.uuidString, forKey: "currentUserId")
                } else {
                    errorMessage = L("邮箱或密码错误")
                }
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
        guard email.contains("@") && email.contains(".") else {
            errorMessage = L("邮箱格式不正确")
            return
        }

        isLoading = true
        errorMessage = nil

        let emailToCheck = email
        let existCheck = FetchDescriptor<User>(
            predicate: #Predicate { $0.email == emailToCheck }
        )

        do {
            let existing = try modelContext.fetch(existCheck)
            if !existing.isEmpty {
                errorMessage = L("该邮箱已注册")
                isLoading = false
                return
            }

            let salt = UUID().uuidString
            let user = User(
                email: email,
                displayName: displayName,
                passwordHash: hashPassword(password, salt: salt),
                passwordSalt: salt
            )
            modelContext.insert(user)

            // C3 + I4: Associate default categories with user
            let defaultExpenseCategories = ExpenseCategory.defaultExpenseCategories()
            let defaultIncomeCategories = ExpenseCategory.defaultIncomeCategories()
            let defaultAccounts = Account.defaultAccounts()

            for cat in defaultExpenseCategories {
                cat.user = user
                modelContext.insert(cat)
            }
            for cat in defaultIncomeCategories {
                cat.user = user
                modelContext.insert(cat)
            }
            for acc in defaultAccounts {
                acc.user = user
                modelContext.insert(acc)
            }

            try modelContext.save()

            currentUser = user
            UserDefaults.standard.set(user.id.uuidString, forKey: "currentUserId")
        } catch {
            errorMessage = L("注册失败") + "：\(error.localizedDescription)"
        }

        isLoading = false
    }

    /// C4: Restore user session from persisted userId on app launch
    func restoreSession(modelContext: ModelContext) {
        guard let userIdString = UserDefaults.standard.string(forKey: "currentUserId"),
              let userId = UUID(uuidString: userIdString) else {
            logout()
            return
        }

        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.id == userId }
        )

        do {
            let users = try modelContext.fetch(descriptor)
            if let user = users.first {
                currentUser = user
            } else {
                // User not found in DB — force re-login
                logout()
            }
        } catch {
            logout()
        }
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "currentUserId")
    }

    /// I8: Salted SHA256 password hashing
    private func hashPassword(_ password: String, salt: String) -> String {
        let salted = password + salt
        let data = Data(salted.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
