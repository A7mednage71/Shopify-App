// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetDraftOrdersQuery: GraphQLQuery {
  public static let operationName: String = "GetDraftOrders"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetDraftOrders($first: Int) { draftOrders(first: $first) { __typename edges { __typename node { __typename id name totalPrice } } } }"#
    ))

  public var first: GraphQLNullable<Int>

  public init(first: GraphQLNullable<Int>) {
    self.first = first
  }

  public var __variables: Variables? { ["first": first] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("draftOrders", DraftOrders.self, arguments: ["first": .variable("first")]),
    ] }

    /// List of saved draft orders.
    public var draftOrders: DraftOrders { __data["draftOrders"] }

    /// DraftOrders
    ///
    /// Parent Type: `DraftOrderConnection`
    public struct DraftOrders: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge].self),
      ] }

      /// The connection between the node and its parent. Each edge contains a minimum of the edge's cursor and the node.
      public var edges: [Edge] { __data["edges"] }

      /// DraftOrders.Edge
      ///
      /// Parent Type: `DraftOrderEdge`
      public struct Edge: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrderEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
        ] }

        /// The item at the end of DraftOrderEdge.
        public var node: Node { __data["node"] }

        /// DraftOrders.Edge.Node
        ///
        /// Parent Type: `DraftOrder`
        public struct Node: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAdminAPI.ID.self),
            .field("name", String.self),
            .field("totalPrice", ShopifyAdminAPI.Money.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAdminAPI.ID { __data["id"] }
          /// The identifier for the draft order, which is unique within the store. For example, _#D1223_.
          public var name: String { __data["name"] }
          /// The total price, in shop currency, includes taxes, shipping charges, and discounts.
          @available(*, deprecated, message: "Use `totalPriceSet` instead.")
          public var totalPrice: ShopifyAdminAPI.Money { __data["totalPrice"] }
        }
      }
    }
  }
}
