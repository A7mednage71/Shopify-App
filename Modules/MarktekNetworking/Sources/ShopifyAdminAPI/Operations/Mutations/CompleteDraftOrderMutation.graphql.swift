// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CompleteDraftOrderMutation: GraphQLMutation {
  public static let operationName: String = "CompleteDraftOrder"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CompleteDraftOrder($id: ID!, $paymentPending: Boolean) { draftOrderComplete(id: $id, paymentPending: $paymentPending) { __typename draftOrder { __typename id status order { __typename id name createdAt totalPriceSet { __typename shopMoney { __typename amount currencyCode } } email } } userErrors { __typename field message } } }"#
    ))

  public var id: ID
  public var paymentPending: GraphQLNullable<Bool>

  public init(
    id: ID,
    paymentPending: GraphQLNullable<Bool>
  ) {
    self.id = id
    self.paymentPending = paymentPending
  }

  public var __variables: Variables? { [
    "id": id,
    "paymentPending": paymentPending
  ] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("draftOrderComplete", DraftOrderComplete?.self, arguments: [
        "id": .variable("id"),
        "paymentPending": .variable("paymentPending")
      ]),
    ] }

    /// Completes a [draft order](https://shopify.dev/docs/api/admin-graphql/latest/objects/DraftOrder) and
    /// converts it into a [regular order](https://shopify.dev/docs/api/admin-graphql/latest/objects/Order).
    /// The order appears in the merchant's orders list, and the customer can be notified about their order.
    ///
    /// Use the `draftOrderComplete` mutation when a merchant is ready to finalize a draft order and create a real
    /// order in their store. The `draftOrderComplete` mutation also supports sales channel attribution for tracking
    /// order sources using the [`sourceName`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/draftOrderComplete#arguments-sourceName)
    /// argument, [cart validation](https://shopify.dev/docs/apps/build/checkout/cart-checkout-validation)
    /// controls for app integrations, and detailed error reporting for failed completions.
    ///
    /// You can complete a draft order with different [payment scenarios](https://help.shopify.com/manual/fulfillment/managing-orders/payments):
    ///
    /// - Mark the order as paid immediately.
    /// - Set the order as payment pending using [payment terms](https://shopify.dev/docs/api/admin-graphql/latest/objects/PaymentTerms).
    /// - Specify a custom payment amount.
    /// - Select a specific payment gateway.
    ///
    /// > Note:
    /// > When completing a draft order, inventory is [reserved](https://shopify.dev/docs/apps/build/orders-fulfillment/inventory-management-apps#inventory-states)
    /// for the items in the order. This means the items will no longer be available for other customers to purchase.
    /// Make sure to verify inventory availability before completing the draft order.
    public var draftOrderComplete: DraftOrderComplete? { __data["draftOrderComplete"] }

    /// DraftOrderComplete
    ///
    /// Parent Type: `DraftOrderCompletePayload`
    public struct DraftOrderComplete: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderCompletePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("draftOrder", DraftOrder?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The completed draft order.
      public var draftOrder: DraftOrder? { __data["draftOrder"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// DraftOrderComplete.DraftOrder
      ///
      /// Parent Type: `DraftOrder`
      public struct DraftOrder: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAdminAPI.ID.self),
          .field("status", GraphQLEnum<ShopifyAdminAPI.DraftOrderStatus>.self),
          .field("order", Order?.self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAdminAPI.ID { __data["id"] }
        /// The status of the draft order.
        public var status: GraphQLEnum<ShopifyAdminAPI.DraftOrderStatus> { __data["status"] }
        /// The order that was created from the draft order.
        public var order: Order? { __data["order"] }

        /// DraftOrderComplete.DraftOrder.Order
        ///
        /// Parent Type: `Order`
        public struct Order: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Order }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAdminAPI.ID.self),
            .field("name", String.self),
            .field("createdAt", ShopifyAdminAPI.DateTime.self),
            .field("totalPriceSet", TotalPriceSet.self),
            .field("email", String?.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAdminAPI.ID { __data["id"] }
          /// The unique identifier for the order that appears on the order page in the Shopify admin and the **Order status** page.
          /// For example, "#1001", "EN1001", or "1001-A".
          /// This value isn't unique across multiple stores. Use this field to identify orders in the Shopify admin and for order tracking.
          public var name: String { __data["name"] }
          /// The date and time in [ISO 8601 format](https://en.wikipedia.org/wiki/ISO_8601) when an order was created. This timestamp is set when the customer completes checkout and remains unchanged throughout an order's lifecycle.
          public var createdAt: ShopifyAdminAPI.DateTime { __data["createdAt"] }
          /// The total price of the order, before returns, in shop and presentment currencies.
          /// This includes taxes and discounts.
          public var totalPriceSet: TotalPriceSet { __data["totalPriceSet"] }
          /// The email address associated with the customer for this order.
          /// Used for sending order confirmations, shipping notifications, and other order-related communications.
          /// Returns `null` if no email address was provided during checkout.
          public var email: String? { __data["email"] }

          /// DraftOrderComplete.DraftOrder.Order.TotalPriceSet
          ///
          /// Parent Type: `MoneyBag`
          public struct TotalPriceSet: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("shopMoney", ShopMoney.self),
            ] }

            /// Amount in shop currency.
            public var shopMoney: ShopMoney { __data["shopMoney"] }

            /// DraftOrderComplete.DraftOrder.Order.TotalPriceSet.ShopMoney
            ///
            /// Parent Type: `MoneyV2`
            public struct ShopMoney: ShopifyAdminAPI.SelectionSet {
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
      }

      /// DraftOrderComplete.UserError
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
