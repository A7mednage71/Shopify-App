// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a discount code to apply to an order. Only one type of discount can be applied to an order.
public struct OrderCreateDiscountCodeInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    itemPercentageDiscountCode: GraphQLNullable<OrderCreatePercentageDiscountCodeAttributesInput> = nil,
    itemFixedDiscountCode: GraphQLNullable<OrderCreateFixedDiscountCodeAttributesInput> = nil,
    freeShippingDiscountCode: GraphQLNullable<OrderCreateFreeShippingDiscountCodeAttributesInput> = nil
  ) {
    __data = InputDict([
      "itemPercentageDiscountCode": itemPercentageDiscountCode,
      "itemFixedDiscountCode": itemFixedDiscountCode,
      "freeShippingDiscountCode": freeShippingDiscountCode
    ])
  }

  /// A percentage discount code applied to the line items on the order.
  public var itemPercentageDiscountCode: GraphQLNullable<OrderCreatePercentageDiscountCodeAttributesInput> {
    get { __data["itemPercentageDiscountCode"] }
    set { __data["itemPercentageDiscountCode"] = newValue }
  }

  /// A fixed amount discount code applied to the line items on the order.
  public var itemFixedDiscountCode: GraphQLNullable<OrderCreateFixedDiscountCodeAttributesInput> {
    get { __data["itemFixedDiscountCode"] }
    set { __data["itemFixedDiscountCode"] = newValue }
  }

  /// A free shipping discount code applied to the shipping on an order.
  public var freeShippingDiscountCode: GraphQLNullable<OrderCreateFreeShippingDiscountCodeAttributesInput> {
    get { __data["freeShippingDiscountCode"] }
    set { __data["freeShippingDiscountCode"] = newValue }
  }
}
