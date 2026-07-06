// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateCustomerAddressMutation: GraphQLMutation {
  public static let operationName: String = "UpdateCustomerAddress"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCustomerAddress($customerAccessToken: String!, $id: ID!, $address: MailingAddressInput!) { customerAddressUpdate( customerAccessToken: $customerAccessToken id: $id address: $address ) { __typename customerAddress { __typename id address1 address2 city province zip country firstName lastName phone } customerUserErrors { __typename code message } } }"#
    ))

  public var customerAccessToken: String
  public var id: ID
  public var address: MailingAddressInput

  public init(
    customerAccessToken: String,
    id: ID,
    address: MailingAddressInput
  ) {
    self.customerAccessToken = customerAccessToken
    self.id = id
    self.address = address
  }

  public var __variables: Variables? { [
    "customerAccessToken": customerAccessToken,
    "id": id,
    "address": address
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerAddressUpdate", CustomerAddressUpdate?.self, arguments: [
        "customerAccessToken": .variable("customerAccessToken"),
        "id": .variable("id"),
        "address": .variable("address")
      ]),
    ] }

    /// Updates an existing [`MailingAddress`](https://shopify.dev/docs/api/storefront/current/objects/MailingAddress) for a [`Customer`](https://shopify.dev/docs/api/storefront/current/objects/Customer). Requires a [customer access token](https://shopify.dev/docs/api/storefront/current/mutations/customerAddressUpdate#arguments-customerAccessToken) to identify the customer, an ID to specify which address to modify, and an [`address`](https://shopify.dev/docs/api/storefront/current/input-objects/MailingAddressInput) with the updated fields.
    ///
    /// Successful update returns the updated [`MailingAddress`](https://shopify.dev/docs/api/storefront/current/objects/MailingAddress).
    ///
    public var customerAddressUpdate: CustomerAddressUpdate? { __data["customerAddressUpdate"] }

    /// CustomerAddressUpdate
    ///
    /// Parent Type: `CustomerAddressUpdatePayload`
    public struct CustomerAddressUpdate: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CustomerAddressUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customerAddress", CustomerAddress?.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The customer’s updated mailing address.
      public var customerAddress: CustomerAddress? { __data["customerAddress"] }
      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerAddressUpdate.CustomerAddress
      ///
      /// Parent Type: `MailingAddress`
      public struct CustomerAddress: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MailingAddress }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("address1", String?.self),
          .field("address2", String?.self),
          .field("city", String?.self),
          .field("province", String?.self),
          .field("zip", String?.self),
          .field("country", String?.self),
          .field("firstName", String?.self),
          .field("lastName", String?.self),
          .field("phone", String?.self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The first line of the address. Typically the street address or PO Box number.
        public var address1: String? { __data["address1"] }
        /// The second line of the address. Typically the number of the apartment, suite, or unit.
        ///
        public var address2: String? { __data["address2"] }
        /// The name of the city, district, village, or town.
        public var city: String? { __data["city"] }
        /// The region of the address, such as the province, state, or district.
        public var province: String? { __data["province"] }
        /// The zip or postal code of the address.
        public var zip: String? { __data["zip"] }
        /// The name of the country.
        public var country: String? { __data["country"] }
        /// The first name of the customer.
        public var firstName: String? { __data["firstName"] }
        /// The last name of the customer.
        public var lastName: String? { __data["lastName"] }
        /// A unique phone number for the customer.
        ///
        /// Formatted using E.164 standard. For example, _+16135551111_.
        ///
        public var phone: String? { __data["phone"] }
      }

      /// CustomerAddressUpdate.CustomerUserError
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
