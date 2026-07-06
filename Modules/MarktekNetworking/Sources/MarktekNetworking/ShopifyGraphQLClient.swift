import Apollo
import ApolloAPI
import Foundation

public final class GraphQLResponseLoggingInterceptor: ApolloInterceptor {
    public var id: String = UUID().uuidString

    private let clientName: String

    public init(clientName: String) {
        self.clientName = clientName
    }

    public func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        #if DEBUG
        if let response {
            print(
                [
                    "[GraphQL][\(clientName)] \(Operation.operationName)",
                    "Status: \(response.httpResponse.statusCode)",
                    prettyPrintedBody(from: response.rawData)
                ].joined(separator: "\n")
            )
        } else {
            print("[GraphQL][\(clientName)] \(Operation.operationName)\nNo HTTP response yet.")
        }
        #endif

        chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
        )
    }

    private func prettyPrintedBody(from data: Data) -> String {
        guard !data.isEmpty else {
            return "Body: <empty>"
        }

        if let jsonObject = try? JSONSerialization.jsonObject(with: data),
           let sanitizedObject = sanitizedGraphQLLogObject(jsonObject),
           let prettyData = try? JSONSerialization.data(
            withJSONObject: sanitizedObject,
            options: [.prettyPrinted, .sortedKeys]
           ),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            return "Body:\n\(prettyString)"
        }

        if let body = String(data: data, encoding: .utf8) {
            return "Body:\n\(body)"
        }

        return "Body: <\(data.count) bytes>"
    }

    private func sanitizedGraphQLLogObject(_ object: Any) -> Any? {
        if let dictionary = object as? [String: Any] {
            return dictionary.reduce(into: [String: Any]()) { result, pair in
                guard pair.key != "__typename" else { return }
                result[pair.key] = sanitizedGraphQLLogObject(pair.value) ?? pair.value
            }
        }

        if let array = object as? [Any] {
            return array.map { sanitizedGraphQLLogObject($0) ?? $0 }
        }

        return object
    }
}

public final class StorefrontInterceptorProvider: InterceptorProvider {
    private let store: ApolloStore
    private let client: URLSessionClient

    public init(store: ApolloStore, client: URLSessionClient = URLSessionClient()) {
        self.store = store
        self.client = client
    }

    public func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [any ApolloInterceptor] {
        [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: store),
            NetworkFetchInterceptor(client: client),
            GraphQLResponseLoggingInterceptor(clientName: "Storefront"),
            ResponseCodeInterceptor(),
            MultipartResponseParsingInterceptor(),
            JSONResponseParsingInterceptor(),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: store)
        ]
    }
}
 
public final class ShopifyGraphQLClient {
    public static let shared = ShopifyGraphQLClient()
 
    private let apollo: ApolloClient

    public var underlyingClient: ApolloClient {
        apollo
    }
 
    private init() {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
 
        let provider = StorefrontInterceptorProvider(store: store)
 
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
