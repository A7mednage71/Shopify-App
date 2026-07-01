import Foundation

struct UserDefaultsCartManager: CartManager, Sendable {
    private static let cartIDKey = "com.marktek.cart.id"
    private static let testingCartID = "gid://shopify/Cart/hWNDyenitSQjCY44qIxN5hWk?key=04004bd1b3e54ad5e23600f35c4c5255"

    var cartID: String? {
        if !Self.testingCartID.isEmpty {
            return Self.testingCartID
        }

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
