// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateCartLinesMutation: GraphQLMutation {
  public static let operationName: String = "UpdateCartLines"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCartLines($cartId: ID!, $lines: [CartLineUpdateInput!]!) { cartLinesUpdate(cartId: $cartId, lines: $lines) { __typename cart { __typename id totalQuantity cost { __typename subtotalAmount { __typename amount currencyCode } totalAmount { __typename amount currencyCode } } lines(first: 20) { __typename edges { __typename node { __typename id quantity merchandise { __typename ... on ProductVariant { id title quantityAvailable availableForSale } } } } } } userErrors { __typename code field message } } }"#
    ))

  public var cartId: ID
  public var lines: [CartLineUpdateInput]

  public init(
    cartId: ID,
    lines: [CartLineUpdateInput]
  ) {
    self.cartId = cartId
    self.lines = lines
  }

  public var __variables: Variables? { [
    "cartId": cartId,
    "lines": lines
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("cartLinesUpdate", CartLinesUpdate?.self, arguments: [
        "cartId": .variable("cartId"),
        "lines": .variable("lines")
      ]),
    ] }

    /// Updates one or more merchandise lines on a [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart). You can modify the quantity, swap the merchandise, change custom attributes, or update the selling plan for each line. You can update a maximum of 250 lines per request.
    ///
    /// Omitting the [`attributes`](https://shopify.dev/docs/api/storefront/current/mutations/cartLinesUpdate#arguments-lines.fields.attributes) field or setting it to null preserves existing line attributes. Pass an empty array to clear all attributes from a line.
    ///
    public var cartLinesUpdate: CartLinesUpdate? { __data["cartLinesUpdate"] }

    /// CartLinesUpdate
    ///
    /// Parent Type: `CartLinesUpdatePayload`
    public struct CartLinesUpdate: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CartLinesUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The updated cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartLinesUpdate.Cart
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

        /// CartLinesUpdate.Cart.Cost
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

          /// CartLinesUpdate.Cart.Cost.SubtotalAmount
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

          /// CartLinesUpdate.Cart.Cost.TotalAmount
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

        /// CartLinesUpdate.Cart.Lines
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

          /// CartLinesUpdate.Cart.Lines.Edge
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

            /// CartLinesUpdate.Cart.Lines.Edge.Node
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

              /// CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise
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

                /// CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant
                ///
                /// Parent Type: `ProductVariant`
                public struct AsProductVariant: ShopifyAPI.InlineFragment {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public typealias RootEntityType = UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise
                  public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariant }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("id", ShopifyAPI.ID.self),
                    .field("title", String.self),
                    .field("quantityAvailable", Int?.self),
                    .field("availableForSale", Bool.self),
                  ] }

                  /// A globally-unique ID.
                  public var id: ShopifyAPI.ID { __data["id"] }
                  /// The product variant’s title.
                  public var title: String { __data["title"] }
                  /// The total sellable quantity of the variant for online sales channels.
                  public var quantityAvailable: Int? { __data["quantityAvailable"] }
                  /// Indicates if the product variant is available for sale.
                  public var availableForSale: Bool { __data["availableForSale"] }
                }
              }
            }
          }
        }
      }

      /// CartLinesUpdate.UserError
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
