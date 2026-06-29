// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

nonisolated public struct AddCartLinesMutation: GraphQLMutation {
  public static let operationName: String = "AddCartLines"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddCartLines($cartId: ID!, $lines: [CartLineInput!]!) { cartLinesAdd(cartId: $cartId, lines: $lines) { __typename cart { __typename id totalQuantity cost { __typename subtotalAmount { __typename amount currencyCode } totalAmount { __typename amount currencyCode } } lines(first: 20) { __typename edges { __typename node { __typename id quantity merchandise { __typename ... on ProductVariant { id title price { __typename amount currencyCode } quantityAvailable product { __typename title vendor } } } } } } } userErrors { __typename code field message } } }"#
    ))

  public var cartId: ID
  public var lines: [CartLineInput]

  public init(
    cartId: ID,
    lines: [CartLineInput]
  ) {
    self.cartId = cartId
    self.lines = lines
  }

  @_spi(Unsafe) public var __variables: Variables? { [
    "cartId": cartId,
    "lines": lines
  ] }

  nonisolated public struct Data: ShopifyAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("cartLinesAdd", CartLinesAdd?.self, arguments: [
        "cartId": .variable("cartId"),
        "lines": .variable("lines")
      ]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      AddCartLinesMutation.Data.self
    ] }

    /// Adds one or more merchandise lines to an existing [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart). Each line specifies the [product variant](https://shopify.dev/docs/api/storefront/current/objects/ProductVariant) to purchase. Quantity defaults to `1` if not provided.
    ///
    /// You can add up to 250 lines in a single request. Use [`CartLineInput`](https://shopify.dev/docs/api/storefront/current/input-objects/CartLineInput) to configure each line's merchandise, quantity, selling plan, custom attributes, and any parent relationships for nested line items such as warranties or add-ons.
    ///
    public var cartLinesAdd: CartLinesAdd? { __data["cartLinesAdd"] }

    /// CartLinesAdd
    ///
    /// Parent Type: `CartLinesAddPayload`
    nonisolated public struct CartLinesAdd: ShopifyAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartLinesAddPayload }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        AddCartLinesMutation.Data.CartLinesAdd.self
      ] }

      /// The updated cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartLinesAdd.Cart
      ///
      /// Parent Type: `Cart`
      nonisolated public struct Cart: ShopifyAPI.SelectionSet {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Cart }
        @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("totalQuantity", Int.self),
          .field("cost", Cost.self),
          .field("lines", Lines.self, arguments: ["first": 20]),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          AddCartLinesMutation.Data.CartLinesAdd.Cart.self
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The total number of items in the cart.
        public var totalQuantity: Int { __data["totalQuantity"] }
        /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
        public var cost: Cost { __data["cost"] }
        /// A list of lines containing information about the items the customer intends to purchase.
        public var lines: Lines { __data["lines"] }

        /// CartLinesAdd.Cart.Cost
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
            AddCartLinesMutation.Data.CartLinesAdd.Cart.Cost.self
          ] }

          /// The amount, before taxes and cart-level discounts, for the customer to pay.
          public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }
          /// The total amount for the customer to pay.
          public var totalAmount: TotalAmount { __data["totalAmount"] }

          /// CartLinesAdd.Cart.Cost.SubtotalAmount
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
              AddCartLinesMutation.Data.CartLinesAdd.Cart.Cost.SubtotalAmount.self
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }

          /// CartLinesAdd.Cart.Cost.TotalAmount
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
              AddCartLinesMutation.Data.CartLinesAdd.Cart.Cost.TotalAmount.self
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }

        /// CartLinesAdd.Cart.Lines
        ///
        /// Parent Type: `BaseCartLineConnection`
        nonisolated public struct Lines: ShopifyAPI.SelectionSet {
          @_spi(Unsafe) public let __data: DataDict
          @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

          @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.BaseCartLineConnection }
          @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("edges", [Edge].self),
          ] }
          @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.self
          ] }

          /// A list of edges.
          public var edges: [Edge] { __data["edges"] }

          /// CartLinesAdd.Cart.Lines.Edge
          ///
          /// Parent Type: `BaseCartLineEdge`
          nonisolated public struct Edge: ShopifyAPI.SelectionSet {
            @_spi(Unsafe) public let __data: DataDict
            @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

            @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.BaseCartLineEdge }
            @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("node", Node.self),
            ] }
            @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.self
            ] }

            /// The item at the end of BaseCartLineEdge.
            public var node: Node { __data["node"] }

            /// CartLinesAdd.Cart.Lines.Edge.Node
            ///
            /// Parent Type: `BaseCartLine`
            nonisolated public struct Node: ShopifyAPI.SelectionSet {
              @_spi(Unsafe) public let __data: DataDict
              @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

              @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Interfaces.BaseCartLine }
              @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", ShopifyAPI.ID.self),
                .field("quantity", Int.self),
                .field("merchandise", Merchandise.self),
              ] }
              @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.self
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAPI.ID { __data["id"] }
              /// The quantity of the merchandise that the customer intends to purchase.
              public var quantity: Int { __data["quantity"] }
              /// The merchandise that the buyer intends to purchase.
              public var merchandise: Merchandise { __data["merchandise"] }

              /// CartLinesAdd.Cart.Lines.Edge.Node.Merchandise
              ///
              /// Parent Type: `Merchandise`
              nonisolated public struct Merchandise: ShopifyAPI.SelectionSet {
                @_spi(Unsafe) public let __data: DataDict
                @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Unions.Merchandise }
                @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .inlineFragment(AsProductVariant.self),
                ] }
                @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.self
                ] }

                public var asProductVariant: AsProductVariant? { _asInlineFragment() }

                /// CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant
                ///
                /// Parent Type: `ProductVariant`
                nonisolated public struct AsProductVariant: ShopifyAPI.InlineFragment {
                  @_spi(Unsafe) public let __data: DataDict
                  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                  public typealias RootEntityType = AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise
                  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariant }
                  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                    .field("id", ShopifyAPI.ID.self),
                    .field("title", String.self),
                    .field("price", Price.self),
                    .field("quantityAvailable", Int?.self),
                    .field("product", Product.self),
                  ] }
                  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                    AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.self,
                    AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.self
                  ] }

                  /// A globally-unique ID.
                  public var id: ShopifyAPI.ID { __data["id"] }
                  /// The product variant’s title.
                  public var title: String { __data["title"] }
                  /// The product variant’s price.
                  public var price: Price { __data["price"] }
                  /// The total sellable quantity of the variant for online sales channels.
                  public var quantityAvailable: Int? { __data["quantityAvailable"] }
                  /// The product object that the product variant belongs to.
                  public var product: Product { __data["product"] }

                  /// CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price
                  ///
                  /// Parent Type: `MoneyV2`
                  nonisolated public struct Price: ShopifyAPI.SelectionSet {
                    @_spi(Unsafe) public let __data: DataDict
                    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
                    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("amount", ShopifyAPI.Decimal.self),
                      .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
                    ] }
                    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                      AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price.self
                    ] }

                    /// Decimal money amount.
                    public var amount: ShopifyAPI.Decimal { __data["amount"] }
                    /// Currency of the money.
                    public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
                  }

                  /// CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product
                  ///
                  /// Parent Type: `Product`
                  nonisolated public struct Product: ShopifyAPI.SelectionSet {
                    @_spi(Unsafe) public let __data: DataDict
                    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Product }
                    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("title", String.self),
                      .field("vendor", String.self),
                    ] }
                    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                      AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product.self
                    ] }

                    /// The name for the product that displays to customers. The title is used to construct the product's handle.
                    /// For example, if a product is titled "Black Sunglasses", then the handle is `black-sunglasses`.
                    ///
                    public var title: String { __data["title"] }
                    /// The name of the product's vendor.
                    public var vendor: String { __data["vendor"] }
                  }
                }
              }
            }
          }
        }
      }

      /// CartLinesAdd.UserError
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
          AddCartLinesMutation.Data.CartLinesAdd.UserError.self
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
