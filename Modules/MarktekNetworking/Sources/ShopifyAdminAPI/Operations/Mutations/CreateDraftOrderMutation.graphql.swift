// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateDraftOrderMutation: GraphQLMutation {
  public static let operationName: String = "CreateDraftOrder"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateDraftOrder($input: DraftOrderInput!) { draftOrderCreate(input: $input) { __typename draftOrder { __typename id name status subtotalPrice totalPrice totalTax currencyCode lineItems(first: 20) { __typename edges { __typename node { __typename id title quantity originalUnitPrice discountedUnitPrice variant { __typename id title price inventoryQuantity availableForSale } } } } } userErrors { __typename field message } } }"#
    ))

  public var input: DraftOrderInput

  public init(input: DraftOrderInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("draftOrderCreate", DraftOrderCreate?.self, arguments: ["input": .variable("input")]),
    ] }

    /// Creates a [draft order](https://shopify.dev/docs/api/admin-graphql/latest/objects/DraftOrder)
    /// with attributes such as customer information, line items, shipping and billing addresses, and payment terms.
    /// Draft orders are useful for merchants that need to:
    ///
    /// - Create new orders for sales made by phone, in person, by chat, or elsewhere. When a merchant accepts payment for a draft order, an order is created.
    /// - Send invoices to customers with a secure checkout link.
    /// - Use custom items to represent additional costs or products not in inventory.
    /// - Re-create orders manually from active sales channels.
    /// - Sell products at discount or wholesale rates.
    /// - Take pre-orders.
    ///
    /// After creating a draft order, you can:
    /// - Send an invoice to the customer using the [`draftOrderInvoiceSend`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/draftOrderInvoiceSend) mutation.
    /// - Complete the draft order using the [`draftOrderComplete`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/draftOrderComplete) mutation.
    /// - Update the draft order using the [`draftOrderUpdate`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/draftOrderUpdate) mutation.
    /// - Duplicate a draft order using the [`draftOrderDuplicate`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/draftOrderDuplicate) mutation.
    /// - Delete the draft order using the [`draftOrderDelete`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/draftOrderDelete) mutation.
    ///
    /// > Note:
    /// > When you create a draft order, you can't [reserve or hold inventory](https://shopify.dev/docs/apps/build/orders-fulfillment/inventory-management-apps#inventory-states) for the items in the order by default.
    /// > However, you can reserve inventory using the [`reserveInventoryUntil`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/draftOrderCreate#arguments-input.fields.reserveInventoryUntil) input.
    public var draftOrderCreate: DraftOrderCreate? { __data["draftOrderCreate"] }

    /// DraftOrderCreate
    ///
    /// Parent Type: `DraftOrderCreatePayload`
    public struct DraftOrderCreate: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderCreatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("draftOrder", DraftOrder?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The created draft order.
      public var draftOrder: DraftOrder? { __data["draftOrder"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// DraftOrderCreate.DraftOrder
      ///
      /// Parent Type: `DraftOrder`
      public struct DraftOrder: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAdminAPI.ID.self),
          .field("name", String.self),
          .field("status", GraphQLEnum<ShopifyAdminAPI.DraftOrderStatus>.self),
          .field("subtotalPrice", ShopifyAdminAPI.Money.self),
          .field("totalPrice", ShopifyAdminAPI.Money.self),
          .field("totalTax", ShopifyAdminAPI.Money.self),
          .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
          .field("lineItems", LineItems.self, arguments: ["first": 20]),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAdminAPI.ID { __data["id"] }
        /// The identifier for the draft order, which is unique within the store. For example, _#D1223_.
        public var name: String { __data["name"] }
        /// The status of the draft order.
        public var status: GraphQLEnum<ShopifyAdminAPI.DraftOrderStatus> { __data["status"] }
        /// The subtotal, in shop currency, of the line items and their discounts, excluding shipping charges, shipping discounts, and taxes.
        @available(*, deprecated, message: "Use `subtotalPriceSet` instead.")
        public var subtotalPrice: ShopifyAdminAPI.Money { __data["subtotalPrice"] }
        /// The total price, in shop currency, includes taxes, shipping charges, and discounts.
        @available(*, deprecated, message: "Use `totalPriceSet` instead.")
        public var totalPrice: ShopifyAdminAPI.Money { __data["totalPrice"] }
        /// The total tax in shop currency.
        @available(*, deprecated, message: "Use `totalTaxSet` instead.")
        public var totalTax: ShopifyAdminAPI.Money { __data["totalTax"] }
        /// The shop currency used for calculation.
        public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
        /// The list of the line items in the draft order.
        public var lineItems: LineItems { __data["lineItems"] }

        /// DraftOrderCreate.DraftOrder.LineItems
        ///
        /// Parent Type: `DraftOrderLineItemConnection`
        public struct LineItems: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItemConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("edges", [Edge].self),
          ] }

          /// The connection between the node and its parent. Each edge contains a minimum of the edge's cursor and the node.
          public var edges: [Edge] { __data["edges"] }

          /// DraftOrderCreate.DraftOrder.LineItems.Edge
          ///
          /// Parent Type: `DraftOrderLineItemEdge`
          public struct Edge: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItemEdge }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("node", Node.self),
            ] }

            /// The item at the end of DraftOrderLineItemEdge.
            public var node: Node { __data["node"] }

            /// DraftOrderCreate.DraftOrder.LineItems.Edge.Node
            ///
            /// Parent Type: `DraftOrderLineItem`
            public struct Node: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItem }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", ShopifyAdminAPI.ID.self),
                .field("title", String.self),
                .field("quantity", Int.self),
                .field("originalUnitPrice", ShopifyAdminAPI.Money.self),
                .field("discountedUnitPrice", ShopifyAdminAPI.Money.self),
                .field("variant", Variant?.self),
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAdminAPI.ID { __data["id"] }
              /// The title of the product or variant. This field only applies to custom line items.
              public var title: String { __data["title"] }
              /// The quantity of items. For a bundle item, this is the quantity of bundles,
              /// not the quantity of items contained in the bundles themselves.
              public var quantity: Int { __data["quantity"] }
              /// The price, in shop currency, without any discounts applied.
              @available(*, deprecated, message: "Use `originalUnitPriceWithCurrency` instead.")
              public var originalUnitPrice: ShopifyAdminAPI.Money { __data["originalUnitPrice"] }
              /// The `discountedTotal` divided by `quantity`, equal to the value of the discount per unit in the shop currency.
              @available(*, deprecated, message: "Use `approximateDiscountedUnitPriceSet` instead.")
              public var discountedUnitPrice: ShopifyAdminAPI.Money { __data["discountedUnitPrice"] }
              /// The product variant for the line item.
              public var variant: Variant? { __data["variant"] }

              /// DraftOrderCreate.DraftOrder.LineItems.Edge.Node.Variant
              ///
              /// Parent Type: `ProductVariant`
              public struct Variant: ShopifyAdminAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.ProductVariant }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("id", ShopifyAdminAPI.ID.self),
                  .field("title", String.self),
                  .field("price", ShopifyAdminAPI.Money.self),
                  .field("inventoryQuantity", Int?.self),
                  .field("availableForSale", Bool.self),
                ] }

                /// A globally-unique ID.
                public var id: ShopifyAdminAPI.ID { __data["id"] }
                /// The title of the product variant.
                public var title: String { __data["title"] }
                /// The price of the product variant in the default shop currency.
                public var price: ShopifyAdminAPI.Money { __data["price"] }
                /// The total sellable quantity of the variant.
                public var inventoryQuantity: Int? { __data["inventoryQuantity"] }
                /// Whether the product variant is available for sale.
                public var availableForSale: Bool { __data["availableForSale"] }
              }
            }
          }
        }
      }

      /// DraftOrderCreate.UserError
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
