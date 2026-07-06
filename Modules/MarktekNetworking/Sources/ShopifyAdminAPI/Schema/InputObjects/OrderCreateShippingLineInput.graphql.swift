// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a shipping line to create for an order.
public struct OrderCreateShippingLineInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    code: GraphQLNullable<String> = nil,
    priceSet: MoneyBagInput,
    source: GraphQLNullable<String> = nil,
    taxLines: GraphQLNullable<[OrderCreateTaxLineInput]> = nil,
    title: String
  ) {
    __data = InputDict([
      "code": code,
      "priceSet": priceSet,
      "source": source,
      "taxLines": taxLines,
      "title": title
    ])
  }

  /// A reference to the shipping method.
  public var code: GraphQLNullable<String> {
    get { __data["code"] }
    set { __data["code"] = newValue }
  }

  /// The price of this shipping method in the shop currency. Can't be negative.
  public var priceSet: MoneyBagInput {
    get { __data["priceSet"] }
    set { __data["priceSet"] = newValue }
  }

  /// The source of the shipping method.
  public var source: GraphQLNullable<String> {
    get { __data["source"] }
    set { __data["source"] = newValue }
  }

  /// A list of tax line objects, each of which details a tax applicable to this shipping line.
  public var taxLines: GraphQLNullable<[OrderCreateTaxLineInput]> {
    get { __data["taxLines"] }
    set { __data["taxLines"] = newValue }
  }

  /// The title of the shipping method.
  public var title: String {
    get { __data["title"] }
    set { __data["title"] = newValue }
  }
}
