import Apollo
import ApolloAPI
import Foundation
 
public final class ShopifyGraphQLClient {
    public static let shared = ShopifyGraphQLClient()
 
    private let apollo: ApolloClient

    public var underlyingClient: ApolloClient {
        apollo
    }
 
    private init() {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
 
        let provider = DefaultInterceptorProvider(
            store: store
        )
 
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: Secrets.shopifyStorefrontGraphQLEndpoint,
            additionalHeaders: [
                "Content-Type": "application/json",
                "X-Shopify-Storefront-Access-Token": Secrets.shopifyStorefrontAccessToken
            ]
        )
 
        self.apollo = ApolloClient(
            networkTransport: transport,
            store: store
        )
    }
 
    public func fetch<Query: GraphQLQuery>(
        _ query: Query
    ) async throws -> Query.Data {
        let result: GraphQLResult<Query.Data> = try await withCheckedThrowingContinuation { continuation in
            apollo.fetch(
                query: query,
                cachePolicy: .fetchIgnoringCacheCompletely,
                queue: .main
            ) { result in
                continuation.resume(with: result)
            }
        }
 
        return try extractData(from: result)
    }
 
    public func perform<Mutation: GraphQLMutation>(
        _ mutation: Mutation
    ) async throws -> Mutation.Data {
        let result: GraphQLResult<Mutation.Data> = try await withCheckedThrowingContinuation { continuation in
            apollo.perform(
                mutation: mutation,
                publishResultToStore: false,
                queue: .main
            ) { result in
                continuation.resume(with: result)
            }
        }
 
        return try extractData(from: result)
    }
 
    private func extractData<Data: RootSelectionSet>(
        from result: GraphQLResult<Data>
    ) throws -> Data {
        if let errors = result.errors, !errors.isEmpty {
            throw ShopifyGraphQLClientError.graphQLErrors(errors)
        }
 
        guard let data = result.data else {
            throw ShopifyGraphQLClientError.noData
        }
 
        return data
    }
}
