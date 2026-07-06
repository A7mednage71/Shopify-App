import Foundation

public struct GeminiShoppingAssistantRemoteDataSource: ShoppingAssistantRemoteDataSource {
    
    private let client: any GeminiClientProtocol
    private let requestBuilder: GeminiShoppingAssistantRequestBuilder
    private let responseParser: GeminiShoppingAssistantResponseParser
    
    public init() {
        self.client = GeminiClient()
        self.requestBuilder = GeminiShoppingAssistantRequestBuilder()
        self.responseParser = GeminiShoppingAssistantResponseParser()
    }
    
    internal init(
        client: any GeminiClientProtocol,
        requestBuilder: GeminiShoppingAssistantRequestBuilder = GeminiShoppingAssistantRequestBuilder(),
        responseParser: GeminiShoppingAssistantResponseParser = GeminiShoppingAssistantResponseParser()
    ) {
        self.client = client
        self.requestBuilder = requestBuilder
        self.responseParser = responseParser
    }
    
    public func getReply(messages: [ChatMessage], catalog: [ShopProduct]) async throws -> AssistantReply {
        let body = try requestBuilder.buildRequestBody(messages: messages, catalog: catalog)
        let response = try await client.generateContent(body: body)
        return try responseParser.parse(response: response)
    }
}
