import Foundation
import MarktekNetworking
import ShopifyAPI

public final class ApiAuth : AuthenticationService {

    
    public static let shared = ApiAuth()
    private let client = ShopifyGraphQLClient.shared

    private init() {}
    
    func createUserWithEmailAndPassword(email: String, password: String , firstName : String , lastName : String) async throws  {
        let mutation = CustomerRegisterMutation(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )

        let data: CustomerRegisterMutation.Data
        do {
            data = try await client.perform(mutation)
        } catch {
            throw AuthError.networkError
        }

        let payload = data.customerCreate

        if let firstError = payload?.customerUserErrors.first {
            throw AuthError.from(code: firstError.code)
        }

        guard payload?.customer != nil else {
            throw AuthError.unknown
        }

        
    }
    func signInUsingEmailAndPassword(email: String, password: String) async throws -> CustomerDto{
        let mutation = CustomerLoginMutation(email: email, password: password)

        let data: CustomerLoginMutation.Data
        do {
            data = try await client.perform(mutation)
        } catch {
            throw AuthError.networkError
        }

        let payload = data.customerAccessTokenCreate

        if let firstError = payload?.customerUserErrors.first {
            throw AuthError.from(code: firstError.code)
        }

        guard let tokenData = payload?.customerAccessToken else {
            throw AuthError.unknown
        }
        

        return CustomerDto(
            accessToken: tokenData.accessToken,
            expiresAt: tokenData.expiresAt
        )
    }


    public func signOut() {
        // handled in repository
    }
}
