// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetProductQuery: GraphQLQuery {
  public static let operationName: String = "GetProduct"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetProduct($id: ID!) { product(id: $id) { __typename id title description descriptionHtml vendor productType tags availableForSale priceRange { __typename minVariantPrice { __typename amount currencyCode } maxVariantPrice { __typename amount currencyCode } } compareAtPriceRange { __typename minVariantPrice { __typename amount currencyCode } } images(first: 20) { __typename edges { __typename node { __typename id url altText width height } } } options { __typename id name values } variants(first: 30) { __typename edges { __typename node { __typename id title availableForSale quantityAvailable price { __typename amount currencyCode } compareAtPrice { __typename amount currencyCode } selectedOptions { __typename name value } image { __typename url altText } } } } metafields( identifiers: [ { namespace: "reviews", key: "rating" } { namespace: "reviews", key: "rating_count" } ] ) { __typename key namespace value type } } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("product", Product?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Retrieves a single [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product) by its ID or handle. Use this query to build product detail pages, access variant and pricing information, or fetch product media and [metafields](https://shopify.dev/docs/api/storefront/current/objects/Metafield). See some [examples of querying products](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/getting-started).
    ///
    public var product: Product? { __data["product"] }

    /// Product
    ///
    /// Parent Type: `Product`
    public struct Product: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Product }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", ShopifyAPI.ID.self),
        .field("title", String.self),
        .field("description", String.self),
        .field("descriptionHtml", ShopifyAPI.HTML.self),
        .field("vendor", String.self),
        .field("productType", String.self),
        .field("tags", [String].self),
        .field("availableForSale", Bool.self),
        .field("priceRange", PriceRange.self),
        .field("compareAtPriceRange", CompareAtPriceRange.self),
        .field("images", Images.self, arguments: ["first": 20]),
        .field("options", [Option].self),
        .field("variants", Variants.self, arguments: ["first": 30]),
        .field("metafields", [Metafield?].self, arguments: ["identifiers": [[
          "namespace": "reviews",
          "key": "rating"
        ], [
          "namespace": "reviews",
          "key": "rating_count"
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
      /// The description of the product, with
      /// HTML tags. For example, the description might include
      /// bold `<strong></strong>` and italic `<i></i>` text.
      ///
      public var descriptionHtml: ShopifyAPI.HTML { __data["descriptionHtml"] }
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
      /// The minimum and maximum prices of a product, expressed in decimal numbers.
      /// For example, if the product is priced between $10.00 and $50.00,
      /// then the price range is $10.00 - $50.00.
      ///
      public var priceRange: PriceRange { __data["priceRange"] }
      /// The [compare-at price range](https://help.shopify.com/manual/products/details/product-pricing/sale-pricing) of the product in the shop's default currency.
      public var compareAtPriceRange: CompareAtPriceRange { __data["compareAtPriceRange"] }
      /// List of images associated with the product.
      public var images: Images { __data["images"] }
      /// A list of product options. The limit is defined by the [shop's resource limits for product options](/docs/api/admin-graphql/latest/objects/Shop#field-resourcelimits) (`Shop.resourceLimits.maxProductOptions`).
      public var options: [Option] { __data["options"] }
      /// A list of [variants](/docs/api/storefront/latest/objects/ProductVariant) that are associated with the product.
      public var variants: Variants { __data["variants"] }
      /// A list of [custom fields](/docs/apps/build/custom-data) that a merchant associates with a Shopify resource.
      public var metafields: [Metafield?] { __data["metafields"] }

      /// Product.PriceRange
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

        /// Product.PriceRange.MinVariantPrice
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

        /// Product.PriceRange.MaxVariantPrice
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

      /// Product.CompareAtPriceRange
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

        /// Product.CompareAtPriceRange.MinVariantPrice
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

      /// Product.Images
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

        /// Product.Images.Edge
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

          /// Product.Images.Edge.Node
          ///
          /// Parent Type: `Image`
          public struct Node: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Image }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", ShopifyAPI.ID?.self),
              .field("url", ShopifyAPI.URL.self),
              .field("altText", String?.self),
              .field("width", Int?.self),
              .field("height", Int?.self),
            ] }

            /// A unique ID for the image.
            public var id: ShopifyAPI.ID? { __data["id"] }
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
            /// The original width of the image in pixels. Returns `null` if the image isn't hosted by Shopify.
            public var width: Int? { __data["width"] }
            /// The original height of the image in pixels. Returns `null` if the image isn't hosted by Shopify.
            public var height: Int? { __data["height"] }
          }
        }
      }

      /// Product.Option
      ///
      /// Parent Type: `ProductOption`
      public struct Option: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductOption }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("name", String.self),
          .field("values", [String].self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The product option’s name.
        public var name: String { __data["name"] }
        /// The corresponding value to the product option name.
        @available(*, deprecated, message: "Use `optionValues` instead.")
        public var values: [String] { __data["values"] }
      }

      /// Product.Variants
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

        /// Product.Variants.Edge
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

          /// Product.Variants.Edge.Node
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
              .field("quantityAvailable", Int?.self),
              .field("price", Price.self),
              .field("compareAtPrice", CompareAtPrice?.self),
              .field("selectedOptions", [SelectedOption].self),
              .field("image", Image?.self),
            ] }

            /// A globally-unique ID.
            public var id: ShopifyAPI.ID { __data["id"] }
            /// The product variant’s title.
            public var title: String { __data["title"] }
            /// Indicates if the product variant is available for sale.
            public var availableForSale: Bool { __data["availableForSale"] }
            /// The total sellable quantity of the variant for online sales channels.
            public var quantityAvailable: Int? { __data["quantityAvailable"] }
            /// The product variant’s price.
            public var price: Price { __data["price"] }
            /// The compare at price of the variant. This can be used to mark a variant as on sale, when `compareAtPrice` is higher than `price`.
            public var compareAtPrice: CompareAtPrice? { __data["compareAtPrice"] }
            /// List of product options applied to the variant.
            public var selectedOptions: [SelectedOption] { __data["selectedOptions"] }
            /// Image associated with the product variant. This field falls back to the product image if no image is available.
            public var image: Image? { __data["image"] }

            /// Product.Variants.Edge.Node.Price
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

            /// Product.Variants.Edge.Node.CompareAtPrice
            ///
            /// Parent Type: `MoneyV2`
            public struct CompareAtPrice: ShopifyAPI.SelectionSet {
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

            /// Product.Variants.Edge.Node.SelectedOption
            ///
            /// Parent Type: `SelectedOption`
            public struct SelectedOption: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.SelectedOption }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("name", String.self),
                .field("value", String.self),
              ] }

              /// The product option’s name.
              public var name: String { __data["name"] }
              /// The product option’s value.
              public var value: String { __data["value"] }
            }

            /// Product.Variants.Edge.Node.Image
            ///
            /// Parent Type: `Image`
            public struct Image: ShopifyAPI.SelectionSet {
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
      }

      /// Product.Metafield
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
      }
    }
  }
}
