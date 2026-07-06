import Common

struct ProductComparisonRecommendationRepositoryImpl: ProductComparisonRecommendationRepository, Sendable {
    private let client: any GeminiClientProtocol
    private let requestBuilder: ProductComparisonGeminiRequestBuilder
    private let responseParser: ProductComparisonGeminiResponseParser

    init(
        client: any GeminiClientProtocol = GeminiClient(),
        requestBuilder: ProductComparisonGeminiRequestBuilder = ProductComparisonGeminiRequestBuilder(),
        responseParser: ProductComparisonGeminiResponseParser = ProductComparisonGeminiResponseParser()
    ) {
        self.client = client
        self.requestBuilder = requestBuilder
        self.responseParser = responseParser
    }

    func recommend(
        currentProduct: ProductDetails,
        selectedProduct: ProductDetails,
        preference: String?
    ) async throws -> ProductComparisonRecommendation {
        let body = try requestBuilder.buildRequestBody(
            currentProduct: currentProduct,
            selectedProduct: selectedProduct,
            preference: preference
        )
        let response = try await client.generateContent(
            body: body,
            responseType: GeminiComparisonDirectResponse.self
        )

        return try responseParser.parse(
            response: response,
            validProductIDs: [currentProduct.id, selectedProduct.id]
        )
    }
}
