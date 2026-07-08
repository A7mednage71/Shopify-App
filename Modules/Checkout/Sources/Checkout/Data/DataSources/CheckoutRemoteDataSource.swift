import Foundation
import Common
import MarktekNetworking
import ApolloAPI

public enum CheckoutError: LocalizedError {
    case userError([String])
    case malformedDiscountCode(String)
    case malformedReviewsMetafield
    case unknown

    public var errorDescription: String? {
        switch self {
        case .userError(let messages):
            return messages.joined(separator: ", ")
        case .malformedDiscountCode:
            return L10n.Checkout.errorMalformedDiscountCode
        case .malformedReviewsMetafield:
            return L10n.Checkout.errorMalformedReviewsMetafield
        case .unknown:
            return L10n.Checkout.errorUnknown
        }
    }
}

public protocol CheckoutRemoteDataSource: Sendable {
    func createOrder(input: OrderCreateInput) async throws -> OrderDataModel
    func getCustomerDetails() async throws -> CustomerDetailsDataModel
    func validateDiscountCode(code: String) async throws -> ValidatedDiscountCode?
    func submitProductReview(_ review: ProductReviewSubmission) async throws
}

public struct ShopifyCheckoutRemoteDataSource: CheckoutRemoteDataSource, Sendable {
    private let customerAccessTokenDataSource: CustomerAccessTokenDataSource
    
    public init(customerAccessTokenDataSource: CustomerAccessTokenDataSource) {
        self.customerAccessTokenDataSource = customerAccessTokenDataSource
    }

    public func getCustomerDetails() async throws -> CustomerDetailsDataModel {
        let customerAccessToken = try await customerAccessTokenDataSource.customerAccessToken()
        let query = GetCustomerDetailsQuery(customerAccessToken: customerAccessToken)
        let data = try await ShopifyGraphQLClient.shared.fetch(query)
        
        guard let gqlCustomer = data.customer else {
            throw CheckoutError.unknown
        }
        
        return CustomerDetailsDataModel(gqlCustomer: gqlCustomer)
    }

    public func createOrder(input: OrderCreateInput) async throws -> OrderDataModel {
        let orderInput = input.toGraphQLInput()
        let mutation = CreateOrderMutation(
            order: orderInput,
            options: input.toGraphQLOptionsInput()
        )
        let data = try await ShopifyAdminGraphQLClient.shared.perform(mutation)

        if let userErrors = data.orderCreate?.userErrors, !userErrors.isEmpty {
            let errorMessages = userErrors.map { $0.message }
            debugPrintOrderCreateDiscountErrors(
                input: input,
                errorMessages: errorMessages
            )
            throw CheckoutError.userError(errorMessages)
        }

        guard let gqlOrder = data.orderCreate?.order else {
            throw CheckoutError.unknown
        }

        return OrderDataModel(gqlOrder: gqlOrder)
    }

    public func validateDiscountCode(code: String) async throws -> ValidatedDiscountCode? {
        let normalizedCode = code.trimmingCharacters(in: .whitespacesAndNewlines)
        let exactResult = try await validateDiscountCodeNode(code: normalizedCode)

        if case .found(let discount) = exactResult {
            return discount
        }

        let uppercasedCode = normalizedCode.uppercased()
        guard uppercasedCode != normalizedCode else {
            return nil
        }

        let uppercasedResult = try await validateDiscountCodeNode(code: uppercasedCode)
        if case .found(let discount) = uppercasedResult {
            debugPrintDiscountCodeCaseFallback(
                requestedCode: code,
                matchedCode: discount.code
            )

            return discount
        }

        return nil
    }

    public func submitProductReview(_ review: ProductReviewSubmission) async throws {
        var reviewIds = try await fetchExistingReviewIds(productId: review.productId)
        let newReviewId = try await createProductReview(review)

        if !reviewIds.contains(newReviewId) {
            reviewIds.append(newReviewId)
        }

        try await setProductReviewIds(
            productId: review.productId,
            reviewIds: reviewIds
        )
    }

