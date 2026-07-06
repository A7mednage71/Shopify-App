// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetSmartCollectionsQuery: GraphQLQuery {
  public static let operationName: String = "GetSmartCollections"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetSmartCollections($first: Int!) { collections(first: $first, query: "collection_type:smart") { __typename nodes { __typename id title handle image { __typename url altText } } } }"#
    ))

  public var first: Int

  public init(first: Int) {
    self.first = first
  }

  public var __variables: Variables? { ["first": first] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("collections", Collections.self, arguments: [
        "first": .variable("first"),
        "query": "collection_type:smart"
      ]),
    ] }

    /// Returns a paginated list of the shop's [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection). Each `Collection` object includes a nested connection to its [products](https://shopify.dev/docs/api/storefront/current/objects/Collection#field-Collection.fields.products).
    ///
    public var collections: Collections { __data["collections"] }

    /// Collections
    ///
    /// Parent Type: `CollectionConnection`
    public struct Collections: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CollectionConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("nodes", [Node].self),
      ] }

      /// A list of the nodes contained in CollectionEdge.
      public var nodes: [Node] { __data["nodes"] }

      /// Collections.Node
      ///
      /// Parent Type: `Collection`
      public struct Node: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Collection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("title", String.self),
          .field("handle", String.self),
          .field("image", Image?.self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The collection’s name. Limit of 255 characters.
        public var title: String { __data["title"] }
        /// A human-friendly unique string for the collection automatically generated from its title.
        /// Limit of 255 characters.
        ///
        public var handle: String { __data["handle"] }
        /// Image associated with the collection.
        public var image: Image? { __data["image"] }

        /// Collections.Node.Image
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
}
