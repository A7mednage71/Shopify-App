import Foundation

struct UserDefaultsCartManager: CartManager, Sendable {
    private static let cartIDKey = "com.marktek.cart.id"

    var cartID: String? {
        guard let savedCartID = UserDefaults.standard.string(forKey: Self.cartIDKey) else {
            return nil
        }

        let trimmedCartID = savedCartID.trimmingCharacters(in: .whitespacesAndNewlines)

        return trimmedCartID.isEmpty ? nil : trimmedCartID
    }

    func save(cartID: String) {
        let trimmedCartID = cartID.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedCartID.isEmpty else {
            clearCartID()
            return
        }

        UserDefaults.standard.set(trimmedCartID, forKey: Self.cartIDKey)
    }

    func clearCartID() {
        UserDefaults.standard.removeObject(forKey: Self.cartIDKey)
    }
}
