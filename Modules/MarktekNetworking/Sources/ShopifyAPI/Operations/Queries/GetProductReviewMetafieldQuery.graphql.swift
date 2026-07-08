// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetProductReviewMetafieldQuery: GraphQLQuery {
  public static let operationName: String = "GetProductReviewMetafield"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetProductReviewMetafield($productId: ID!, $language: LanguageCode) @inContext(language: $language) { product(id: $productId) { __typename id metafield(namespace: "reviews", key: "items") { __typename key namespace value type } } }"#
    ))

  public var productId: ID
  public var language: GraphQLNullable<GraphQLEnum<LanguageCode>>

  public init(
    productId: ID,
    language: GraphQLNullable<GraphQLEnum<LanguageCode>>
  ) {
    self.productId = productId
    self.language = language
  }

  public var __variables: Variables? { [
    "productId": productId,
    "language": language
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("product", Product?.self, arguments: ["id": .variable("productId")]),
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
        .field("metafield", Metafield?.self, arguments: [
          "namespace": "reviews",
          "key": "items"
        ]),
      ] }

      /// A globally-unique ID.
      public var id: ShopifyAPI.ID { __data["id"] }
      /// A [custom field](https://shopify.dev/docs/apps/build/custom-data), including its `namespace` and `key`, that's associated with a Shopify resource for the purposes of adding and storing additional information.
      public var metafield: Metafield? { __data["metafield"] }

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
