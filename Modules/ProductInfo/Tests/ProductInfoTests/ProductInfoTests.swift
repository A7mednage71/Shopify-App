import XCTest
@testable import ProductInfo

final class ProductInfoTests: XCTestCase {
    func testProductTypeNormalizesKnownValues() {
        XCTAssertEqual(ProductType(rawValue: ""), .empty)
        XCTAssertEqual(ProductType(rawValue: "accessories"), .accessories)
        XCTAssertEqual(ProductType(rawValue: "giftcard"), .giftCard)
        XCTAssertEqual(ProductType(rawValue: "SHOES"), .shoes)
        XCTAssertEqual(ProductType(rawValue: "snowboard"), .snowboard)
        XCTAssertEqual(ProductType(rawValue: "T-SHIRTS"), .tshirts)
        XCTAssertEqual(ProductType(rawValue: "custom"), .unknown("custom"))
    }

    func testProductTypeQueryValuesPreserveStorefrontValues() {
        XCTAssertEqual(ProductType.accessories.queryValue, "product_type:'accessories'")
        XCTAssertEqual(ProductType.shoes.queryValue, "product_type:'SHOES'")
        XCTAssertEqual(ProductType.snowboard.queryValue, "product_type:'snowboard'")
        XCTAssertEqual(ProductType.tshirts.queryValue, "product_type:'T-SHIRTS'")
        XCTAssertNil(ProductType.giftCard.queryValue)
        XCTAssertNil(ProductType.empty.queryValue)
        XCTAssertNil(ProductType.unknown("custom").queryValue)
    }

    @MainActor
    func testComparisonViewModelFiltersCandidatesByTitle() async {
        let current = makeProduct(id: "current", title: "Current Snowboard", productType: "snowboard")
        let matching = makeProduct(id: "matching", title: "Alpine Snowboard", productType: "snowboard")
        let other = makeProduct(id: "other", title: "Trail Board", productType: "snowboard")
        let viewModel = ProductComparisonViewModel(
            getComparableProductsUseCase: FakeComparableProductsUseCase(products: [matching, other]),
            getRecommendationUseCase: FakeRecommendationUseCase()
        )

        await viewModel.loadCandidates(for: current)
        viewModel.searchText = "alpine"

        XCTAssertEqual(viewModel.filteredCandidates.map(\.id), ["matching"])
    }

    @MainActor
    func testComparableProductsUseCaseExcludesCurrentProduct() async throws {
        let current = makeProduct(id: "current", title: "Current Snowboard", productType: "snowboard")
        let repository = FakeProductInfoRepository(products: [
            current,
            makeProduct(id: "other", title: "Other Snowboard", productType: "snowboard")
        ])
        let useCase = GetComparableProductsUseCase(repository: repository)

        let products = try await useCase.execute(currentProduct: current, first: 20)

        XCTAssertEqual(products.map(\.id), ["other"])
    }

    func testGeminiComparisonRequestIncludesComparableSignals() throws {
        let current = makeProduct(id: "current", title: "Current Shoe", productType: "SHOES", averageRating: 4.2)
        let selected = makeProduct(id: "selected", title: "Selected Shoe", productType: "SHOES", averageRating: 4.8)
        let body = try ProductComparisonGeminiRequestBuilder().buildRequestBody(
            currentProduct: current,
            selectedProduct: selected,
            preference: "I want the best value."
        )
        let prompt = try XCTUnwrap(body.system_instruction.parts.first?.text)

        XCTAssertTrue(prompt.contains("current"))
        XCTAssertTrue(prompt.contains("selected"))
        XCTAssertTrue(prompt.contains("best value"))
        XCTAssertTrue(prompt.contains("averageRating"))
        XCTAssertTrue(prompt.contains("reviewCount"))
        XCTAssertTrue(prompt.contains("availableQuantity"))
        XCTAssertTrue(prompt.contains("material"))
    }

