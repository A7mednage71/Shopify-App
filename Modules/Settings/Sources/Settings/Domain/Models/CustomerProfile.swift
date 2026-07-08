import Foundation

public struct CustomerProfile: Equatable, Sendable {
    public let id: String
    public let firstName: String?
    public let lastName: String?
    public let email: String?
    public let phone: String?
    public let createdAt: String

    public init(
        id: String,
        firstName: String?,
        lastName: String?,
        email: String?,
        phone: String?,
        createdAt: String
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.createdAt = createdAt
    }

    public var displayName: String {
        let name = [firstName, lastName]
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")

        return name.isEmpty ? "Marktek Customer" : name
    }

    public var displayEmail: String {
        let trimmedEmail = email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return trimmedEmail.isEmpty ? "No email available" : trimmedEmail
    }

    public var displayPhone: String {
        let trimmedPhone = phone?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return trimmedPhone.isEmpty ? "No phone available" : trimmedPhone
    }

    public var displayCreatedAt: String {
        guard let date = Self.isoDateFormatter.date(from: createdAt) else {
            return createdAt
        }

        return Self.displayDateFormatter.string(from: date)
    }

    private static let isoDateFormatter = ISO8601DateFormatter()

    private static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

public struct CustomerProfileUpdateInput: Equatable, Sendable {
    public let firstName: String
    public let lastName: String
    public let phone: String

    public init(
        firstName: String,
        lastName: String,
        phone: String
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
    }
}
