// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a fulfillment to create for an order.
public struct OrderCreateFulfillmentInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    locationId: ID,
    originAddress: GraphQLNullable<FulfillmentOriginAddressInput> = nil,
    notifyCustomer: GraphQLNullable<Bool>,
    shipmentStatus: GraphQLNullable<GraphQLEnum<FulfillmentEventStatus>> = nil,
    trackingNumber: GraphQLNullable<String> = nil,
    trackingCompany: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "locationId": locationId,
      "originAddress": originAddress,
      "notifyCustomer": notifyCustomer,
      "shipmentStatus": shipmentStatus,
      "trackingNumber": trackingNumber,
      "trackingCompany": trackingCompany
    ])
  }

  /// The ID of the location to fulfill the order from.
  public var locationId: ID {
    get { __data["locationId"] }
    set { __data["locationId"] = newValue }
  }

  /// The address at which the fulfillment occurred.
  public var originAddress: GraphQLNullable<FulfillmentOriginAddressInput> {
    get { __data["originAddress"] }
    set { __data["originAddress"] = newValue }
  }

  /// Whether the customer should be notified of changes with the fulfillment.
  public var notifyCustomer: GraphQLNullable<Bool> {
    get { __data["notifyCustomer"] }
    set { __data["notifyCustomer"] = newValue }
  }

  /// The status of the shipment.
  public var shipmentStatus: GraphQLNullable<GraphQLEnum<FulfillmentEventStatus>> {
    get { __data["shipmentStatus"] }
    set { __data["shipmentStatus"] = newValue }
  }

  /// The tracking number of the fulfillment.
  ///
  /// The tracking number will be clickable in the interface if one of the following applies
  /// (the highest in the list has the highest priority):
  ///
  /// * [Shopify-known tracking company name](https://shopify.dev/api/admin-graphql/latest/objects/FulfillmentTrackingInfo#supported-tracking-companies)
  ///   specified in the `company` field.
  ///   Shopify will build the tracking URL automatically based on the tracking number specified.
  /// * The tracking number has a Shopify-known format.
  ///   Shopify will guess the tracking provider and build the tracking url based on the tracking number format.
  ///   Not all tracking carriers are supported, and multiple tracking carriers may use similarly formatted tracking numbers.
  ///   This can result in an invalid tracking URL.
  public var trackingNumber: GraphQLNullable<String> {
    get { __data["trackingNumber"] }
    set { __data["trackingNumber"] = newValue }
  }

  /// The name of the tracking company.
  ///
  /// If you specify a tracking company name from
  /// [the list](https://shopify.dev/api/admin-graphql/latest/objects/FulfillmentTrackingInfo#supported-tracking-companies),
  /// Shopify will automatically build tracking URLs for all provided tracking numbers,
  /// which will make the tracking numbers clickable in the interface.
  /// The same tracking company will be applied to all tracking numbers specified.
  ///
  /// Additionally, for the tracking companies listed on the
  /// [Shipping Carriers help page](https://help.shopify.com/manual/shipping/understanding-shipping/shipping-carriers#integrated-shipping-carriers)
  /// Shopify will automatically update the fulfillment's `shipment_status` field during the fulfillment process.
  ///
  /// > Note:
  /// > Send the tracking company name exactly as written in
  /// > [the list](https://shopify.dev/api/admin-graphql/latest/objects/FulfillmentTrackingInfo#supported-tracking-companies)
  /// > (capitalization matters).
  public var trackingCompany: GraphQLNullable<String> {
    get { __data["trackingCompany"] }
    set { __data["trackingCompany"] = newValue }
  }
}
