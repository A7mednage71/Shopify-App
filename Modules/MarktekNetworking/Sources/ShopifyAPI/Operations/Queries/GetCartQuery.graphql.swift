// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

nonisolated public struct GetCartQuery: GraphQLQuery {
  public static let operationName: String = "GetCart"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCart($cartId: ID!) { cart(id: $cartId) { __typename id checkoutUrl totalQuantity discountCodes { __typename code applicable } cost { __typename subtotalAmount { __typename amount currencyCode } totalAmount { __typename amount currencyCode } totalTaxAmount { __typename amount currencyCode } checkoutChargeAmount { __typename amount currencyCode } } lines(first: 20) { __typename edges { __typename node { __typename id quantity cost { __typename totalAmount { __typename amount currencyCode } amountPerQuantity { __typename amount currencyCode } compareAtAmountPerQuantity { __typename amount currencyCode } } merchandise { __typename ... on ProductVariant { id title price { __typename amount currencyCode } compareAtPrice { __typename amount currencyCode } availableForSale quantityAvailable selectedOptions { __typename name value } image { __typename url altText } product { __typename id title vendor } } } } } } } }"#
    ))

  public var cartId: ID

  public init(cartId: ID) {
    self.cartId = cartId
  }

  @_spi(Unsafe) public var __variables: Variables? { ["cartId": cartId] }

  nonisolated public struct Data: ShopifyAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("cart", Cart?.self, arguments: ["id": .variable("cartId")]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      GetCartQuery.Data.self
    ] }

    /// Returns a [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart) by its ID. The cart contains the merchandise lines a buyer intends to purchase, along with estimated costs, applied discounts, gift cards, and delivery options.
    ///
    /// Use the [`checkoutUrl`](https://shopify.dev/docs/api/storefront/latest/queries/cart#returns-Cart.fields.checkoutUrl) field to redirect buyers to Shopify's web checkout when they're ready to complete their purchase. For more information, refer to [Manage a cart with the Storefront API](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/cart/manage).
    ///
    public var cart: Cart? { __data["cart"] }

    /// Cart
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
        .field("discountCodes", [DiscountCode].self),
        .field("cost", Cost.self),
        .field("lines", Lines.self, arguments: ["first": 20]),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetCartQuery.Data.Cart.self
      ] }

      /// A globally-unique ID.
      public var id: ShopifyAPI.ID { __data["id"] }
      /// The URL of the checkout for the cart.
      public var checkoutUrl: ShopifyAPI.URL { __data["checkoutUrl"] }
      /// The total number of items in the cart.
      public var totalQuantity: Int { __data["totalQuantity"] }
      /// The case-insensitive discount codes that the customer added at checkout.
      public var discountCodes: [DiscountCode] { __data["discountCodes"] }
      /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
      public var cost: Cost { __data["cost"] }
      /// A list of lines containing information about the items the customer intends to purchase.
      public var lines: Lines { __data["lines"] }

      /// Cart.DiscountCode
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
          GetCartQuery.Data.Cart.DiscountCode.self
        ] }

        /// The code for the discount.
        public var code: String { __data["code"] }
        /// Whether the discount code is applicable to the cart's current contents.
        public var applicable: Bool { __data["applicable"] }
      }

      /// Cart.Cost
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
          .field("checkoutChargeAmount", CheckoutChargeAmount.self),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          GetCartQuery.Data.Cart.Cost.self
        ] }

        /// The amount, before taxes and cart-level discounts, for the customer to pay.
        public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }
        /// The total amount for the customer to pay.
        public var totalAmount: TotalAmount { __data["totalAmount"] }
        /// The tax amount for the customer to pay at checkout.
        @available(*, deprecated, message: "Tax and duty amounts are no longer available and will be removed in a future version.\nPlease see [the changelog](https://shopify.dev/changelog/tax-and-duties-are-deprecated-in-storefront-cart-api)\nfor more information.\n")
        public var totalTaxAmount: TotalTaxAmount? { __data["totalTaxAmount"] }
        /// The estimated amount, before taxes and discounts, for the customer to pay at checkout. The checkout charge amount doesn't include any deferred payments that'll be paid at a later date. If the cart has no deferred payments, then the checkout charge amount is equivalent to `subtotalAmount`.
        public var checkoutChargeAmount: CheckoutChargeAmount { __data["checkoutChargeAmount"] }

        /// Cart.Cost.SubtotalAmount
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
            GetCartQuery.Data.Cart.Cost.SubtotalAmount.self
          ] }

          /// Decimal money amount.
          public var amount: ShopifyAPI.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
        }

        /// Cart.Cost.TotalAmount
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
            GetCartQuery.Data.Cart.Cost.TotalAmount.self
          ] }

          /// Decimal money amount.
          public var amount: ShopifyAPI.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
        }

        /// Cart.Cost.TotalTaxAmount
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
            GetCartQuery.Data.Cart.Cost.TotalTaxAmount.self
          ] }

          /// Decimal money amount.
          public var amount: ShopifyAPI.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
        }

        /// Cart.Cost.CheckoutChargeAmount
        ///
        /// Parent Type: `MoneyV2`
        nonisolated public struct CheckoutChargeAmount: ShopifyAPI.SelectionSet {
          @_spi(Unsafe) public let __data: DataDict
          @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

          @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
          @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("amount", ShopifyAPI.Decimal.self),
            .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
          ] }
          @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            GetCartQuery.Data.Cart.Cost.CheckoutChargeAmount.self
          ] }

          /// Decimal money amount.
          public var amount: ShopifyAPI.Decimal { __data["amount"] }
          /// Currency of the money.
          public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
        }
      }

      /// Cart.Lines
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
          GetCartQuery.Data.Cart.Lines.self
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Cart.Lines.Edge
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
            GetCartQuery.Data.Cart.Lines.Edge.self
          ] }

          /// The item at the end of BaseCartLineEdge.
          public var node: Node { __data["node"] }

          /// Cart.Lines.Edge.Node
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
              GetCartQuery.Data.Cart.Lines.Edge.Node.self
            ] }

            /// A globally-unique ID.
            public var id: ShopifyAPI.ID { __data["id"] }
            /// The quantity of the merchandise that the customer intends to purchase.
            public var quantity: Int { __data["quantity"] }
            /// The cost of the merchandise that the buyer will pay for at checkout. The costs are subject to change and changes will be reflected at checkout.
            public var cost: Cost { __data["cost"] }
            /// The merchandise that the buyer intends to purchase.
            public var merchandise: Merchandise { __data["merchandise"] }

            /// Cart.Lines.Edge.Node.Cost
            ///
            /// Parent Type: `CartLineCost`
            nonisolated public struct Cost: ShopifyAPI.SelectionSet {
              @_spi(Unsafe) public let __data: DataDict
              @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

              @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.CartLineCost }
              @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("totalAmount", TotalAmount.self),
                .field("amountPerQuantity", AmountPerQuantity.self),
                .field("compareAtAmountPerQuantity", CompareAtAmountPerQuantity?.self),
              ] }
              @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.self
              ] }

              /// The total cost of the merchandise line.
              public var totalAmount: TotalAmount { __data["totalAmount"] }
              /// The amount of the merchandise line.
              public var amountPerQuantity: AmountPerQuantity { __data["amountPerQuantity"] }
              /// The compare at amount of the merchandise line.
              public var compareAtAmountPerQuantity: CompareAtAmountPerQuantity? { __data["compareAtAmountPerQuantity"] }

              /// Cart.Lines.Edge.Node.Cost.TotalAmount
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
                  GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.TotalAmount.self
                ] }

                /// Decimal money amount.
                public var amount: ShopifyAPI.Decimal { __data["amount"] }
                /// Currency of the money.
                public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
              }

              /// Cart.Lines.Edge.Node.Cost.AmountPerQuantity
              ///
              /// Parent Type: `MoneyV2`
              nonisolated public struct AmountPerQuantity: ShopifyAPI.SelectionSet {
                @_spi(Unsafe) public let __data: DataDict
                @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
                @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("amount", ShopifyAPI.Decimal.self),
                  .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
                ] }
                @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.AmountPerQuantity.self
                ] }

                /// Decimal money amount.
                public var amount: ShopifyAPI.Decimal { __data["amount"] }
                /// Currency of the money.
                public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
              }

              /// Cart.Lines.Edge.Node.Cost.CompareAtAmountPerQuantity
              ///
              /// Parent Type: `MoneyV2`
              nonisolated public struct CompareAtAmountPerQuantity: ShopifyAPI.SelectionSet {
                @_spi(Unsafe) public let __data: DataDict
                @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
                @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("amount", ShopifyAPI.Decimal.self),
                  .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
                ] }
                @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.CompareAtAmountPerQuantity.self
                ] }

                /// Decimal money amount.
                public var amount: ShopifyAPI.Decimal { __data["amount"] }
                /// Currency of the money.
                public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
              }
            }

            /// Cart.Lines.Edge.Node.Merchandise
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
                GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.self
              ] }

              public var asProductVariant: AsProductVariant? { _asInlineFragment() }

              /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant
              ///
              /// Parent Type: `ProductVariant`
              nonisolated public struct AsProductVariant: ShopifyAPI.InlineFragment {
                @_spi(Unsafe) public let __data: DataDict
                @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                public typealias RootEntityType = GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise
                @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariant }
                @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                  .field("id", ShopifyAPI.ID.self),
                  .field("title", String.self),
                  .field("price", Price.self),
                  .field("compareAtPrice", CompareAtPrice?.self),
                  .field("availableForSale", Bool.self),
                  .field("quantityAvailable", Int?.self),
                  .field("selectedOptions", [SelectedOption].self),
                  .field("image", Image?.self),
                  .field("product", Product.self),
                ] }
                @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.self,
                  GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.self
                ] }

                /// A globally-unique ID.
                public var id: ShopifyAPI.ID { __data["id"] }
                /// The product variant’s title.
                public var title: String { __data["title"] }
                /// The product variant’s price.
                public var price: Price { __data["price"] }
                /// The compare at price of the variant. This can be used to mark a variant as on sale, when `compareAtPrice` is higher than `price`.
                public var compareAtPrice: CompareAtPrice? { __data["compareAtPrice"] }
                /// Indicates if the product variant is available for sale.
                public var availableForSale: Bool { __data["availableForSale"] }
                /// The total sellable quantity of the variant for online sales channels.
                public var quantityAvailable: Int? { __data["quantityAvailable"] }
                /// List of product options applied to the variant.
                public var selectedOptions: [SelectedOption] { __data["selectedOptions"] }
                /// Image associated with the product variant. This field falls back to the product image if no image is available.
                public var image: Image? { __data["image"] }
                /// The product object that the product variant belongs to.
                public var product: Product { __data["product"] }

                /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price
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
                    GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price.self
                  ] }

                  /// Decimal money amount.
                  public var amount: ShopifyAPI.Decimal { __data["amount"] }
                  /// Currency of the money.
                  public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
                }

                /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.CompareAtPrice
                ///
                /// Parent Type: `MoneyV2`
                nonisolated public struct CompareAtPrice: ShopifyAPI.SelectionSet {
                  @_spi(Unsafe) public let __data: DataDict
                  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.MoneyV2 }
                  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("amount", ShopifyAPI.Decimal.self),
                    .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
                  ] }
                  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                    GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.CompareAtPrice.self
                  ] }

                  /// Decimal money amount.
                  public var amount: ShopifyAPI.Decimal { __data["amount"] }
                  /// Currency of the money.
                  public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
                }

                /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.SelectedOption
                ///
                /// Parent Type: `SelectedOption`
                nonisolated public struct SelectedOption: ShopifyAPI.SelectionSet {
                  @_spi(Unsafe) public let __data: DataDict
                  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

                  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { ShopifyAPI.Objects.SelectedOption }
                  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("name", String.self),
                    .field("value", String.self),
                  ] }
                  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                    GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.SelectedOption.self
                  ] }

                  /// The product option’s name.
                  public var name: String { __data["name"] }
                  /// The product option’s value.
                  public var value: String { __data["value"] }
                }

                /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image
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
                    GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image.self
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

                /// Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product
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
                    GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product.self
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
  }
}
