// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

nonisolated public struct ApplyDiscountCodeMutation: GraphQLMutation {
  public static let operationName: String = "ApplyDiscountCode"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ApplyDiscountCode($cartId: ID!, $discountCodes: [String!]!) { cartDiscountCodesUpdate(cartId: $cartId, discountCodes: $discountCodes) { __typename cart { __typename id discountCodes { __typename code applicable } cost { __typename subtotalAmount { __typename amount currencyCode } totalAmount { __typename amount currencyCode } } } userErrors { __typename code field message } } }"#
    ))

  public var cartId: ID
  public var discountCodes: [String]

  public init(
    cartId: ID,
    discountCodes: [String]
  ) {
    self.cartId = cartId
    self.discountCodes = discountCodes
  }

  @_spi(Unsafe) public var __variables: Variables? { [
    "cartId": cartId,
    "discountCodes": discountCodes
  ] }

  nonisolated public struct Data: ShopifyAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("cartDiscountCodesUpdate", CartDiscountCodesUpdate?.self, arguments: [
        "cartId": .variable("cartId"),
        "discountCodes": .variable("discountCodes")
      ]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      ApplyDiscountCodeMutation.Data.self
    ] }

    /// Updates the discount codes applied to a [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart). This mutation replaces all existing discount codes with the provided list, so pass an empty array to remove all codes. Discount codes are case-insensitive.
    ///
    /// After updating, check each [`CartDiscountCode`](https://shopify.dev/docs/api/storefront/current/objects/CartDiscountCode) in the cart's [`discountCodes`](https://shopify.dev/docs/api/storefront/current/objects/Cart#field-Cart.fields.discountCodes) field to see whether the code is applicable to the cart's current contents.
    ///
    public var cartDiscountCodesUpdate: CartDiscountCodesUpdate? { __data["cartDiscountCodesUpdate"] }

    /// CartDiscountCodesUpdate
    ///
    /// Parent Type: `CartDiscountCodesUpdatePayload`
    nonisolated public struct CartDiscountCodesUpdate: ShopifyAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartDiscountCodesUpdatePayload }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.self
      ] }

      /// The updated cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartDiscountCodesUpdate.Cart
      ///
      /// Parent Type: `Cart`
      nonisolated public struct Cart: ShopifyAPI.SelectionSet {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Cart }
        @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("discountCodes", [DiscountCode].self),
          .field("cost", Cost.self),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.self
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The case-insensitive discount codes that the customer added at checkout.
        public var discountCodes: [DiscountCode] { __data["discountCodes"] }
        /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
        public var cost: Cost { __data["cost"] }

        /// CartDiscountCodesUpdate.Cart.DiscountCode
        ///
        /// Parent Type: `CartDiscountCode`
        nonisolated public struct DiscountCode: ShopifyAPI.SelectionSet {
          @_spi(Unsafe) public let __data: DataDict
          @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

          @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartDiscountCode }
          @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("code", String.self),
            .field("applicable", Bool.self),
          ] }
          @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.DiscountCode.self
          ] }

          /// The code for the discount.
          public var code: String { __data["code"] }
          /// Whether the discount code is applicable to the cart's current contents.
          public var applicable: Bool { __data["applicable"] }
        }

        /// CartDiscountCodesUpdate.Cart.Cost
        ///
        /// Parent Type: `CartCost`
        nonisolated public struct Cost: ShopifyAPI.SelectionSet {
          @_spi(Unsafe) public let __data: DataDict
          @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

          @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartCost }
          @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("subtotalAmount", SubtotalAmount.self),
            .field("totalAmount", TotalAmount.self),
          ] }
          @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.Cost.self
          ] }

          /// The amount, before taxes and cart-level discounts, for the customer to pay.
          public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }
          /// The total amount for the customer to pay.
          public var totalAmount: TotalAmount { __data["totalAmount"] }

          /// CartDiscountCodesUpdate.Cart.Cost.SubtotalAmount
          ///
          /// Parent Type: `MoneyV2`
          nonisolated public struct SubtotalAmount: ShopifyAPI.SelectionSet {
            @_spi(Unsafe) public let __data: DataDict
            @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

            @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
            @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
            ] }
            @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.Cost.SubtotalAmount.self
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }

          /// CartDiscountCodesUpdate.Cart.Cost.TotalAmount
          ///
          /// Parent Type: `MoneyV2`
          nonisolated public struct TotalAmount: ShopifyAPI.SelectionSet {
            @_spi(Unsafe) public let __data: DataDict
            @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

            @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
            @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
            ] }
            @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.Cost.TotalAmount.self
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }
      }

      /// CartDiscountCodesUpdate.UserError
      ///
      /// Parent Type: `CartUserError`
      nonisolated public struct UserError: ShopifyAPI.SelectionSet {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartUserError }
        @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLEnum<ShopifyAPI.CartErrorCode>?.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.UserError.self
        ] }

        /// The error code.
        public var code: GraphQLEnum<ShopifyAPI.CartErrorCode>? { __data["code"] }
        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
