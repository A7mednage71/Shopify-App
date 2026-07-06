// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateProductReviewMutation: GraphQLMutation {
  public static let operationName: String = "CreateProductReview"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateProductReview($metaobject: MetaobjectCreateInput!) { metaobjectCreate(metaobject: $metaobject) { __typename metaobject { __typename id handle type fields { __typename key type value } } userErrors { __typename field message code } } }"#
    ))

  public var metaobject: MetaobjectCreateInput

  public init(metaobject: MetaobjectCreateInput) {
    self.metaobject = metaobject
  }

  public var __variables: Variables? { ["metaobject": metaobject] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("metaobjectCreate", MetaobjectCreate?.self, arguments: ["metaobject": .variable("metaobject")]),
    ] }

    /// Creates a metaobject entry based on an existing [`MetaobjectDefinition`](https://shopify.dev/docs/api/admin-graphql/latest/objects/MetaobjectDefinition). The type must match a definition that already exists in the shop.
    ///
    /// Specify field values using key-value pairs that correspond to the field definitions. The mutation generates a unique handle automatically if you don't provide one. You can also configure capabilities like publishable status to control the metaobject's visibility across channels.
    ///
    /// Learn more about [managing metaobjects](https://shopify.dev/docs/apps/build/custom-data/metaobjects/manage-metaobjects).
    public var metaobjectCreate: MetaobjectCreate? { __data["metaobjectCreate"] }

    /// MetaobjectCreate
    ///
    /// Parent Type: `MetaobjectCreatePayload`
    public struct MetaobjectCreate: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MetaobjectCreatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("metaobject", Metaobject?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The created metaobject.
      public var metaobject: Metaobject? { __data["metaobject"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// MetaobjectCreate.Metaobject
      ///
      /// Parent Type: `Metaobject`
      public struct Metaobject: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Metaobject }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAdminAPI.ID.self),
          .field("handle", String.self),
          .field("type", String.self),
          .field("fields", [Field].self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAdminAPI.ID { __data["id"] }
        /// The unique handle of the object, useful as a custom ID.
        public var handle: String { __data["handle"] }
        /// The type of the metaobject.
        public var type: String { __data["type"] }
        /// All ordered fields of the metaobject with their definitions and values.
        public var fields: [Field] { __data["fields"] }

        /// MetaobjectCreate.Metaobject.Field
        ///
        /// Parent Type: `MetaobjectField`
        public struct Field: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MetaobjectField }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("key", String.self),
            .field("type", String.self),
            .field("value", String?.self),
          ] }

          /// The object key of this field.
          public var key: String { __data["key"] }
          /// The type of the field.
          public var type: String { __data["type"] }
          /// The assigned field value, always stored as a string regardless of the field type.
          public var value: String? { __data["value"] }
        }
      }

      /// MetaobjectCreate.UserError
      ///
      /// Parent Type: `MetaobjectUserError`
      public struct UserError: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MetaobjectUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("field", [String]?.self),
          .field("message", String.self),
          .field("code", GraphQLEnum<ShopifyAdminAPI.MetaobjectUserErrorCode>?.self),
        ] }

        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
        /// The error code.
        public var code: GraphQLEnum<ShopifyAdminAPI.MetaobjectUserErrorCode>? { __data["code"] }
      }
    }
  }
}
