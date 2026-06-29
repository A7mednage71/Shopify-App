// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

nonisolated public struct CreateCartMutation: GraphQLMutation {
  public static let operationName: String = "CreateCart"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateCart($input: CartInput!) { cartCreate(input: $input) { __typename cart { __typename id checkoutUrl totalQuantity cost { __typename subtotalAmount { __typename amount currencyCode } totalAmount { __typename amount currencyCode } totalTaxAmount { __typename amount currencyCode } } lines(first: 20) { __typename edges { __typename node { __typename id quantity cost { __typename totalAmount { __typename amount currencyCode } } merchandise { __typename ... on ProductVariant { id title price { __typename amount currencyCode } availableForSale quantityAvailable image { __typename url altText } product { __typename id title vendor } } } } } } } userErrors { __typename code field message } } }"#
    ))

  public var input: CartInput

  public init(input: CartInput) {
    self.input = input
  }

  @_spi(Unsafe) public var __variables: Variables? { ["input": input] }

  nonisolated public struct Data: ShopifyAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("cartCreate", CartCreate?.self, arguments: ["input": .variable("input")]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      CreateCartMutation.Data.self
    ] }

    /// Creates a new [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart) for a buyer session. You can optionally initialize the cart with merchandise lines, discount codes, gift card codes, buyer identity for international pricing, and custom attributes.
    ///
    /// The returned cart includes a `checkoutUrl` that directs the buyer to complete their purchase.
    ///
    public var cartCreate: CartCreate? { __data["cartCreate"] }

    /// CartCreate
    ///
    /// Parent Type: `CartCreatePayload`
    nonisolated public struct CartCreate: ShopifyAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartCreatePayload }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("cart", Cart?.self),
        .field("userErrors", [UserError].self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        CreateCartMutation.Data.CartCreate.self
      ] }

      /// The new cart.
      public var cart: Cart? { __data["cart"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// CartCreate.Cart
      ///
      /// Parent Type: `Cart`
      nonisolated public struct Cart: ShopifyAPI.SelectionSet {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Cart }
        @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("checkoutUrl", ShopifyAPI.URL.self),
          .field("totalQuantity", Int.self),
          .field("cost", Cost.self),
          .field("lines", Lines.self, arguments: ["first": 20]),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          CreateCartMutation.Data.CartCreate.Cart.self
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The URL of the checkout for the cart.
        public var checkoutUrl: ShopifyAPI.URL { __data["checkoutUrl"] }
        /// The total number of items in the cart.
        public var totalQuantity: Int { __data["totalQuantity"] }
        /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
        public var cost: Cost { __data["cost"] }
        /// A list of lines containing information about the items the customer intends to purchase.
        public var lines: Lines { __data["lines"] }

        /// CartCreate.Cart.Cost
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
            .field("totalTaxAmount", TotalTaxAmount?.self),
          ] }
          @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            CreateCartMutation.Data.CartCreate.Cart.Cost.self
          ] }

          /// The amount, before taxes and cart-level discounts, for the customer to pay.
          public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }
          /// The total amount for the customer to pay.
          public var totalAmount: TotalAmount { __data["totalAmount"] }
          /// The tax amount for the customer to pay at checkout.
          @available(*, deprecated, message: "Tax and duty amounts are no longer available and will be removed in a future version.\nPlease see [the changelog](https://shopify.dev/changelog/tax-and-duties-are-deprecated-in-storefront-cart-api)\nfor more information.\n")
          public var totalTaxAmount: TotalTaxAmount? { __data["totalTaxAmount"] }

          /// CartCreate.Cart.Cost.SubtotalAmount
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
              CreateCartMutation.Data.CartCreate.Cart.Cost.SubtotalAmount.self
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }

          /// CartCreate.Cart.Cost.TotalAmount
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
              CreateCartMutation.Data.CartCreate.Cart.Cost.TotalAmount.self
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }

          /// CartCreate.Cart.Cost.TotalTaxAmount
          ///
          /// Parent Type: `MoneyV2`
          nonisolated public struct TotalTaxAmount: ShopifyAPI.SelectionSet {
            @_spi(Unsafe) public let __data: DataDict
            @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

            @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
            @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
            ] }
            @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              CreateCartMutation.Data.CartCreate.Cart.Cost.TotalTaxAmount.self
            ] }

            /// Decimal money amount.
            public var amount: ShopifyAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }

        /// CartCreate.Cart.Lines
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
            CreateCartMutation.Data.CartCreate.Cart.Lines.self
          ] }

          /// A list of edges.
          public var edges: [Edge] { __data["edges"] }

          /// CartCreate.Cart.Lines.Edge
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
              CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.self
            ] }

            /// The item at the end of BaseCartLineEdge.
            public var node: Node { __data["node"] }

            /// CartCreate.Cart.Lines.Edge.Node
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
                .field("cost", Cost.self),
                .field("merchandise", Merchandise.self),
              ] }
              @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.self
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAPI.ID { __data["id"] }
              /// The quantity of the merchandise that the customer intends to purchase.
              public var quantity: Int { __data["quantity"] }
              /// The cost of the merchandise that the buyer will pay for at checkout. The costs are subject to change and changes will be reflected at checkout.
              public var cost: Cost { __data["cost"] }
              /// The merchandise that the buyer intends to purchase.
              public var merchandise: Merchandise { __data["merchandise"] }

              /// CartCreate.Cart.Lines.Edge.Node.Cost
              ///
              /// Parent Type: `CartLineCost`
              nonisolated public struct Cost: ShopifyAPI.SelectionSet {
                @_spi(Unsafe) public let __data: DataDict
                @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartLineCost }
                @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("totalAmount", TotalAmount.self),
                ] }
                @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Cost.self
                ] }

                /// The total cost of the merchandise line.
                public var totalAmount: TotalAmount { __data["totalAmount"] }

                /// CartCreate.Cart.Lines.Edge.Node.Cost.TotalAmount
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
                    CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Cost.TotalAmount.self
                  ] }

                  /// Decimal money amount.
                  public var amount: ShopifyAPI.Decimal { __data["amount"] }
                  /// Currency of the money.
                  public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
                }
              }

              /// CartCreate.Cart.Lines.Edge.Node.Merchandise
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
                  CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.self
                ] }

                public var asProductVariant: AsProductVariant? { _asInlineFragment() }

                /// CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant
                ///
                /// Parent Type: `ProductVariant`
                nonisolated public struct AsProductVariant: ShopifyAPI.InlineFragment {
                  @_spi(Unsafe) public let __data: DataDict
                  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                  public typealias RootEntityType = CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise
                  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariant }
                  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                    .field("id", ShopifyAPI.ID.self),
                    .field("title", String.self),
                    .field("price", Price.self),
                    .field("availableForSale", Bool.self),
                    .field("quantityAvailable", Int?.self),
                    .field("image", Image?.self),
                    .field("product", Product.self),
                  ] }
                  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                    CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.self,
                    CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.self
                  ] }

                  /// A globally-unique ID.
                  public var id: ShopifyAPI.ID { __data["id"] }
                  /// The product variant’s title.
                  public var title: String { __data["title"] }
                  /// The product variant’s price.
                  public var price: Price { __data["price"] }
                  /// Indicates if the product variant is available for sale.
                  public var availableForSale: Bool { __data["availableForSale"] }
                  /// The total sellable quantity of the variant for online sales channels.
                  public var quantityAvailable: Int? { __data["quantityAvailable"] }
                  /// Image associated with the product variant. This field falls back to the product image if no image is available.
                  public var image: Image? { __data["image"] }
                  /// The product object that the product variant belongs to.
                  public var product: Product { __data["product"] }

                  /// CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price
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
                      CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price.self
                    ] }

                    /// Decimal money amount.
                    public var amount: ShopifyAPI.Decimal { __data["amount"] }
                    /// Currency of the money.
                    public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
                  }

                  /// CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image
                  ///
                  /// Parent Type: `Image`
                  nonisolated public struct Image: ShopifyAPI.SelectionSet {
                    @_spi(Unsafe) public let __data: DataDict
                    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Image }
                    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("url", ShopifyAPI.URL.self),
                      .field("altText", String?.self),
                    ] }
                    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                      CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image.self
                    ] }

                    /// The location of the image as a URL.
                    ///
                    /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
                    ///
                    /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
                    ///
                    /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
                    ///
                    public var url: ShopifyAPI.URL { __data["url"] }
                    /// A word or phrase to share the nature or contents of an image.
                    public var altText: String? { __data["altText"] }
                  }

                  /// CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product
                  ///
                  /// Parent Type: `Product`
                  nonisolated public struct Product: ShopifyAPI.SelectionSet {
                    @_spi(Unsafe) public let __data: DataDict
                    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.Product }
                    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("id", ShopifyAPI.ID.self),
                      .field("title", String.self),
                      .field("vendor", String.self),
                    ] }
                    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                      CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product.self
                    ] }

                    /// A globally-unique ID.
                    public var id: ShopifyAPI.ID { __data["id"] }
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

      /// CartCreate.UserError
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
          CreateCartMutation.Data.CartCreate.UserError.self
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
