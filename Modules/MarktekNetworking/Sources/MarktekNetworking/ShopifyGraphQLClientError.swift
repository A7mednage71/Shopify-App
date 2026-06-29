import Apollo
import Foundation

public enum ShopifyGraphQLClientError: LocalizedError {
    case noData
    case graphQLErrors([GraphQLError])

    public var errorDescription: String? {
        switch self {
        case .noData:
            return "No data was returned from the server."
        case .graphQLErrors(let errors):
            return errors
                .map(\.localizedDescription)
                .joined(separator: "\n")
        }
    }
}
