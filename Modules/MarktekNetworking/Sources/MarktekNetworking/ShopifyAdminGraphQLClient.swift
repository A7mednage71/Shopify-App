import Apollo
import ApolloAPI
import Foundation

public final class ShopifyAdminHeaderInterceptor: ApolloInterceptor {
    public var id: String = UUID().uuidString

    public init() {}

    public func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        request.addHeader(name: "X-Shopify-Access-Token", value: Secrets.shopifyAdminAccessToken)
        request.addHeader(name: "Content-Type", value: "application/json")
        chain.proceedAsync(request: request, response: response, interceptor: self, completion: completion)
    }
}

public final class AdminInterceptorProvider: InterceptorProvider {
    private let store: ApolloStore
    private let client: URLSessionClient

    public init(store: ApolloStore, client: URLSessionClient = URLSessionClient()) {
        self.store = store
        self.client = client
    }

    public func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [any ApolloInterceptor] {
        return [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: store),
            ShopifyAdminHeaderInterceptor(),
            NetworkFetchInterceptor(client: client),
            GraphQLResponseLoggingInterceptor(clientName: "Admin"),
            ResponseCodeInterceptor(),
            MultipartResponseParsingInterceptor(),
            JSONResponseParsingInterceptor(),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: store)
        ]
    }
}

public final class ShopifyAdminGraphQLClient {
    public static let shared = ShopifyAdminGraphQLClient()

    private let apollo: ApolloClient

    public var underlyingClient: ApolloClient {
        apollo
    }

    private init() {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let provider = AdminInterceptorProvider(store: store)
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: Secrets.shopifyAdminGraphQLEndpoint
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
