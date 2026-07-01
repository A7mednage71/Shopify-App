// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SearchProductsQuery: GraphQLQuery {
  public static let operationName: String = "SearchProducts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query SearchProducts($query: String!, $first: Int = 20) { search(query: $query, types: PRODUCT, first: $first) { __typename totalCount nodes { __typename ... on Product { id title description handle featuredImage { __typename url altText } priceRange { __typename minVariantPrice { __typename amount currencyCode } } compareAtPriceRange { __typename minVariantPrice { __typename amount currencyCode } } ratingMetafield: metafield(namespace: "custom", key: "rating") { __typename value } reviewCountMetafield: metafield(namespace: "custom", key: "review_count") { __typename value } } } } }"#
    ))

  public var query: String
  public var first: GraphQLNullable<Int>

  public init(
    query: String,
    first: GraphQLNullable<Int> = 20
  ) {
    self.query = query
    self.first = first
  }

  public var __variables: Variables? { [
    "query": query,
    "first": first
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("search", Search.self, arguments: [
        "query": .variable("query"),
        "types": "PRODUCT",
        "first": .variable("first")
      ]),
    ] }

    /// Returns paginated search results for [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product), [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page), and [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article) resources based on a query string. Results are sorted by relevance by default.
    ///
    /// The response includes the total result count and available product filters for building [faceted search interfaces](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/filter-products). Use the [`prefix`](https://shopify.dev/docs/api/storefront/current/enums/SearchPrefixQueryType) argument to enable partial word matching on the last search term, allowing queries like "winter snow" to match "snowboard" or "snowshoe".
    ///
    public var search: Search { __data["search"] }

    /// Search
    ///
    /// Parent Type: `SearchResultItemConnection`
    public struct Search: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.SearchResultItemConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("totalCount", Int.self),
        .field("nodes", [Node].self),
      ] }

      /// The total number of results.
      public var totalCount: Int { __data["totalCount"] }
      /// A list of the nodes contained in SearchResultItemEdge.
      public var nodes: [Node] { __data["nodes"] }

      /// Search.Node
      ///
      /// Parent Type: `SearchResultItem`
      public struct Node: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Unions.SearchResultItem }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .inlineFragment(AsProduct.self),
        ] }

        public var asProduct: AsProduct? { _asInlineFragment() }

        /// Search.Node.AsProduct
        ///
        /// Parent Type: `Product`
        public struct AsProduct: ShopifyAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = SearchProductsQuery.Data.Search.Node
          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Product }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("id", ShopifyAPI.ID.self),
            .field("title", String.self),
            .field("description", String.self),
            .field("handle", String.self),
            .field("featuredImage", FeaturedImage?.self),
            .field("priceRange", PriceRange.self),
            .field("compareAtPriceRange", CompareAtPriceRange.self),
            .field("metafield", alias: "ratingMetafield", RatingMetafield?.self, arguments: [
              "namespace": "custom",
              "key": "rating"
            ]),
            .field("metafield", alias: "reviewCountMetafield", ReviewCountMetafield?.self, arguments: [
              "namespace": "custom",
              "key": "review_count"
            ]),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// The name for the product that displays to customers. The title is used to construct the product's handle.
          /// For example, if a product is titled "Black Sunglasses", then the handle is `black-sunglasses`.
          ///
          public var title: String { __data["title"] }
          /// A single-line description of the product, with [HTML tags](https://developer.mozilla.org/en-US/docs/Web/HTML) removed.
          public var description: String { __data["description"] }
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
          /// A [custom field](https://shopify.dev/docs/apps/build/custom-data), including its `namespace` and `key`, that's associated with a Shopify resource for the purposes of adding and storing additional information.
          public var ratingMetafield: RatingMetafield? { __data["ratingMetafield"] }
          /// A [custom field](https://shopify.dev/docs/apps/build/custom-data), including its `namespace` and `key`, that's associated with a Shopify resource for the purposes of adding and storing additional information.
          public var reviewCountMetafield: ReviewCountMetafield? { __data["reviewCountMetafield"] }

          /// Search.Node.AsProduct.FeaturedImage
          ///
          /// Parent Type: `Image`
          public struct FeaturedImage: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Image }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("url", ShopifyAPI.URL.self),
              .field("altText", String?.self),
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

          /// Search.Node.AsProduct.PriceRange
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

            /// Search.Node.AsProduct.PriceRange.MinVariantPrice
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

          /// Search.Node.AsProduct.CompareAtPriceRange
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

            /// Search.Node.AsProduct.CompareAtPriceRange.MinVariantPrice
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

          /// Search.Node.AsProduct.RatingMetafield
          ///
          /// Parent Type: `Metafield`
          public struct RatingMetafield: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Metafield }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("value", String.self),
            ] }

            /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
            public var value: String { __data["value"] }
          }

          /// Search.Node.AsProduct.ReviewCountMetafield
          ///
          /// Parent Type: `Metafield`
          public struct ReviewCountMetafield: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Metafield }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("value", String.self),
            ] }

            /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
            public var value: String { __data["value"] }
          }
        }
      }
    }
  }
}
