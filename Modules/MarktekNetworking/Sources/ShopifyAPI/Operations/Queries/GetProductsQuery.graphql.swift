// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetProductsQuery: GraphQLQuery {
  public static let operationName: String = "GetProducts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetProducts { products(first: 10) { __typename edges { __typename node { __typename id title handle } } } }"#
    ))

  public init() {}

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("products", Products.self, arguments: ["first": 10]),
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
        .field("edges", [Edge].self),
      ] }

      /// A list of edges.
      public var edges: [Edge] { __data["edges"] }

      /// Products.Edge
      ///
      /// Parent Type: `ProductEdge`
      public struct Edge: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.ProductEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
        ] }

        /// The item at the end of ProductEdge.
        public var node: Node { __data["node"] }

        /// Products.Edge.Node
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
        }
      }
    }
  }
}
