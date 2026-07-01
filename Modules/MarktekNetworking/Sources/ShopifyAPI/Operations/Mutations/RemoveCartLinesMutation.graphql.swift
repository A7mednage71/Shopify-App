// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RemoveCartLinesMutation: GraphQLMutation {
  public static let operationName: String = "RemoveCartLines"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RemoveCartLines($cartId: ID!, $lineIds: [ID!]!) { cartLinesRemove(cartId: $cartId, lineIds: $lineIds) { __typename cart { __typename id totalQuantity cost { __typename subtotalAmount { __typename amount currencyCode } totalAmount { __typename amount currencyCode } } lines(first: 20) { __typename edges { __typename node { __typename id quantity merchandise { __typename ... on ProductVariant { id title } } } } } } userErrors { __typename code field message } } }"#
    ))

  public var cartId: ID
  public var lineIds: [ID]

  public init(
    cartId: ID,
    lineIds: [ID]
  ) {
    self.cartId = cartId
    self.lineIds = lineIds
  }

  public var __variables: Variables? { [
    "cartId": cartId,
    "lineIds": lineIds
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cartLinesRemove", CartLinesRemove?.self, arguments: [
        "cartId": .variable("cartId"),
        "lineIds": .variable("lineIds")
      ]),
    ] }

    /// Removes one or more merchandise lines from a [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart). Accepts up to 250 line IDs per request. Returns the updated cart along with any errors or warnings.
    ///
    public var cartLinesRemove: CartLinesRemove? { __data["cartLinesRemove"] }

    /// CartLinesRemove
    ///
    /// Parent Type: `CartLinesRemovePayload`
    public struct CartLinesRemove: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CartLinesRemovePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The updated cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartLinesRemove.Cart
      ///
      /// Parent Type: `Cart`
      public struct Cart: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Cart }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("totalQuantity", Int.self),
          .field("cost", Cost.self),
          .field("lines", Lines.self, arguments: ["first": 20]),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The total number of items in the cart.
        public var totalQuantity: Int { __data["totalQuantity"] }
        /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
        public var cost: Cost { __data["cost"] }
        /// A list of lines containing information about the items the customer intends to purchase.
        public var lines: Lines { __data["lines"] }

        /// CartLinesRemove.Cart.Cost
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

          /// CartLinesRemove.Cart.Cost.SubtotalAmount
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

          /// CartLinesRemove.Cart.Cost.TotalAmount
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

        /// CartLinesRemove.Cart.Lines
        ///
        /// Parent Type: `BaseCartLineConnection`
        public struct Lines: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.BaseCartLineConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("edges", [Edge].self),
          ] }

          /// A list of edges.
          public var edges: [Edge] { __data["edges"] }

          /// CartLinesRemove.Cart.Lines.Edge
          ///
          /// Parent Type: `BaseCartLineEdge`
          public struct Edge: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.BaseCartLineEdge }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("node", Node.self),
            ] }

            /// The item at the end of BaseCartLineEdge.
            public var node: Node { __data["node"] }

            /// CartLinesRemove.Cart.Lines.Edge.Node
            ///
            /// Parent Type: `BaseCartLine`
            public struct Node: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Interfaces.BaseCartLine }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", ShopifyAPI.ID.self),
                .field("quantity", Int.self),
                .field("merchandise", Merchandise.self),
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAPI.ID { __data["id"] }
              /// The quantity of the merchandise that the customer intends to purchase.
              public var quantity: Int { __data["quantity"] }
              /// The merchandise that the buyer intends to purchase.
              public var merchandise: Merchandise { __data["merchandise"] }

              /// CartLinesRemove.Cart.Lines.Edge.Node.Merchandise
              ///
              /// Parent Type: `Merchandise`
              public struct Merchandise: ShopifyAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Unions.Merchandise }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .inlineFragment(AsProductVariant.self),
                ] }

                public var asProductVariant: AsProductVariant? { _asInlineFragment() }

                /// CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant
                ///
                /// Parent Type: `ProductVariant`
                public struct AsProductVariant: ShopifyAPI.InlineFragment {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public typealias RootEntityType = RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node.Merchandise
                  public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariant }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("id", ShopifyAPI.ID.self),
                    .field("title", String.self),
                  ] }

                  /// A globally-unique ID.
                  public var id: ShopifyAPI.ID { __data["id"] }
                  /// The product variant’s title.
                  public var title: String { __data["title"] }
                }
              }
            }
          }
        }
      }

      /// CartLinesRemove.UserError
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
