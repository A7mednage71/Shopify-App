// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCustomerDetailsQuery: GraphQLQuery {
  public static let operationName: String = "GetCustomerDetails"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCustomerDetails($customerAccessToken: String!) { customer(customerAccessToken: $customerAccessToken) { __typename id email phone firstName lastName defaultAddress { __typename id address1 address2 city provinceCode countryCodeV2 zip phone company firstName lastName } } }"#
    ))

  public var customerAccessToken: String

  public init(customerAccessToken: String) {
    self.customerAccessToken = customerAccessToken
  }

  public var __variables: Variables? { ["customerAccessToken": customerAccessToken] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customer", Customer?.self, arguments: ["customerAccessToken": .variable("customerAccessToken")]),
    ] }

    /// Retrieves the [`Customer`](https://shopify.dev/docs/api/storefront/current/objects/Customer) associated with the provided access token. Use the [`customerAccessTokenCreate`](https://shopify.dev/docs/api/storefront/current/mutations/customerAccessTokenCreate) mutation to obtain an access token using legacy customer account authentication (email and password).
    ///
    /// The returned customer includes data such as contact information, [addresses](https://shopify.dev/docs/api/storefront/current/objects/MailingAddress), [orders](https://shopify.dev/docs/api/storefront/current/objects/Order), and [custom data](https://shopify.dev/docs/apps/build/custom-data) associated with the customer.
    ///
    public var customer: Customer? { __data["customer"] }

    /// Customer
    ///
    /// Parent Type: `Customer`
    public struct Customer: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Customer }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", ShopifyAPI.ID.self),
        .field("email", String?.self),
        .field("phone", String?.self),
        .field("firstName", String?.self),
        .field("lastName", String?.self),
        .field("defaultAddress", DefaultAddress?.self),
      ] }

      /// A unique ID for the customer.
      public var id: ShopifyAPI.ID { __data["id"] }
      /// The customer’s email address.
      public var email: String? { __data["email"] }
      /// The customer’s phone number.
      public var phone: String? { __data["phone"] }
      /// The customer’s first name.
      public var firstName: String? { __data["firstName"] }
      /// The customer’s last name.
      public var lastName: String? { __data["lastName"] }
      /// The customer’s default address.
      public var defaultAddress: DefaultAddress? { __data["defaultAddress"] }

      /// Customer.DefaultAddress
      ///
      /// Parent Type: `MailingAddress`
      public struct DefaultAddress: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.MailingAddress }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("address1", String?.self),
          .field("address2", String?.self),
          .field("city", String?.self),
          .field("provinceCode", String?.self),
          .field("countryCodeV2", GraphQLEnum<ShopifyAPI.CountryCode>?.self),
          .field("zip", String?.self),
          .field("phone", String?.self),
          .field("company", String?.self),
          .field("firstName", String?.self),
          .field("lastName", String?.self),
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
        /// The alphanumeric code for the region.
        ///
        /// For example, ON.
        ///
        public var provinceCode: String? { __data["provinceCode"] }
        /// The two-letter code for the country of the address.
        ///
        /// For example, US.
        ///
        public var countryCodeV2: GraphQLEnum<ShopifyAPI.CountryCode>? { __data["countryCodeV2"] }
        /// The zip or postal code of the address.
        public var zip: String? { __data["zip"] }
        /// A unique phone number for the customer.
        ///
        /// Formatted using E.164 standard. For example, _+16135551111_.
        ///
        public var phone: String? { __data["phone"] }
        /// The name of the customer's company or organization.
        public var company: String? { __data["company"] }
        /// The first name of the customer.
        public var firstName: String? { __data["firstName"] }
        /// The last name of the customer.
        public var lastName: String? { __data["lastName"] }
      }
    }
  }
}
