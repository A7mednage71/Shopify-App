// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a tax line to create for an order.
public struct OrderCreateTaxLineInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    channelLiable: GraphQLNullable<Bool>,
    priceSet: GraphQLNullable<MoneyBagInput> = nil,
    rate: Decimal,
    title: String
  ) {
    __data = InputDict([
      "channelLiable": channelLiable,
      "priceSet": priceSet,
      "rate": rate,
      "title": title
    ])
  }

  /// Whether the channel that submitted the tax line is liable for remitting. A value of `null` indicates unknown liability for the tax line.
  public var channelLiable: GraphQLNullable<Bool> {
    get { __data["channelLiable"] }
    set { __data["channelLiable"] = newValue }
  }

  /// The amount added to the order for this tax in shop and presentment currencies after discounts are applied.
  public var priceSet: GraphQLNullable<MoneyBagInput> {
    get { __data["priceSet"] }
    set { __data["priceSet"] = newValue }
  }

  /// The proportion of the item price that the tax represents as a decimal.
  public var rate: Decimal {
    get { __data["rate"] }
    set { __data["rate"] = newValue }
  }

  /// The name of the tax line to create.
  public var title: String {
    get { __data["title"] }
    set { __data["title"] = newValue }
  }
}
