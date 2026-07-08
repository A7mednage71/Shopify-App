// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateCustomerProfileMutation: GraphQLMutation {
  public static let operationName: String = "UpdateCustomerProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCustomerProfile($customerAccessToken: String!, $customer: CustomerUpdateInput!) { customerUpdate(customerAccessToken: $customerAccessToken, customer: $customer) { __typename customer { __typename id firstName lastName email phone createdAt } customerUserErrors { __typename code field message } } }"#
    ))

  public var customerAccessToken: String
  public var customer: CustomerUpdateInput

  public init(
    customerAccessToken: String,
    customer: CustomerUpdateInput
  ) {
    self.customerAccessToken = customerAccessToken
    self.customer = customer
  }

  public var __variables: Variables? { [
    "customerAccessToken": customerAccessToken,
    "customer": customer
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerUpdate", CustomerUpdate?.self, arguments: [
        "customerAccessToken": .variable("customerAccessToken"),
        "customer": .variable("customer")
      ]),
    ] }

    /// Updates a [customer's](https://shopify.dev/docs/api/storefront/current/objects/Customer) personal information such as name, password, and marketing preferences. Requires a valid [`CustomerAccessToken`](https://shopify.dev/docs/api/storefront/current/objects/CustomerAccessToken) to authenticate the customer making the update.
    ///
    /// If the customer's password is updated, then all previous access tokens become invalid. The mutation returns a new access token in the payload to maintain the customer's session.
    ///
    /// > Caution:
    /// > Password changes invalidate all existing access tokens. Ensure your app handles the new token returned in the response to avoid logging the customer out.
    ///
    public var customerUpdate: CustomerUpdate? { __data["customerUpdate"] }

    /// CustomerUpdate
    ///
    /// Parent Type: `CustomerUpdatePayload`
    public struct CustomerUpdate: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CustomerUpdatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customer", Customer?.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The updated customer object.
      public var customer: Customer? { __data["customer"] }
      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerUpdate.Customer
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

      /// CustomerUpdate.CustomerUserError
      ///
      /// Parent Type: `CustomerUserError`
      public struct CustomerUserError: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CustomerUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", GraphQLEnum<ShopifyAPI.CustomerErrorCode>?.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }

        /// The error code.
        public var code: GraphQLEnum<ShopifyAPI.CustomerErrorCode>? { __data["code"] }
        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
