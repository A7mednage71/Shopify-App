// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CustomerRegisterMutation: GraphQLMutation {
  public static let operationName: String = "CustomerRegister"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CustomerRegister($firstName: String!, $lastName: String!, $email: String!, $password: String!) { customerCreate( input: {firstName: $firstName, lastName: $lastName, email: $email, password: $password} ) { __typename customer { __typename id email firstName lastName } customerUserErrors { __typename code message } } }"#
    ))

  public var firstName: String
  public var lastName: String
  public var email: String
  public var password: String

  public init(
    firstName: String,
    lastName: String,
    email: String,
    password: String
  ) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
  }

  public var __variables: Variables? { [
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password
  ] }

  public struct Data: ShopifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("customerCreate", CustomerCreate?.self, arguments: ["input": [
        "firstName": .variable("firstName"),
        "lastName": .variable("lastName"),
        "email": .variable("email"),
        "password": .variable("password")
      ]]),
    ] }

    /// Creates a new [`Customer`](https://shopify.dev/docs/api/storefront/current/objects/Customer) account with the provided contact information and login credentials. The customer can then sign in for things such as accessing their account, viewing order history, and managing saved addresses.
    ///
    /// > Caution:
    /// > This mutation creates customer credentials. Ensure passwords are collected securely and never logged or exposed in client-side code.
    ///
    public var customerCreate: CustomerCreate? { __data["customerCreate"] }

    /// CustomerCreate
    ///
    /// Parent Type: `CustomerCreatePayload`
    public struct CustomerCreate: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAPI.Objects.CustomerCreatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("customer", Customer?.self),
        .field("customerUserErrors", [CustomerUserError].self),
      ] }

      /// The created customer object.
      public var customer: Customer? { __data["customer"] }
      /// The list of errors that occurred from executing the mutation.
      public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

      /// CustomerCreate.Customer
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
          .field("firstName", String?.self),
          .field("lastName", String?.self),
        ] }

        /// A unique ID for the customer.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The customer’s email address.
        public var email: String? { __data["email"] }
        /// The customer’s first name.
        public var firstName: String? { __data["firstName"] }
        /// The customer’s last name.
        public var lastName: String? { __data["lastName"] }
      }

      /// CustomerCreate.CustomerUserError
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
