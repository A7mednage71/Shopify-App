// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCollectionsQuery: GraphQLQuery {
  public static let operationName: String = "GetCollections"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCollections($first: Int!) { collections(first: $first) { __typename nodes { __typename id title handle image { __typename url altText } } } }"#
    ))

  public var first: Int

  public init(first: Int = 10) {
    self.first = first
  }

  public var __variables: Variables? { ["first": first] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("collections", Collections.self, arguments: ["first": .variable("first")]),
    ] }

    public var collections: Collections { __data["collections"] }

    /// Collections
    ///
    /// Parent Type: `CollectionConnection`
    public struct Collections: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Collection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("nodes", [Node].self),
      ] }

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

        public var id: ShopifyAPI.ID { __data["id"] }
        public var title: String { __data["title"] }
        public var handle: String { __data["handle"] }
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

          public var url: ShopifyAPI.URL { __data["url"] }
          public var altText: String? { __data["altText"] }
        }
      }
    }
  }
}
