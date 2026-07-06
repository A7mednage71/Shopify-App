import Foundation

struct ProductComparisonGeminiRequestBuilder {
    init() {}

    func buildRequestBody(
        currentProduct: ProductDetails,
        selectedProduct: ProductDetails,
        preference: String?
    ) throws -> GeminiComparisonDirectRequestBody {
        let normalizedPreference = preference?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let payload = ProductComparisonPromptPayload(
            currentProduct: ProductComparisonPromptProduct(product: currentProduct),
            selectedProduct: ProductComparisonPromptProduct(product: selectedProduct),
            buyerPreference: normalizedPreference.isEmpty ? nil : normalizedPreference
        )
        let payloadData = try JSONEncoder().encode(payload)
        let payloadJSON = String(data: payloadData, encoding: .utf8) ?? "{}"

        let systemInstruction = """
        You are Marktek's product comparison assistant. Compare exactly two Shopify products for a buyer.

        Product data:
        \(payloadJSON)

        Rules:
        - Return strict JSON only.
        - Choose exactly one recommended_product_id from the two provided product ids.
        - Compare price, ratings, review count, review content, stock, available quantity, vendor, product options, material or fabric signals, tags, and description.
        - If prices are close, recommend the better overall value.
        - If prices differ significantly, explain whether the premium is justified or whether the cheaper product is better value.
        - If buyerPreference is present, weigh it strongly when making the recommendation, while still considering the product facts.
        - Examples: "premium pick", "best value", "more durable", "better for daily use", or "worth the price".
        - Keep the response compact for a mobile bottom sheet.
        - headline: maximum 55 characters.
        - explanation: maximum 160 characters, 1-2 sentences.
        - key_reasons: exactly 3 items, each maximum 65 characters.
        - price_note: maximum 90 characters.
        - Do not repeat the same point in explanation, key_reasons, and price_note.
        """

        return GeminiComparisonDirectRequestBody(
            system_instruction: .init(
                parts: [.init(text: systemInstruction)]
            ),
            contents: [
                .init(
                    role: "user",
                    parts: [.init(text: "Compare these two products and recommend the better purchase.")]
                )
            ],
            generationConfig: .init(
                responseMimeType: "application/json",
                responseSchema: .init(
                    type: "OBJECT",
                    properties: [
                        "recommended_product_id": .init(type: "STRING"),
                        "confidence": .init(type: "STRING", enumValues: ["low", "medium", "high"]),
                        "headline": .init(type: "STRING"),
                        "explanation": .init(type: "STRING"),
                        "key_reasons": .init(
                            type: "ARRAY",
                            items: GeminiComparisonDirectRequestBody.SchemaArrayItem(type: "STRING")
                        ),
                        "price_note": .init(type: "STRING")
                    ],
                    required: [
                        "recommended_product_id",
                        "confidence",
                        "headline",
                        "explanation",
                        "key_reasons",
                        "price_note"
                    ]
                )
            )
        )
    }
}

struct ProductComparisonPromptPayload: Encodable, Sendable {
    let currentProduct: ProductComparisonPromptProduct
    let selectedProduct: ProductComparisonPromptProduct
    let buyerPreference: String?
}

struct ProductComparisonPromptProduct: Encodable, Sendable {
    struct PromptReview: Encodable, Sendable {
        let rating: Int
        let title: String
        let body: String
    }

    let id: String
    let title: String
    let vendor: String
    let productType: String
    let description: String
    let tags: [String]
    let priceMin: Double
    let priceMax: Double
    let currencyCode: String
    let averageRating: Double
    let reviewCount: Int
    let reviews: [PromptReview]
    let availableForSale: Bool
    let availableQuantity: Int?
    let options: [String: [String]]
    let material: String

    init(product: ProductDetails) {
        self.id = product.id
        self.title = product.title
        self.vendor = product.vendor
        self.productType = product.productType
        self.description = product.description
        self.tags = product.tags
        self.priceMin = Double(product.priceRange.minVariantPrice.amount) ?? 0
        self.priceMax = Double(product.priceRange.maxVariantPrice.amount) ?? priceMin
        self.currencyCode = product.priceRange.minVariantPrice.currencyCode
        self.averageRating = product.reviewSummary.averageRating
        self.reviewCount = product.reviewSummary.reviewCount
        self.reviews = product.reviews.prefix(5).map {
            PromptReview(rating: $0.rating, title: $0.title, body: $0.body)
        }
        self.availableForSale = product.availableForSale
        self.availableQuantity = product.totalAvailableQuantity
        self.options = product.options.reduce(into: [String: [String]]()) { result, option in
            result[option.name] = option.values
        }
        self.material = product.inferredMaterial
    }
}
