// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateCustomerDefaultAddressMutation: GraphQLMutation {
  public static let operationName: String = "UpdateCustomerDefaultAddress"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCustomerDefaultAddress($customerAccessToken: String!, $addressId: ID!) { customerDefaultAddressUpdate( customerAccessToken: $customerAccessToken addressId: $addressId ) { __typename customer { __typename id defaultAddress { __typename id } } customerUserErrors { __typename code message } } }"#
    ))

  public var customerAccessToken: String
  public var addressId: ID

  public init(
    customerAccessToken: String,
    addressId: ID
  ) {
    self.customerAccessToken = customerAccessToken
    self.addressId = addressId
  }

  public var __variables: Variables? { [
    "customerAccessToken": customerAccessToken,
    "addressId": addressId
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerDefaultAddressUpdate", CustomerDefaultAddressUpdate?.self, arguments: [
        "customerAccessToken": .variable("customerAccessToken"),
        "addressId": .variable("addressId")
      ]),
    ] }

    /// Updates the default address of an existing [`Customer`](https://shopify.dev/docs/api/storefront/current/objects/Customer). Requires a [customer access token](https://shopify.dev/docs/api/storefront/current/mutations/customerDefaultAddressUpdate#arguments-customerAccessToken) to identify the customer and an address ID to specify which address to set as the new default.
    ///
    public var customerDefaultAddressUpdate: CustomerDefaultAddressUpdate? { __data["customerDefaultAddressUpdate"] }

    /// CustomerDefaultAddressUpdate
    ///
    /// Parent Type: `CustomerDefaultAddressUpdatePayload`
    public struct CustomerDefaultAddressUpdate: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CustomerDefaultAddressUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customer", Customer?.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The updated customer object.
      public var customer: Customer? { __data["customer"] }
      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerDefaultAddressUpdate.Customer
      ///
      /// Parent Type: `Customer`
      public struct Customer: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Customer }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("defaultAddress", DefaultAddress?.self),
        ] }

        /// A unique ID for the customer.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The customer’s default address.
        public var defaultAddress: DefaultAddress? { __data["defaultAddress"] }

        /// CustomerDefaultAddressUpdate.Customer.DefaultAddress
        ///
        /// Parent Type: `MailingAddress`
        public struct DefaultAddress: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MailingAddress }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAPI.ID.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
        }
      }

      /// CustomerDefaultAddressUpdate.CustomerUserError
      ///
      /// Parent Type: `CustomerUserError`
      public struct CustomerUserError: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CustomerUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLEnum<ShopifyAPI.CustomerErrorCode>?.self),
          .field("message", String.self),
        ] }

        /// The error code.
        public var code: GraphQLEnum<ShopifyAPI.CustomerErrorCode>? { __data["code"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
