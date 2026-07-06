// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetTrendingProductsQuery: GraphQLQuery {
  public static let operationName: String = "GetTrendingProducts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetTrendingProducts($first: Int = 10) { products(first: $first, sortKey: BEST_SELLING) { __typename nodes { __typename id title handle featuredImage { __typename url } priceRange { __typename minVariantPrice { __typename amount currencyCode } } compareAtPriceRange { __typename minVariantPrice { __typename amount currencyCode } } } } }"#
    ))

  public var first: GraphQLNullable<Int>

  public init(first: GraphQLNullable<Int> = 10) {
    self.first = first
  }

  public var __variables: Variables? { ["first": first] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("products", Products.self, arguments: [
        "first": .variable("first"),
        "sortKey": "BEST_SELLING"
      ]),
    ] }

    /// Returns a paginated list of the shop's [products](https://shopify.dev/docs/api/storefront/current/objects/Product).
    ///
    /// For full-text storefront search, use the [`search`](https://shopify.dev/docs/api/storefront/current/queries/search) query instead.
    ///
    public var products: Products { __data["products"] }

    /// Products
    ///
    /// Parent Type: `ProductConnection`
    public struct Products: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("nodes", [Node].self),
      ] }

      /// A list of the nodes contained in ProductEdge.
      public var nodes: [Node] { __data["nodes"] }

      /// Products.Node
      ///
      /// Parent Type: `Product`
      public struct Node: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Product }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("title", String.self),
          .field("handle", String.self),
          .field("featuredImage", FeaturedImage?.self),
          .field("priceRange", PriceRange.self),
          .field("compareAtPriceRange", CompareAtPriceRange.self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The name for the product that displays to customers. The title is used to construct the product's handle.
        /// For example, if a product is titled "Black Sunglasses", then the handle is `black-sunglasses`.
        ///
        public var title: String { __data["title"] }
        /// A unique, human-readable string of the product's title.
        /// A handle can contain letters, hyphens (`-`), and numbers, but no spaces.
        /// The handle is used in the online store URL for the product.
        ///
        public var handle: String { __data["handle"] }
        /// The featured image for the product.
        ///
        /// This field is functionally equivalent to `images(first: 1)`.
        ///
        public var featuredImage: FeaturedImage? { __data["featuredImage"] }
        /// The minimum and maximum prices of a product, expressed in decimal numbers.
        /// For example, if the product is priced between $10.00 and $50.00,
        /// then the price range is $10.00 - $50.00.
        ///
        public var priceRange: PriceRange { __data["priceRange"] }
        /// The [compare-at price range](https://help.shopify.com/manual/products/details/product-pricing/sale-pricing) of the product in the shop's default currency.
        public var compareAtPriceRange: CompareAtPriceRange { __data["compareAtPriceRange"] }

        /// Products.Node.FeaturedImage
        ///
        /// Parent Type: `Image`
        public struct FeaturedImage: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Image }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("url", ShopifyAPI.URL.self),
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
        }

        /// Products.Node.PriceRange
        ///
        /// Parent Type: `ProductPriceRange`
        public struct PriceRange: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductPriceRange }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("minVariantPrice", MinVariantPrice.self),
          ] }

          /// The lowest variant's price.
          public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

          /// Products.Node.PriceRange.MinVariantPrice
          ///
          /// Parent Type: `MoneyV2`
          public struct MinVariantPrice: ShopifyAPI.SelectionSet {
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

        /// Products.Node.CompareAtPriceRange
        ///
        /// Parent Type: `ProductPriceRange`
        public struct CompareAtPriceRange: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductPriceRange }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("minVariantPrice", MinVariantPrice.self),
          ] }

          /// The lowest variant's price.
          public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

          /// Products.Node.CompareAtPriceRange.MinVariantPrice
          ///
          /// Parent Type: `MoneyV2`
          public struct MinVariantPrice: ShopifyAPI.SelectionSet {
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
    }
  }
}
