import Apollo
import ApolloAPI
import Foundation

public final class ShopifyGraphQLClient {
    public static let shared = ShopifyGraphQLClient()

    private let apollo: ApolloClient

    private init() {
        let store = ApolloStore(cache: InMemoryNormalizedCache())

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "X-Shopify-Storefront-Access-Token": Secrets.shopifyStorefrontAccessToken,
        ]

        let urlSession = URLSession(configuration: configuration)

        let transport = RequestChainNetworkTransport(
            urlSession: urlSession,
            interceptorProvider: DefaultInterceptorProvider.shared,
            store: store,
            endpointURL: Secrets.shopifyStorefrontGraphQLEndpoint
        )

        apollo = ApolloClient(
            networkTransport: transport,
            store: store
        )
    }

    public func fetch<Query: GraphQLQuery>(
        _ query: Query
    ) async throws -> Query.Data where Query.ResponseFormat == SingleResponseFormat {
        let response = try await apollo.fetch(
            query: query,
            cachePolicy: .networkOnly,
            requestConfiguration: RequestConfiguration(
                writeResultsToCache: false
            )
        )

        return try extractData(from: response)
    }

    public func perform<Mutation: GraphQLMutation>(
        _ mutation: Mutation
    ) async throws -> Mutation.Data where Mutation.ResponseFormat == SingleResponseFormat {
        let response = try await apollo.perform(
            mutation: mutation,
            requestConfiguration: RequestConfiguration(
                writeResultsToCache: false
            )
        )

        return try extractData(from: response)
    }

    private func extractData<Operation: GraphQLOperation>(
        from response: GraphQLResponse<Operation>
    ) throws -> Operation.Data {
        if let errors = response.errors, !errors.isEmpty {
            throw ShopifyGraphQLClientError.graphQLErrors(errors)
        }

        guard let data = response.data else {
            throw ShopifyGraphQLClientError.noData
        }

        return data
    }
}
