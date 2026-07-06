// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ApplyDiscountMutation: GraphQLMutation {
  public static let operationName: String = "ApplyDiscount"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ApplyDiscount($id: ID!, $input: DraftOrderInput!) { draftOrderUpdate(id: $id, input: $input) { __typename draftOrder { __typename id subtotalPrice totalPrice appliedDiscount { __typename title value valueType amountV2 { __typename amount currencyCode } } } userErrors { __typename field message } } }"#
    ))

  public var id: ID
  public var input: DraftOrderInput

  public init(
    id: ID,
    input: DraftOrderInput
  ) {
    self.id = id
    self.input = input
  }

  public var __variables: Variables? { [
    "id": id,
    "input": input
  ] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("draftOrderUpdate", DraftOrderUpdate?.self, arguments: [
        "id": .variable("id"),
        "input": .variable("input")
      ]),
    ] }

    /// Updates a draft order.
    ///
    /// If a checkout has been started for a draft order, any update to the draft will unlink the checkout. Checkouts
    /// are created but not immediately completed when opening the merchant credit card modal in the admin, and when a
    /// buyer opens the invoice URL. This is usually fine, but there is an edge case where a checkout is in progress
    /// and the draft is updated before the checkout completes. This will not interfere with the checkout and order
    /// creation, but if the link from draft to checkout is broken the draft will remain open even after the order is
    /// created.
    public var draftOrderUpdate: DraftOrderUpdate? { __data["draftOrderUpdate"] }

    /// DraftOrderUpdate
    ///
    /// Parent Type: `DraftOrderUpdatePayload`
    public struct DraftOrderUpdate: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("draftOrder", DraftOrder?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The updated draft order.
      public var draftOrder: DraftOrder? { __data["draftOrder"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// DraftOrderUpdate.DraftOrder
      ///
      /// Parent Type: `DraftOrder`
      public struct DraftOrder: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAdminAPI.ID.self),
          .field("subtotalPrice", ShopifyAdminAPI.Money.self),
          .field("totalPrice", ShopifyAdminAPI.Money.self),
          .field("appliedDiscount", AppliedDiscount?.self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAdminAPI.ID { __data["id"] }
        /// The subtotal, in shop currency, of the line items and their discounts, excluding shipping charges, shipping discounts, and taxes.
        @available(*, deprecated, message: "Use `subtotalPriceSet` instead.")
        public var subtotalPrice: ShopifyAdminAPI.Money { __data["subtotalPrice"] }
        /// The total price, in shop currency, includes taxes, shipping charges, and discounts.
        @available(*, deprecated, message: "Use `totalPriceSet` instead.")
        public var totalPrice: ShopifyAdminAPI.Money { __data["totalPrice"] }
        /// The custom order-level discount applied.
        public var appliedDiscount: AppliedDiscount? { __data["appliedDiscount"] }

        /// DraftOrderUpdate.DraftOrder.AppliedDiscount
        ///
        /// Parent Type: `DraftOrderAppliedDiscount`
        public struct AppliedDiscount: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderAppliedDiscount }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("title", String?.self),
            .field("value", Double.self),
            .field("valueType", GraphQLEnum<ShopifyAdminAPI.DraftOrderAppliedDiscountType>.self),
            .field("amountV2", AmountV2.self),
          ] }

          /// Name of the order-level discount.
          public var title: String? { __data["title"] }
          /// The order level discount amount. If `valueType` is `"percentage"`,
          /// then `value` is the percentage discount.
          public var value: Double { __data["value"] }
          /// Type of the order-level discount.
          public var valueType: GraphQLEnum<ShopifyAdminAPI.DraftOrderAppliedDiscountType> { __data["valueType"] }
          /// Amount of money discounted.
          @available(*, deprecated, message: "Use `amountSet` instead.")
          public var amountV2: AmountV2 { __data["amountV2"] }

          /// DraftOrderUpdate.DraftOrder.AppliedDiscount.AmountV2
          ///
          /// Parent Type: `MoneyV2`
          public struct AmountV2: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAdminAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
            ] }

            /// A monetary value in decimal format, allowing for precise representation of cents or fractional
            /// currency. For example, 12.99.
            public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
            /// The three-letter currency code that represents a world currency used in a store. Currency codes
            /// include standard [standard ISO 4217 codes](https://en.wikipedia.org/wiki/ISO_4217), legacy codes,
            /// and non-standard codes. For example, USD.
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }
      }

      /// DraftOrderUpdate.UserError
      ///
      /// Parent Type: `UserError`
      public struct UserError: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.UserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }

        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
