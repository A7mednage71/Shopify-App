// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields used to include the address at which the fulfillment occurred. This input object is intended for tax purposes, as a full address is required for tax providers to accurately calculate taxes. Typically this is the address of the warehouse or fulfillment center. To retrieve a fulfillment location's address, use the `assignedLocation` field on the [`FulfillmentOrder`](/docs/api/admin-graphql/latest/objects/FulfillmentOrder) object instead.
public struct FulfillmentOriginAddressInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    address1: GraphQLNullable<String> = nil,
    address2: GraphQLNullable<String> = nil,
    city: GraphQLNullable<String> = nil,
    zip: GraphQLNullable<String> = nil,
    provinceCode: GraphQLNullable<String> = nil,
    countryCode: String
  ) {
    __data = InputDict([
      "address1": address1,
      "address2": address2,
      "city": city,
      "zip": zip,
      "provinceCode": provinceCode,
      "countryCode": countryCode
    ])
  }

  /// The street address of the fulfillment location.
  public var address1: GraphQLNullable<String> {
    get { __data["address1"] }
    set { __data["address1"] = newValue }
  }

  /// The second line of the address. Typically the number of the apartment, suite, or unit.
  public var address2: GraphQLNullable<String> {
    get { __data["address2"] }
    set { __data["address2"] = newValue }
  }

  /// The city in which the fulfillment location is located.
  public var city: GraphQLNullable<String> {
    get { __data["city"] }
    set { __data["city"] = newValue }
  }

  /// The zip code of the fulfillment location.
  public var zip: GraphQLNullable<String> {
    get { __data["zip"] }
    set { __data["zip"] = newValue }
  }

  /// The province of the fulfillment location.
  public var provinceCode: GraphQLNullable<String> {
    get { __data["provinceCode"] }
    set { __data["provinceCode"] = newValue }
  }

  /// The country of the fulfillment location.
  public var countryCode: String {
    get { __data["countryCode"] }
    set { __data["countryCode"] = newValue }
  }
}
