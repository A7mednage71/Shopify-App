// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SearchProductsQuery: GraphQLQuery {
  public static let operationName: String = "SearchProducts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query SearchProducts($query: String!, $first: Int!, $after: String, $language: LanguageCode) @inContext(language: $language) { search(query: $query, first: $first, after: $after, types: [PRODUCT]) { __typename totalCount edges { __typename cursor node { __typename ... on Product { id title description handle vendor productType tags availableForSale options { __typename name values } priceRange { __typename minVariantPrice { __typename amount currencyCode } maxVariantPrice { __typename amount currencyCode } } images(first: 1) { __typename edges { __typename node { __typename url altText } } } variants(first: 10) { __typename edges { __typename node { __typename id title availableForSale price { __typename amount currencyCode } } } } metafields(identifiers: [{namespace: "reviews", key: "items"}]) { __typename key namespace value type references(first: 100) { __typename edges { __typename node { __typename ... on Metaobject { id handle type updatedAt product: field(key: "product") { __typename key type value } customerName: field(key: "customer_name") { __typename key type value } rating: field(key: "rating") { __typename key type value } title: field(key: "title") { __typename key type value } body: field(key: "body") { __typename key type value } createdAt: field(key: "created_at") { __typename key type value } approved: field(key: "approved") { __typename key type value } } } } } } } } } pageInfo { __typename hasNextPage endCursor } } }"#
    ))

  public var query: String
  public var first: Int
  public var after: GraphQLNullable<String>
  public var language: GraphQLNullable<GraphQLEnum<LanguageCode>>

  public init(
    query: String,
    first: Int,
    after: GraphQLNullable<String>,
    language: GraphQLNullable<GraphQLEnum<LanguageCode>>
  ) {
    self.query = query
    self.first = first
    self.after = after
    self.language = language
  }

  public var __variables: Variables? { [
    "query": query,
    "first": first,
    "after": after,
    "language": language
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("search", Search.self, arguments: [
        "query": .variable("query"),
        "first": .variable("first"),
        "after": .variable("after"),
        "types": ["PRODUCT"]
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
        .field("edges", [Edge].self),
        .field("pageInfo", PageInfo.self),
      ] }

      /// The total number of results.
      public var totalCount: Int { __data["totalCount"] }
      /// A list of edges.
      public var edges: [Edge] { __data["edges"] }
      /// Information to aid in pagination.
      public var pageInfo: PageInfo { __data["pageInfo"] }

      /// Search.Edge
      ///
      /// Parent Type: `SearchResultItemEdge`
      public struct Edge: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.SearchResultItemEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cursor", String.self),
          .field("node", Node.self),
        ] }

        /// A cursor for use in pagination.
        public var cursor: String { __data["cursor"] }
        /// The item at the end of SearchResultItemEdge.
        public var node: Node { __data["node"] }

        /// Search.Edge.Node
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

          /// Search.Edge.Node.AsProduct
          ///
          /// Parent Type: `Product`
          public struct AsProduct: ShopifyAPI.InlineFragment {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public typealias RootEntityType = SearchProductsQuery.Data.Search.Edge.Node
            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Product }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("id", ShopifyAPI.ID.self),
              .field("title", String.self),
              .field("description", String.self),
              .field("handle", String.self),
              .field("vendor", String.self),
              .field("productType", String.self),
              .field("tags", [String].self),
              .field("availableForSale", Bool.self),
              .field("options", [Option].self),
              .field("priceRange", PriceRange.self),
              .field("images", Images.self, arguments: ["first": 1]),
              .field("variants", Variants.self, arguments: ["first": 10]),
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
            /// A single-line description of the product, with [HTML tags](https://developer.mozilla.org/en-US/docs/Web/HTML) removed.
            public var description: String { __data["description"] }
            /// A unique, human-readable string of the product's title.
            /// A handle can contain letters, hyphens (`-`), and numbers, but no spaces.
            /// The handle is used in the online store URL for the product.
            ///
            public var handle: String { __data["handle"] }
            /// The name of the product's vendor.
            public var vendor: String { __data["vendor"] }
            /// The [product type](https://help.shopify.com/manual/products/details/product-type)
            /// that merchants define.
            ///
            public var productType: String { __data["productType"] }
            /// A comma-separated list of searchable keywords that are
            /// associated with the product. For example, a merchant might apply the `sports`
            /// and `summer` tags to products that are associated with sportwear for summer.
            /// Updating `tags` overwrites any existing tags that were previously added to the product.
            /// To add new tags without overwriting existing tags,
            /// use the GraphQL Admin API's [`tagsAdd`](/docs/api/admin-graphql/latest/mutations/tagsadd)
            /// mutation.
            ///
            public var tags: [String] { __data["tags"] }
            /// Indicates if at least one product variant is available for sale.
            public var availableForSale: Bool { __data["availableForSale"] }
            /// A list of product options. The limit is defined by the [shop's resource limits for product options](/docs/api/admin-graphql/latest/objects/Shop#field-resourcelimits) (`Shop.resourceLimits.maxProductOptions`).
            public var options: [Option] { __data["options"] }
            /// The minimum and maximum prices of a product, expressed in decimal numbers.
            /// For example, if the product is priced between $10.00 and $50.00,
            /// then the price range is $10.00 - $50.00.
            ///
            public var priceRange: PriceRange { __data["priceRange"] }
            /// List of images associated with the product.
            public var images: Images { __data["images"] }
            /// A list of [variants](/docs/api/storefront/latest/objects/ProductVariant) that are associated with the product.
            public var variants: Variants { __data["variants"] }
            /// A list of [custom fields](/docs/apps/build/custom-data) that a merchant associates with a Shopify resource.
            public var metafields: [Metafield?] { __data["metafields"] }

            /// Search.Edge.Node.AsProduct.Option
            ///
            /// Parent Type: `ProductOption`
            public struct Option: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductOption }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("name", String.self),
                .field("values", [String].self),
              ] }

              /// The product option’s name.
              public var name: String { __data["name"] }
              /// The corresponding value to the product option name.
              @available(*, deprecated, message: "Use `optionValues` instead.")
              public var values: [String] { __data["values"] }
            }

            /// Search.Edge.Node.AsProduct.PriceRange
            ///
            /// Parent Type: `ProductPriceRange`
            public struct PriceRange: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductPriceRange }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("minVariantPrice", MinVariantPrice.self),
                .field("maxVariantPrice", MaxVariantPrice.self),
              ] }

              /// The lowest variant's price.
              public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }
              /// The highest variant's price.
              public var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }

              /// Search.Edge.Node.AsProduct.PriceRange.MinVariantPrice
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

              /// Search.Edge.Node.AsProduct.PriceRange.MaxVariantPrice
              ///
              /// Parent Type: `MoneyV2`
              public struct MaxVariantPrice: ShopifyAPI.SelectionSet {
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

            /// Search.Edge.Node.AsProduct.Images
            ///
            /// Parent Type: `ImageConnection`
            public struct Images: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ImageConnection }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("edges", [Edge].self),
              ] }

              /// A list of edges.
              public var edges: [Edge] { __data["edges"] }

              /// Search.Edge.Node.AsProduct.Images.Edge
              ///
              /// Parent Type: `ImageEdge`
              public struct Edge: ShopifyAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ImageEdge }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("node", Node.self),
                ] }

                /// The item at the end of ImageEdge.
                public var node: Node { __data["node"] }

                /// Search.Edge.Node.AsProduct.Images.Edge.Node
                ///
                /// Parent Type: `Image`
                public struct Node: ShopifyAPI.SelectionSet {
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
              }
            }

            /// Search.Edge.Node.AsProduct.Variants
            ///
            /// Parent Type: `ProductVariantConnection`
            public struct Variants: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariantConnection }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("edges", [Edge].self),
              ] }

              /// A list of edges.
              public var edges: [Edge] { __data["edges"] }

              /// Search.Edge.Node.AsProduct.Variants.Edge
              ///
              /// Parent Type: `ProductVariantEdge`
              public struct Edge: ShopifyAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariantEdge }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("node", Node.self),
                ] }

                /// The item at the end of ProductVariantEdge.
                public var node: Node { __data["node"] }

                /// Search.Edge.Node.AsProduct.Variants.Edge.Node
                ///
                /// Parent Type: `ProductVariant`
                public struct Node: ShopifyAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductVariant }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("id", ShopifyAPI.ID.self),
                    .field("title", String.self),
                    .field("availableForSale", Bool.self),
                    .field("price", Price.self),
                  ] }

                  /// A globally-unique ID.
                  public var id: ShopifyAPI.ID { __data["id"] }
                  /// The product variant’s title.
                  public var title: String { __data["title"] }
                  /// Indicates if the product variant is available for sale.
                  public var availableForSale: Bool { __data["availableForSale"] }
                  /// The product variant’s price.
                  public var price: Price { __data["price"] }

                  /// Search.Edge.Node.AsProduct.Variants.Edge.Node.Price
                  ///
                  /// Parent Type: `MoneyV2`
                  public struct Price: ShopifyAPI.SelectionSet {
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

            /// Search.Edge.Node.AsProduct.Metafield
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

              /// Search.Edge.Node.AsProduct.Metafield.References
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

                /// Search.Edge.Node.AsProduct.Metafield.References.Edge
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

                  /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node
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

                    /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject
                    ///
                    /// Parent Type: `Metaobject`
                    public struct AsMetaobject: ShopifyAPI.InlineFragment {
                      public let __data: DataDict
                      public init(_dataDict: DataDict) { __data = _dataDict }

                      public typealias RootEntityType = SearchProductsQuery.Data.Search.Edge.Node.AsProduct.Metafield.References.Edge.Node
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

                      /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject.Product
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

                      /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject.CustomerName
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

                      /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject.Rating
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

                      /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject.Title
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

                      /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject.Body
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

                      /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject.CreatedAt
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

                      /// Search.Edge.Node.AsProduct.Metafield.References.Edge.Node.AsMetaobject.Approved
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

      /// Search.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("hasNextPage", Bool.self),
          .field("endCursor", String?.self),
        ] }

        /// Whether there are more pages to fetch following the current page.
        public var hasNextPage: Bool { __data["hasNextPage"] }
        /// The cursor corresponding to the last node in edges.
        public var endCursor: String? { __data["endCursor"] }
      }
    }
  }
}
