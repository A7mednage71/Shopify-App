import Foundation
import FirebaseAuth
import Common
class AuthenticationRepositarory: AuthRepoInterface {

    var firebaseAuth: AuthenticationServiceViaPlatform
    var apiAuth: AuthenticationService
    private let tokenStore = KeychainTokenStore()

    init(firebaseAuth: AuthenticationServiceViaPlatform, apiAuth: AuthenticationService) {
        self.firebaseAuth = firebaseAuth
        self.apiAuth = apiAuth
    }

    @available(iOS 13.0.0, *)
    func signIn(email: String, password: String) async throws {
        try await loginToShopifyAndSaveToken(email: email, password: password)
    }

    @available(iOS 13.0.0, *)
    func signInByGoogle() async throws {
        let (email, generatedPassword, firstName, lastName) = try await firebaseAuth.signInUsingGoogle()
        do {
            try await loginToShopifyAndSaveToken(email: email, password: generatedPassword)
        } catch AuthError.invalidCredentials, AuthError.userNotFound {
            try await createShopifyCustomer(
                email: email,
                password: generatedPassword,
                firstName: firstName,
                lastName: lastName
            )
            try await loginToShopifyAndSaveToken(email: email, password: generatedPassword)
        }
    }

    @available(iOS 13.0.0, *)
    func createUserWithEmailAndPassword(email: String, password: String ,firstName : String , lastName : String) async throws {
        try await createShopifyCustomer(email: email, password: password, firstName: firstName, lastName: lastName)
        try await loginToShopifyAndSaveToken(email: email, password: password)
    }

    @available(iOS 13.0.0, *)
    private func createShopifyCustomer(email: String, password: String, firstName: String, lastName: String) async throws {
        try await apiAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName
        )
    }

    func signOut() async throws {
        tokenStore.delete()
        try await firebaseAuth.signOut()
    }

    private func loginToShopifyAndSaveToken(email: String, password: String) async throws {
        let token = try await apiAuth.signInUsingEmailAndPassword(email: email, password: password)

        let stored = StoredCustomerToken(
            accessToken: token.accessToken,
            expiresAt: token.expiresAt
        )
        try tokenStore.save(stored)
    }
}
