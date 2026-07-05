// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a line item to create for an order.
public struct OrderCreateLineItemInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    fulfillmentService: GraphQLNullable<String> = nil,
    giftCard: GraphQLNullable<Bool>,
    priceSet: GraphQLNullable<MoneyBagInput> = nil,
    productId: GraphQLNullable<ID> = nil,
    properties: GraphQLNullable<[OrderCreateLineItemPropertyInput]> = nil,
    quantity: Int,
    requiresShipping: GraphQLNullable<Bool>,
    sku: GraphQLNullable<String> = nil,
    taxLines: GraphQLNullable<[OrderCreateTaxLineInput]> = nil,
    taxable: GraphQLNullable<Bool>,
    title: GraphQLNullable<String> = nil,
    variantId: GraphQLNullable<ID> = nil,
    variantTitle: GraphQLNullable<String> = nil,
    vendor: GraphQLNullable<String> = nil,
    weight: GraphQLNullable<WeightInput> = nil
  ) {
    __data = InputDict([
      "fulfillmentService": fulfillmentService,
      "giftCard": giftCard,
      "priceSet": priceSet,
      "productId": productId,
      "properties": properties,
      "quantity": quantity,
      "requiresShipping": requiresShipping,
      "sku": sku,
      "taxLines": taxLines,
      "taxable": taxable,
      "title": title,
      "variantId": variantId,
      "variantTitle": variantTitle,
      "vendor": vendor,
      "weight": weight
    ])
  }

  /// The handle of a fulfillment service that stocks the product variant belonging to a line item.
  ///
  ///               This is a third-party fulfillment service in the following scenarios:
  ///
  ///               **Scenario 1**
  ///               - The product variant is stocked by a single fulfillment service.
  ///               - The [FulfillmentService](/api/admin-graphql/latest/objects/FulfillmentService) is a third-party fulfillment service. Third-party fulfillment services don't have a handle with the value `manual`.
  ///
  ///               **Scenario 2**
  ///               - Multiple fulfillment services stock the product variant.
  ///               - The last time that the line item was unfulfilled, it was awaiting fulfillment by a third-party fulfillment service. Third-party fulfillment services don't have a handle with the value `manual`.
  ///
  ///               If none of the above conditions are met, then the fulfillment service has the `manual` handle.
  public var fulfillmentService: GraphQLNullable<String> {
    get { __data["fulfillmentService"] }
    set { __data["fulfillmentService"] = newValue }
  }

  /// Whether the item is a gift card. If true, then the item is not taxed or considered for shipping charges.
  public var giftCard: GraphQLNullable<Bool> {
    get { __data["giftCard"] }
    set { __data["giftCard"] = newValue }
  }

  /// The price of the item before discounts have been applied in the shop currency.
  public var priceSet: GraphQLNullable<MoneyBagInput> {
    get { __data["priceSet"] }
    set { __data["priceSet"] = newValue }
  }

  /// The ID of the product that the line item belongs to. Can be `null` if the original product associated with the order is deleted at a later date.
  public var productId: GraphQLNullable<ID> {
    get { __data["productId"] }
    set { __data["productId"] = newValue }
  }

  /// An array of custom information for the item that has been added to the cart. Often used to provide product customization options.
  public var properties: GraphQLNullable<[OrderCreateLineItemPropertyInput]> {
    get { __data["properties"] }
    set { __data["properties"] = newValue }
  }

  /// The number of items that were purchased.
  public var quantity: Int {
    get { __data["quantity"] }
    set { __data["quantity"] = newValue }
  }

  /// Whether the item requires shipping.
  public var requiresShipping: GraphQLNullable<Bool> {
    get { __data["requiresShipping"] }
    set { __data["requiresShipping"] = newValue }
  }

  /// The item's SKU (stock keeping unit).
  public var sku: GraphQLNullable<String> {
    get { __data["sku"] }
    set { __data["sku"] = newValue }
  }

  /// A list of tax line objects, each of which details a tax applied to the item.
  public var taxLines: GraphQLNullable<[OrderCreateTaxLineInput]> {
    get { __data["taxLines"] }
    set { __data["taxLines"] = newValue }
  }

  /// Whether the item was taxable.
  public var taxable: GraphQLNullable<Bool> {
    get { __data["taxable"] }
    set { __data["taxable"] = newValue }
  }

  /// The title of the product.
  public var title: GraphQLNullable<String> {
    get { __data["title"] }
    set { __data["title"] = newValue }
  }

  /// The ID of the product variant. If both `productId` and `variantId` are provided, then the product ID that corresponds to the `variantId` is used.
  public var variantId: GraphQLNullable<ID> {
    get { __data["variantId"] }
    set { __data["variantId"] = newValue }
  }

  /// The title of the product variant.
  public var variantTitle: GraphQLNullable<String> {
    get { __data["variantTitle"] }
    set { __data["variantTitle"] = newValue }
  }

  /// The name of the item's supplier.
  public var vendor: GraphQLNullable<String> {
    get { __data["vendor"] }
    set { __data["vendor"] = newValue }
  }

  /// The weight of the line item. This will take precedence over the weight of the product variant, if one was specified.
  public var weight: GraphQLNullable<WeightInput> {
    get { __data["weight"] }
    set { __data["weight"] = newValue }
  }
}
