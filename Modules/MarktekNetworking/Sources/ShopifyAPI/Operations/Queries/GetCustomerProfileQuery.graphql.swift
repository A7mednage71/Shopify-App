// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCustomerProfileQuery: GraphQLQuery {
  public static let operationName: String = "GetCustomerProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCustomerProfile($customerAccessToken: String!) { customer(customerAccessToken: $customerAccessToken) { __typename id firstName lastName email phone createdAt } }"#
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
        .field("firstName", String?.self),
        .field("lastName", String?.self),
        .field("email", String?.self),
        .field("phone", String?.self),
        .field("createdAt", ShopifyAPI.DateTime.self),
      ] }

      /// A unique ID for the customer.
      public var id: ShopifyAPI.ID { __data["id"] }
      /// The customer’s first name.
      public var firstName: String? { __data["firstName"] }
      /// The customer’s last name.
      public var lastName: String? { __data["lastName"] }
      /// The customer’s email address.
      public var email: String? { __data["email"] }
      /// The customer’s phone number.
      public var phone: String? { __data["phone"] }
      /// The date and time when the customer was created.
      public var createdAt: ShopifyAPI.DateTime { __data["createdAt"] }
    }
  }
}
