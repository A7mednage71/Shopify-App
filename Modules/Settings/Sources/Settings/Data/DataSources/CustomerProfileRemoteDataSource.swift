import ApolloAPI
import Common
import Foundation
import MarktekNetworking

enum CustomerProfileError: LocalizedError, Sendable {
    case unauthorized
    case userErrors([String])
    case unknown

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Sign in to view your profile information."
        case .userErrors(let messages):
            return messages.joined(separator: "\n")
        case .unknown:
            return "We could not load your profile information. Please try again."
        }
    }
}

protocol CustomerProfileRemoteDataSource: Sendable {
    func getCustomerProfile() async throws -> CustomerProfileDataModel
    func updateCustomerProfile(_ input: CustomerProfileUpdateInput) async throws -> CustomerProfileDataModel
}

struct ShopifyCustomerProfileRemoteDataSource: CustomerProfileRemoteDataSource, Sendable {
    private let customerAccessTokenProvider: any CustomerAccessTokenProvider

    init(
        customerAccessTokenProvider: any CustomerAccessTokenProvider = KeychainCustomerAccessTokenProvider()
    ) {
        self.customerAccessTokenProvider = customerAccessTokenProvider
    }

    func getCustomerProfile() async throws -> CustomerProfileDataModel {
        let token = try customerAccessToken()
        let data = try await ShopifyGraphQLClient.shared.fetch(GetCustomerProfileQuery(customerAccessToken: token))

        guard let customer = data.customer else {
            throw CustomerProfileError.unauthorized
        }

        return CustomerProfileDataModel(customer: customer)
    }

    func updateCustomerProfile(_ input: CustomerProfileUpdateInput) async throws -> CustomerProfileDataModel {
        let token = try customerAccessToken()
        let mutation = UpdateCustomerProfileMutation(
            customerAccessToken: token,
            customer: input.toGraphQLInput()
        )
        let data = try await ShopifyGraphQLClient.shared.perform(mutation)

        guard let payload = data.customerUpdate else {
            throw CustomerProfileError.unknown
        }

        if !payload.customerUserErrors.isEmpty {
            throw CustomerProfileError.userErrors(payload.customerUserErrors.map(\.message))
        }

        guard let customer = payload.customer else {
            throw CustomerProfileError.unknown
        }

        return CustomerProfileDataModel(customer: customer)
    }

    private func customerAccessToken() throws -> String {
        do {
            return try customerAccessTokenProvider.customerAccessToken()
        } catch CustomerAccessTokenError.missing, CustomerAccessTokenError.expired {
            throw CustomerProfileError.unauthorized
        } catch {
            throw error
        }
    }
}

private extension CustomerProfileUpdateInput {
    func toGraphQLInput() -> ShopifyAPI.CustomerUpdateInput {
        ShopifyAPI.CustomerUpdateInput(
            firstName: .some(firstName.trimmedForProfileUpdate),
            lastName: .some(lastName.trimmedForProfileUpdate),
            phone: phone.trimmedForProfileUpdate.isEmpty ? .null : .some(phone.trimmedForProfileUpdate)
        )
    }
}

private extension String {
    var trimmedForProfileUpdate: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
