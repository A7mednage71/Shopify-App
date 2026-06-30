// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ApplyDiscountCodeMutation: GraphQLMutation {
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

  public var __variables: Variables? { [
    "cartId": cartId,
    "discountCodes": discountCodes
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cartDiscountCodesUpdate", CartDiscountCodesUpdate?.self, arguments: [
        "cartId": .variable("cartId"),
        "discountCodes": .variable("discountCodes")
      ]),
    ] }

    /// Updates the discount codes applied to a [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart). This mutation replaces all existing discount codes with the provided list, so pass an empty array to remove all codes. Discount codes are case-insensitive.
    ///
    /// After updating, check each [`CartDiscountCode`](https://shopify.dev/docs/api/storefront/current/objects/CartDiscountCode) in the cart's [`discountCodes`](https://shopify.dev/docs/api/storefront/current/objects/Cart#field-Cart.fields.discountCodes) field to see whether the code is applicable to the cart's current contents.
    ///
    public var cartDiscountCodesUpdate: CartDiscountCodesUpdate? { __data["cartDiscountCodesUpdate"] }

    /// CartDiscountCodesUpdate
    ///
    /// Parent Type: `CartDiscountCodesUpdatePayload`
    public struct CartDiscountCodesUpdate: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CartDiscountCodesUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The updated cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartDiscountCodesUpdate.Cart
      ///
      /// Parent Type: `Cart`
      public struct Cart: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Cart }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("discountCodes", [DiscountCode].self),
          .field("cost", Cost.self),
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
        public struct DiscountCode: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CartDiscountCode }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("code", String.self),
            .field("applicable", Bool.self),
          ] }

          /// The code for the discount.
          public var code: String { __data["code"] }
          /// Whether the discount code is applicable to the cart's current contents.
          public var applicable: Bool { __data["applicable"] }
        }

        /// CartDiscountCodesUpdate.Cart.Cost
        ///
        /// Parent Type: `CartCost`
        public struct Cost: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CartCost }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("subtotalAmount", SubtotalAmount.self),
            .field("totalAmount", TotalAmount.self),
          ] }

          /// The amount, before taxes and cart-level discounts, for the customer to pay.
          public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }
          /// The total amount for the customer to pay.
          public var totalAmount: TotalAmount { __data["totalAmount"] }

          /// CartDiscountCodesUpdate.Cart.Cost.SubtotalAmount
          ///
          /// Parent Type: `MoneyV2`
          public struct SubtotalAmount: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }

          /// CartDiscountCodesUpdate.Cart.Cost.TotalAmount
          ///
          /// Parent Type: `MoneyV2`
          public struct TotalAmount: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
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
      public struct UserError: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CartUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLEnum<ShopifyAPI.CartErrorCode>?.self),
          .field("field", [String]?.self),
          .field("message", String.self),
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