    private func fetchExistingReviewIds(productId: String) async throws -> [String] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetProductReviewMetafieldQuery(productId: productId)
        )

        guard let value = data.product?.metafield?.value,
              !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }

        guard let jsonData = value.data(using: .utf8),
              let ids = try? JSONDecoder().decode([String].self, from: jsonData) else {
            throw CheckoutError.malformedReviewsMetafield
        }

        return ids
    }

    private func createProductReview(_ review: ProductReviewSubmission) async throws -> String {
        let mutation = CreateProductReviewMutation(
            metaobject: ShopifyAdminAPI.MetaobjectCreateInput(
                type: "marketak_product_review",
                fields: .some([
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "product", value: review.productId),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "customer_name", value: review.customerName),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "rating", value: "\(review.rating)"),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "title", value: review.title),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "body", value: review.body),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "created_at", value: currentISO8601DateString()),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "approved", value: "true")
                ]),
                capabilities: .some(
                    ShopifyAdminAPI.MetaobjectCapabilityDataInput(
                        publishable: .some(
                            ShopifyAdminAPI.MetaobjectCapabilityDataPublishableInput(
                                status: GraphQLEnum<ShopifyAdminAPI.MetaobjectStatus>(.active)
                            )
                        )
                    )
                )
            )
        )

        let data = try await ShopifyAdminGraphQLClient.shared.perform(mutation)

        if let userErrors = data.metaobjectCreate?.userErrors, !userErrors.isEmpty {
            throw CheckoutError.userError(userErrors.map { $0.message })
        }

        guard let metaobjectId = data.metaobjectCreate?.metaobject?.id else {
            throw CheckoutError.unknown
        }

        return metaobjectId
    }

    private func setProductReviewIds(productId: String, reviewIds: [String]) async throws {
        let jsonData = try JSONEncoder().encode(reviewIds)
        guard let reviewIdsJson = String(data: jsonData, encoding: .utf8) else {
            throw CheckoutError.unknown
        }

        let data = try await ShopifyAdminGraphQLClient.shared.perform(
            SetProductReviewsMutation(
                productId: productId,
                reviewIdsJson: reviewIdsJson
            )
        )

        if let userErrors = data.metafieldsSet?.userErrors, !userErrors.isEmpty {
            throw CheckoutError.userError(userErrors.map { $0.message })
        }
    }

    private func validateDiscountCodeNode(code: String) async throws -> DiscountCodeLookupResult {
        let data = try await ShopifyAdminGraphQLClient.shared.fetch(
            ValidateDiscountCodeQuery(code: code)
        )

        guard let node = data.codeDiscountNodeByCode else {
            return .notFound
        }

        guard let discount = node.toDomain(code: code) else {
            debugPrintMalformedDiscountCode(
                code: code,
                node: node
            )
            throw CheckoutError.malformedDiscountCode(code)
        }

        return .found(discount)
    }

    private func currentISO8601DateString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: Date())
    }

    private func debugPrintOrderCreateDiscountErrors(
        input: OrderCreateInput,
        errorMessages: [String]
    ) {
        #if DEBUG
        guard input.discountCode != nil else { return }

        print(
            [
                "[CheckoutDiscount] Shopify orderCreate rejected discount input.",
                "Discount input: \(input.discountCode.debugDescription)",
                "Transaction total: \(input.totalAmount) \(input.currency)",
                "Payment gateway: \(input.transactionGateway)",
                "Errors: \(errorMessages.joined(separator: " | "))"
            ].joined(separator: "\n")
        )
        #endif
    }

    private func debugPrintDiscountCodeCaseFallback(
        requestedCode: String,
        matchedCode: String
    ) {
        #if DEBUG
        print(
            [
                "[CheckoutDiscount] Admin lookup matched discount code after normalization.",
                "Requested code: \(requestedCode)",
                "Matched code: \(matchedCode)"
            ].joined(separator: "\n")
        )
        #endif
    }

    private func debugPrintMalformedDiscountCode(
        code: String,
        node: ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode
    ) {
        #if DEBUG
        print(
            [
                "[CheckoutDiscount] Admin returned a discount node, but checkout could not map it.",
                "Requested code: \(code)",
                "Supported checkout discount types: DiscountCodeBasic fixed/percentage all-items, DiscountCodeFreeShipping."
            ].joined(separator: "\n")
        )
        #endif
    }
}

private enum DiscountCodeLookupResult {
    case found(ValidatedDiscountCode)
    case notFound
}

private extension Optional where Wrapped == OrderDiscountCodeInput {
    var debugDescription: String {
        switch self {
        case .itemFixed(let code, let amount, let currencyCode):
            return "itemFixed code: \(code), amount: \(amount) \(currencyCode)"
        case .itemPercentage(let code, let percentage):
            return "itemPercentage code: \(code), percentage: \(percentage)"
        case .freeShipping(let code):
            return "freeShipping code: \(code)"
        case nil:
            return "nil"
        }
    }
}
