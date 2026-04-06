import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var email: String
    var displayName: String
    var passwordHash: String
    var avatarEmoji: String
    var currency: String
    var createdAt: Date
    var lastLoginAt: Date

    @Relationship(deleteRule: .cascade) var expenses: [Expense]?
    @Relationship(deleteRule: .cascade) var accounts: [Account]?
    @Relationship(deleteRule: .cascade) var budgets: [Budget]?

    init(
        email: String,
        displayName: String,
        passwordHash: String,
        avatarEmoji: String = "😊",
        currency: String = "SGD"
    ) {
        self.id = UUID()
        self.email = email
        self.displayName = displayName
        self.passwordHash = passwordHash
        self.avatarEmoji = avatarEmoji
        self.currency = currency
        self.createdAt = Date()
        self.lastLoginAt = Date()
    }
}
