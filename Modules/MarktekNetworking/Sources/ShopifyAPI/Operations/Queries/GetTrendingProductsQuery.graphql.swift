// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetTrendingProductsQuery: GraphQLQuery {
  public static let operationName: String = "GetTrendingProducts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetTrendingProducts($first: Int = 10, $language: LanguageCode) @inContext(language: $language) { products(first: $first, sortKey: BEST_SELLING) { __typename nodes { __typename id title handle featuredImage { __typename url } priceRange { __typename minVariantPrice { __typename amount currencyCode } } compareAtPriceRange { __typename minVariantPrice { __typename amount currencyCode } } metafields(identifiers: [{namespace: "reviews", key: "items"}]) { __typename key namespace value type references(first: 100) { __typename edges { __typename node { __typename ... on Metaobject { id handle type updatedAt product: field(key: "product") { __typename key type value } customerName: field(key: "customer_name") { __typename key type value } rating: field(key: "rating") { __typename key type value } title: field(key: "title") { __typename key type value } body: field(key: "body") { __typename key type value } createdAt: field(key: "created_at") { __typename key type value } approved: field(key: "approved") { __typename key type value } } } } } } } } }"#
    ))

  public var first: GraphQLNullable<Int>
  public var language: GraphQLNullable<GraphQLEnum<LanguageCode>>

  public init(
    first: GraphQLNullable<Int> = 10,
    language: GraphQLNullable<GraphQLEnum<LanguageCode>>
  ) {
    self.first = first
    self.language = language
  }

  public var __variables: Variables? { [
    "first": first,
    "language": language
  ] }

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
          .field("metafields", [Metafield?].self, arguments: ["identifiers": [[
            "namespace": "reviews",
            "key": "items"
          ]]]),
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
        /// A list of [custom fields](/docs/apps/build/custom-data) that a merchant associates with a Shopify resource.
        public var metafields: [Metafield?] { __data["metafields"] }

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

        /// Products.Node.Metafield
        ///
        /// Parent Type: `Metafield`
        public struct Metafield: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Metafield }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("key", String.self),
            .field("namespace", String.self),
            .field("value", String.self),
            .field("type", String.self),
            .field("references", References?.self, arguments: ["first": 100]),
          ] }

          /// The unique identifier for the metafield within its namespace.
          public var key: String { __data["key"] }
          /// The container for a group of metafields that the metafield is associated with.
          public var namespace: String { __data["namespace"] }
          /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
          public var value: String { __data["value"] }
          /// The type name of the metafield.
          /// Refer to the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
          ///
          public var type: String { __data["type"] }
          /// A list of reference objects if the metafield's type is a resource reference list.
          public var references: References? { __data["references"] }

          /// Products.Node.Metafield.References
          ///
          /// Parent Type: `MetafieldReferenceConnection`
          public struct References: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetafieldReferenceConnection }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("edges", [Edge].self),
            ] }

            /// A list of edges.
            public var edges: [Edge] { __data["edges"] }

            /// Products.Node.Metafield.References.Edge
            ///
            /// Parent Type: `MetafieldReferenceEdge`
            public struct Edge: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetafieldReferenceEdge }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("node", Node.self),
              ] }

              /// The item at the end of MetafieldReferenceEdge.
              public var node: Node { __data["node"] }

              /// Products.Node.Metafield.References.Edge.Node
              ///
              /// Parent Type: `MetafieldReference`
              public struct Node: ShopifyAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Unions.MetafieldReference }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .inlineFragment(AsMetaobject.self),
                ] }

                public var asMetaobject: AsMetaobject? { _asInlineFragment() }

                /// Products.Node.Metafield.References.Edge.Node.AsMetaobject
                ///
                /// Parent Type: `Metaobject`
                public struct AsMetaobject: ShopifyAPI.InlineFragment {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public typealias RootEntityType = GetTrendingProductsQuery.Data.Products.Node.Metafield.References.Edge.Node
                  public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Metaobject }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("id", ShopifyAPI.ID.self),
                    .field("handle", String.self),
                    .field("type", String.self),
                    .field("updatedAt", ShopifyAPI.DateTime.self),
                    .field("field", alias: "product", Product?.self, arguments: ["key": "product"]),
                    .field("field", alias: "customerName", CustomerName?.self, arguments: ["key": "customer_name"]),
                    .field("field", alias: "rating", Rating?.self, arguments: ["key": "rating"]),
                    .field("field", alias: "title", Title?.self, arguments: ["key": "title"]),
                    .field("field", alias: "body", Body?.self, arguments: ["key": "body"]),
                    .field("field", alias: "createdAt", CreatedAt?.self, arguments: ["key": "created_at"]),
                    .field("field", alias: "approved", Approved?.self, arguments: ["key": "approved"]),
                  ] }

                  /// A globally-unique ID.
                  public var id: ShopifyAPI.ID { __data["id"] }
                  /// The unique handle of the metaobject. Useful as a custom ID.
                  public var handle: String { __data["handle"] }
                  /// The type of the metaobject.
                  public var type: String { __data["type"] }
                  /// The date and time when the metaobject was last updated.
                  public var updatedAt: ShopifyAPI.DateTime { __data["updatedAt"] }
                  /// Accesses a field of the object by key.
                  public var product: Product? { __data["product"] }
                  /// Accesses a field of the object by key.
                  public var customerName: CustomerName? { __data["customerName"] }
                  /// Accesses a field of the object by key.
                  public var rating: Rating? { __data["rating"] }
                  /// Accesses a field of the object by key.
                  public var title: Title? { __data["title"] }
                  /// Accesses a field of the object by key.
                  public var body: Body? { __data["body"] }
                  /// Accesses a field of the object by key.
                  public var createdAt: CreatedAt? { __data["createdAt"] }
                  /// Accesses a field of the object by key.
                  public var approved: Approved? { __data["approved"] }

                  /// Products.Node.Metafield.References.Edge.Node.AsMetaobject.Product
                  ///
                  /// Parent Type: `MetaobjectField`
                  public struct Product: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetaobjectField }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("key", String.self),
                      .field("type", String.self),
                      .field("value", String?.self),
                    ] }

                    /// The field key.
                    public var key: String { __data["key"] }
                    /// The type name of the field.
                    /// See the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
                    ///
                    public var type: String { __data["type"] }
                    /// The field value.
                    public var value: String? { __data["value"] }
                  }

                  /// Products.Node.Metafield.References.Edge.Node.AsMetaobject.CustomerName
                  ///
                  /// Parent Type: `MetaobjectField`
                  public struct CustomerName: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetaobjectField }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("key", String.self),
                      .field("type", String.self),
                      .field("value", String?.self),
                    ] }

                    /// The field key.
                    public var key: String { __data["key"] }
                    /// The type name of the field.
                    /// See the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
                    ///
                    public var type: String { __data["type"] }
                    /// The field value.
                    public var value: String? { __data["value"] }
                  }

                  /// Products.Node.Metafield.References.Edge.Node.AsMetaobject.Rating
                  ///
                  /// Parent Type: `MetaobjectField`
                  public struct Rating: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetaobjectField }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("key", String.self),
                      .field("type", String.self),
                      .field("value", String?.self),
                    ] }

                    /// The field key.
                    public var key: String { __data["key"] }
                    /// The type name of the field.
                    /// See the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
                    ///
                    public var type: String { __data["type"] }
                    /// The field value.
                    public var value: String? { __data["value"] }
                  }

                  /// Products.Node.Metafield.References.Edge.Node.AsMetaobject.Title
                  ///
                  /// Parent Type: `MetaobjectField`
                  public struct Title: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetaobjectField }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("key", String.self),
                      .field("type", String.self),
                      .field("value", String?.self),
                    ] }

                    /// The field key.
                    public var key: String { __data["key"] }
                    /// The type name of the field.
                    /// See the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
                    ///
                    public var type: String { __data["type"] }
                    /// The field value.
                    public var value: String? { __data["value"] }
                  }

                  /// Products.Node.Metafield.References.Edge.Node.AsMetaobject.Body
                  ///
                  /// Parent Type: `MetaobjectField`
                  public struct Body: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetaobjectField }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("key", String.self),
                      .field("type", String.self),
                      .field("value", String?.self),
                    ] }

                    /// The field key.
                    public var key: String { __data["key"] }
                    /// The type name of the field.
                    /// See the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
                    ///
                    public var type: String { __data["type"] }
                    /// The field value.
                    public var value: String? { __data["value"] }
                  }

                  /// Products.Node.Metafield.References.Edge.Node.AsMetaobject.CreatedAt
                  ///
                  /// Parent Type: `MetaobjectField`
                  public struct CreatedAt: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetaobjectField }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("key", String.self),
                      .field("type", String.self),
                      .field("value", String?.self),
                    ] }

                    /// The field key.
                    public var key: String { __data["key"] }
                    /// The type name of the field.
                    /// See the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
                    ///
                    public var type: String { __data["type"] }
                    /// The field value.
                    public var value: String? { __data["value"] }
                  }

                  /// Products.Node.Metafield.References.Edge.Node.AsMetaobject.Approved
                  ///
                  /// Parent Type: `MetaobjectField`
                  public struct Approved: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MetaobjectField }
                    public static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("key", String.self),
                      .field("type", String.self),
                      .field("value", String?.self),
                    ] }

                    /// The field key.
                    public var key: String { __data["key"] }
                    /// The type name of the field.
                    /// See the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
                    ///
                    public var type: String { __data["type"] }
                    /// The field value.
                    public var value: String? { __data["value"] }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