    func testGeminiComparisonParserDecodesStructuredRecommendation() throws {
        let response = makeGeminiResponse(
            """
            {"recommended_product_id":"selected","confidence":"high","headline":"Pick selected","explanation":"It has stronger reviews.","key_reasons":["Better rating"],"price_note":"Close price range."}
            """
        )

        let recommendation = try ProductComparisonGeminiResponseParser().parse(
            response: response,
            validProductIDs: ["current", "selected"]
        )

        XCTAssertEqual(recommendation.recommendedProductID, "selected")
        XCTAssertEqual(recommendation.confidence, .high)
        XCTAssertEqual(recommendation.keyReasons, ["Better rating"])
    }

    func testGeminiComparisonParserRejectsUnknownRecommendedProduct() {
        let response = makeGeminiResponse(
            """
            {"recommended_product_id":"unknown","confidence":"medium","headline":"Pick unknown","explanation":"Nope.","key_reasons":[],"price_note":""}
            """
        )

        XCTAssertThrowsError(
            try ProductComparisonGeminiResponseParser().parse(
                response: response,
                validProductIDs: ["current", "selected"]
            )
        ) { error in
            XCTAssertEqual(error as? ProductComparisonGeminiResponseParserError, .invalidRecommendedProductID)
        }
    }
}

private struct FakeComparableProductsUseCase: GetComparableProductsUseCaseProtocol {
    let products: [ProductDetails]

    func execute(currentProduct: ProductDetails, first: Int) async throws -> [ProductDetails] {
        products
    }
}

private struct FakeRecommendationUseCase: GetProductComparisonRecommendationUseCaseProtocol {
    func execute(
        currentProduct: ProductDetails,
        selectedProduct: ProductDetails,
        preference: String?
    ) async throws -> ProductComparisonRecommendation {
        ProductComparisonRecommendation(
            recommendedProductID: selectedProduct.id,
            confidence: .medium,
            headline: "Pick selected",
            explanation: "It is a better fit.",
            keyReasons: [],
            priceNote: ""
        )
    }
}

private struct FakeProductInfoRepository: ProductInfoRepository {
    let products: [ProductDetails]

    func fetchProduct(id: String) async throws -> ProductDetails {
        products.first { $0.id == id }!
    }

    func fetchProducts(productType: ProductType, first: Int, after: String?) async throws -> [ProductDetails] {
        products
    }
}

private func makeGeminiResponse(_ text: String) -> GeminiComparisonDirectResponse {
    GeminiComparisonDirectResponse(
        candidates: [
            .init(
                content: .init(
                    parts: [.init(text: text)]
                )
            )
        ]
    )
}

private func makeProduct(
    id: String,
    title: String,
    productType: String,
    averageRating: Double = 4.5
) -> ProductDetails {
    ProductDetails(
        id: id,
        title: title,
        description: "A breathable cotton product.",
        descriptionHTML: "<p>A breathable cotton product.</p>",
        vendor: "Marktek",
        productType: productType,
        tags: ["cotton"],
        availableForSale: true,
        priceRange: ProductPriceRange(
            minVariantPrice: ProductMoney(amount: "100.00", currencyCode: "USD"),
            maxVariantPrice: ProductMoney(amount: "120.00", currencyCode: "USD")
        ),
        compareAtPrice: ProductMoney(amount: "0.00", currencyCode: "USD"),
        images: [],
        options: [
            ProductOption(id: "material", name: "Material", values: ["Cotton"])
        ],
        variants: [
            ProductVariant(
                id: "\(id)-variant",
                title: "Default",
                availableForSale: true,
                quantityAvailable: 5,
                price: ProductMoney(amount: "100.00", currencyCode: "USD"),
                compareAtPrice: nil,
                selectedOptions: [],
                image: nil
            )
        ],
        reviews: [
            ProductReview(
                id: "\(id)-review",
                customerName: "Customer",
                rating: Int(averageRating.rounded()),
                title: "Good",
                body: "Comfortable and well made.",
                createdAt: "2026-07-06"
            )
        ],
        reviewSummary: ProductReviewSummary(
            averageRating: averageRating,
            reviewCount: 1,
            starCounts: [5: 1, 4: 0, 3: 0, 2: 0, 1: 0]
        )
    )
}
