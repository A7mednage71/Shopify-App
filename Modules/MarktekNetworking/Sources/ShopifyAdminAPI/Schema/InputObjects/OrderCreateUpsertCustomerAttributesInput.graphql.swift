// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for creating a new customer object or identifying an existing customer to update & associate with the order.
public struct OrderCreateUpsertCustomerAttributesInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    addresses: GraphQLNullable<[OrderCreateCustomerAddressInput]> = nil,
    email: GraphQLNullable<String> = nil,
    firstName: GraphQLNullable<String> = nil,
    id: GraphQLNullable<ID> = nil,
    lastName: GraphQLNullable<String> = nil,
    multipassIdentifier: GraphQLNullable<String> = nil,
    note: GraphQLNullable<String> = nil,
    phone: GraphQLNullable<String> = nil,
    tags: GraphQLNullable<[String]> = nil,
    taxExempt: GraphQLNullable<Bool> = nil
  ) {
    __data = InputDict([
      "addresses": addresses,
      "email": email,
      "firstName": firstName,
      "id": id,
      "lastName": lastName,
      "multipassIdentifier": multipassIdentifier,
      "note": note,
      "phone": phone,
      "tags": tags,
      "taxExempt": taxExempt
    ])
  }

  /// A list of addresses to associate with the customer.
  public var addresses: GraphQLNullable<[OrderCreateCustomerAddressInput]> {
    get { __data["addresses"] }
    set { __data["addresses"] = newValue }
  }

  /// The email address to update the customer with. If no `id` is provided, this is used to uniquely identify
  ///                  the customer.
  ///
  ///                 > Note:
  ///                 > If both this email input field and the email on `OrderCreateOrderInput` are provided, this field will
  ///                 > take precedence.
  public var email: GraphQLNullable<String> {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }

  /// The first name of the customer.
  public var firstName: GraphQLNullable<String> {
    get { __data["firstName"] }
    set { __data["firstName"] = newValue }
  }

  /// The id of the customer to associate to the order.
  public var id: GraphQLNullable<ID> {
    get { __data["id"] }
    set { __data["id"] = newValue }
  }

  /// The last name of the customer.
  public var lastName: GraphQLNullable<String> {
    get { __data["lastName"] }
    set { __data["lastName"] = newValue }
  }

  /// A unique identifier for the customer that's used with [Multipass login](https://shopify.dev/api/multipass).
  public var multipassIdentifier: GraphQLNullable<String> {
    get { __data["multipassIdentifier"] }
    set { __data["multipassIdentifier"] = newValue }
  }

  /// A note about the customer.
  public var note: GraphQLNullable<String> {
    get { __data["note"] }
    set { __data["note"] = newValue }
  }

  /// The unique phone number ([E.164 format](https://en.wikipedia.org/wiki/E.164)) for this customer.
  ///                  Attempting to assign the same phone number to multiple customers returns an error. The property can be
  ///                  set using different formats, but each format must represent a number that can be dialed from anywhere
  ///                  in the world. The following formats are all valid:
  ///                   - 6135551212
  ///                   - +16135551212
  ///                   - (613)555-1212
  ///                   - +1 613-555-1212
  public var phone: GraphQLNullable<String> {
    get { __data["phone"] }
    set { __data["phone"] = newValue }
  }

  /// Tags that the shop owner has attached to the customer. A customer can have up to 250 tags. Each tag can have up to 255 characters.
  public var tags: GraphQLNullable<[String]> {
    get { __data["tags"] }
    set { __data["tags"] = newValue }
  }

  /// Whether the customer is exempt from paying taxes on their order. If `true`, then taxes won't be applied to an order at checkout. If `false`, then taxes will be applied at checkout.
  public var taxExempt: GraphQLNullable<Bool> {
    get { __data["taxExempt"] }
    set { __data["taxExempt"] = newValue }
  }
}
