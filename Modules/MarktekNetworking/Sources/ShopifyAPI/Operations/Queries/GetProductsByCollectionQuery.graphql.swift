// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetProductsByCollectionQuery: GraphQLQuery {
  public static let operationName: String = "GetProductsByCollection"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetProductsByCollection($handle: String!, $first: Int!, $after: String) { collection(handle: $handle) { __typename products(first: $first, after: $after) { __typename edges { __typename cursor node { __typename id title description handle vendor productType tags availableForSale options { __typename name values } priceRange { __typename minVariantPrice { __typename amount currencyCode } maxVariantPrice { __typename amount currencyCode } } images(first: 1) { __typename edges { __typename node { __typename url altText } } } variants(first: 10) { __typename edges { __typename node { __typename id title availableForSale price { __typename amount currencyCode } } } } } } pageInfo { __typename hasNextPage endCursor } } } }"#
    ))

  public var handle: String
  public var first: Int
  public var after: GraphQLNullable<String>

  public init(
    handle: String,
    first: Int,
    after: GraphQLNullable<String>
  ) {
    self.handle = handle
    self.first = first
    self.after = after
  }

  public var __variables: Variables? { [
    "handle": handle,
    "first": first,
    "after": after
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("collection", Collection?.self, arguments: ["handle": .variable("handle")]),
    ] }

    /// Retrieves a single [`Collection`](https://shopify.dev/docs/api/storefront/current/objects/Collection) by its ID or handle. Use the [`products`](https://shopify.dev/docs/api/storefront/current/objects/Collection#field-Collection.fields.products) field to access items in the collection.
    ///
    public var collection: Collection? { __data["collection"] }

    /// Collection
    ///
    /// Parent Type: `Collection`
    public struct Collection: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Collection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("products", Products.self, arguments: [
          "first": .variable("first"),
          "after": .variable("after")
        ]),
      ] }

      /// List of products in the collection.
      public var products: Products { __data["products"] }

      /// Collection.Products
      ///
      /// Parent Type: `ProductConnection`
      public struct Products: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
          .field("pageInfo", PageInfo.self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }
        /// Information to aid in pagination.
        public var pageInfo: PageInfo { __data["pageInfo"] }

        /// Collection.Products.Edge
        ///
        /// Parent Type: `ProductEdge`
        public struct Edge: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("cursor", String.self),
            .field("node", Node.self),
          ] }

          /// A cursor for use in pagination.
          public var cursor: String { __data["cursor"] }
          /// The item at the end of ProductEdge.
          public var node: Node { __data["node"] }

          /// Collection.Products.Edge.Node
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

            /// Collection.Products.Edge.Node.Option
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

            /// Collection.Products.Edge.Node.PriceRange
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

              /// Collection.Products.Edge.Node.PriceRange.MinVariantPrice
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

              /// Collection.Products.Edge.Node.PriceRange.MaxVariantPrice
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

            /// Collection.Products.Edge.Node.Images
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

              /// Collection.Products.Edge.Node.Images.Edge
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

                /// Collection.Products.Edge.Node.Images.Edge.Node
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

            /// Collection.Products.Edge.Node.Variants
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

              /// Collection.Products.Edge.Node.Variants.Edge
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

                /// Collection.Products.Edge.Node.Variants.Edge.Node
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

                  /// Collection.Products.Edge.Node.Variants.Edge.Node.Price
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
          }
        }

        /// Collection.Products.PageInfo
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
}
