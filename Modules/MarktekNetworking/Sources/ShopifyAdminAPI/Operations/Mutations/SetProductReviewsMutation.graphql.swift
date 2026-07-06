// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SetProductReviewsMutation: GraphQLMutation {
  public static let operationName: String = "SetProductReviews"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SetProductReviews($productId: ID!, $reviewIdsJson: String!) { metafieldsSet( metafields: [{ownerId: $productId, namespace: "reviews", key: "items", type: "list.metaobject_reference", value: $reviewIdsJson}] ) { __typename metafields { __typename id namespace key type value } userErrors { __typename field message code } } }"#
    ))

  public var productId: ID
  public var reviewIdsJson: String

  public init(
    productId: ID,
    reviewIdsJson: String
  ) {
    self.productId = productId
    self.reviewIdsJson = reviewIdsJson
  }

  public var __variables: Variables? { [
    "productId": productId,
    "reviewIdsJson": reviewIdsJson
  ] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("metafieldsSet", MetafieldsSet?.self, arguments: ["metafields": [[
        "ownerId": .variable("productId"),
        "namespace": "reviews",
        "key": "items",
        "type": "list.metaobject_reference",
        "value": .variable("reviewIdsJson")
      ]]]),
    ] }

    /// Sets metafield values. Metafield values will be set regardless if they were previously created or not.
    ///
    /// Allows a maximum of 25 metafields to be set at a time, with a maximum total request payload size of 10MB.
    ///
    /// This operation is atomic, meaning no changes are persisted if an error is encountered.
    ///
    /// As of `2024-07`, this operation supports compare-and-set functionality to better handle concurrent requests.
    /// If `compareDigest` is set for any metafield, the mutation will only set that metafield if the persisted metafield value matches the digest used on `compareDigest`.
    /// If the metafield doesn't exist yet, but you want to guarantee that the operation will run in a safe manner, set `compareDigest` to `null`.
    /// The `compareDigest` value can be acquired by querying the metafield object and selecting `compareDigest` as a field.
    /// If the `compareDigest` value does not match the digest for the persisted value, the mutation will return an error.
    /// You can opt out of write guarantees by not sending `compareDigest` in the request.
    public var metafieldsSet: MetafieldsSet? { __data["metafieldsSet"] }

    /// MetafieldsSet
    ///
    /// Parent Type: `MetafieldsSetPayload`
    public struct MetafieldsSet: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MetafieldsSetPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("metafields", [Metafield]?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The list of metafields that were set.
      public var metafields: [Metafield]? { __data["metafields"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// MetafieldsSet.Metafield
      ///
      /// Parent Type: `Metafield`
      public struct Metafield: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Metafield }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAdminAPI.ID.self),
          .field("namespace", String.self),
          .field("key", String.self),
          .field("type", String.self),
          .field("value", String.self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAdminAPI.ID { __data["id"] }
        /// The container for a group of metafields that the metafield is associated with.
        public var namespace: String { __data["namespace"] }
        /// The unique identifier for the metafield within its namespace.
        public var key: String { __data["key"] }
        /// The type of data that's stored in the metafield.
        /// Refer to the list of [supported types](https://shopify.dev/apps/metafields/types).
        public var type: String { __data["type"] }
        /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
        public var value: String { __data["value"] }
      }

      /// MetafieldsSet.UserError
      ///
      /// Parent Type: `MetafieldsSetUserError`
      public struct UserError: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MetafieldsSetUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("field", [String]?.self),
          .field("message", String.self),
          .field("code", GraphQLEnum<ShopifyAdminAPI.MetafieldsSetUserErrorCode>?.self),
        ] }

        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
        /// The error code.
        public var code: GraphQLEnum<ShopifyAdminAPI.MetafieldsSetUserErrorCode>? { __data["code"] }
      }
    }
  }
}
