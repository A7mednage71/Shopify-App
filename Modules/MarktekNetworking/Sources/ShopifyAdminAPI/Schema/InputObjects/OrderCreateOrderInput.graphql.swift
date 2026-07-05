// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for creating an order.
public struct OrderCreateOrderInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    billingAddress: GraphQLNullable<MailingAddressInput> = nil,
    buyerAcceptsMarketing: GraphQLNullable<Bool>,
    closedAt: GraphQLNullable<DateTime> = nil,
    companyLocationId: GraphQLNullable<ID> = nil,
    currency: GraphQLNullable<GraphQLEnum<CurrencyCode>> = nil,
    customAttributes: GraphQLNullable<[OrderCreateCustomAttributeInput]> = nil,
    customer: GraphQLNullable<OrderCreateCustomerInput> = nil,
    discountCode: GraphQLNullable<OrderCreateDiscountCodeInput> = nil,
    email: GraphQLNullable<String> = nil,
    financialStatus: GraphQLNullable<GraphQLEnum<OrderCreateFinancialStatus>> = nil,
    fulfillment: GraphQLNullable<OrderCreateFulfillmentInput> = nil,
    fulfillmentStatus: GraphQLNullable<GraphQLEnum<OrderCreateFulfillmentStatus>> = nil,
    lineItems: GraphQLNullable<[OrderCreateLineItemInput]> = nil,
    metafields: GraphQLNullable<[MetafieldInput]> = nil,
    name: GraphQLNullable<String> = nil,
    note: GraphQLNullable<String> = nil,
    phone: GraphQLNullable<String> = nil,
    poNumber: GraphQLNullable<String> = nil,
    presentmentCurrency: GraphQLNullable<GraphQLEnum<CurrencyCode>> = nil,
    processedAt: GraphQLNullable<DateTime> = nil,
    referringSite: GraphQLNullable<URL> = nil,
    shippingAddress: GraphQLNullable<MailingAddressInput> = nil,
    shippingLines: GraphQLNullable<[OrderCreateShippingLineInput]> = nil,
    sourceIdentifier: GraphQLNullable<String> = nil,
    sourceName: GraphQLNullable<String> = nil,
    sourceUrl: GraphQLNullable<URL> = nil,
    tags: GraphQLNullable<[String]> = nil,
    taxesIncluded: GraphQLNullable<Bool>,
    taxLines: GraphQLNullable<[OrderCreateTaxLineInput]> = nil,
    test: GraphQLNullable<Bool>,
    transactions: GraphQLNullable<[OrderCreateOrderTransactionInput]> = nil,
    userId: GraphQLNullable<ID> = nil
  ) {
    __data = InputDict([
      "billingAddress": billingAddress,
      "buyerAcceptsMarketing": buyerAcceptsMarketing,
      "closedAt": closedAt,
      "companyLocationId": companyLocationId,
      "currency": currency,
      "customAttributes": customAttributes,
      "customer": customer,
      "discountCode": discountCode,
      "email": email,
      "financialStatus": financialStatus,
      "fulfillment": fulfillment,
      "fulfillmentStatus": fulfillmentStatus,
      "lineItems": lineItems,
      "metafields": metafields,
      "name": name,
      "note": note,
      "phone": phone,
      "poNumber": poNumber,
      "presentmentCurrency": presentmentCurrency,
      "processedAt": processedAt,
      "referringSite": referringSite,
      "shippingAddress": shippingAddress,
      "shippingLines": shippingLines,
      "sourceIdentifier": sourceIdentifier,
      "sourceName": sourceName,
      "sourceUrl": sourceUrl,
      "tags": tags,
      "taxesIncluded": taxesIncluded,
      "taxLines": taxLines,
      "test": test,
      "transactions": transactions,
      "userId": userId
    ])
  }

  /// The mailing address associated with the payment method. This address is an optional field that won't be
  ///                available on orders that don't require a payment method.
  ///
  ///               > Note:
  ///               > If a customer is provided, this field or `shipping_address` (which has precedence) will be set as the
  ///               > customer's default address. Additionally, if the provided customer is new or hasn't created an order yet
  ///               > then their name will be set to the first/last name from this address (if provided).
  public var billingAddress: GraphQLNullable<MailingAddressInput> {
    get { __data["billingAddress"] }
    set { __data["billingAddress"] = newValue }
  }

  /// Whether the customer consented to receive email updates from the shop.
  public var buyerAcceptsMarketing: GraphQLNullable<Bool> {
    get { __data["buyerAcceptsMarketing"] }
    set { __data["buyerAcceptsMarketing"] = newValue }
  }

  /// The date and time ([ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format) when the order was closed. Returns null if the order isn't closed.
  public var closedAt: GraphQLNullable<DateTime> {
    get { __data["closedAt"] }
    set { __data["closedAt"] = newValue }
  }

  /// The ID of the purchasing company's location for the order.
  public var companyLocationId: GraphQLNullable<ID> {
    get { __data["companyLocationId"] }
    set { __data["companyLocationId"] = newValue }
  }

  /// The shop-facing currency for the order. If not specified, then the shop's default currency is used.
  public var currency: GraphQLNullable<GraphQLEnum<CurrencyCode>> {
    get { __data["currency"] }
    set { __data["currency"] = newValue }
  }

  /// A list of extra information that's added to the order. Appears in the **Additional details** section of an order details page.
  public var customAttributes: GraphQLNullable<[OrderCreateCustomAttributeInput]> {
    get { __data["customAttributes"] }
    set { __data["customAttributes"] = newValue }
  }

  /// The customer to associate to the order.
  public var customer: GraphQLNullable<OrderCreateCustomerInput> {
    get { __data["customer"] }
    set { __data["customer"] = newValue }
  }

  /// A discount code applied to the order.
  public var discountCode: GraphQLNullable<OrderCreateDiscountCodeInput> {
    get { __data["discountCode"] }
    set { __data["discountCode"] = newValue }
  }

  /// A new customer email address for the order.
  ///
  ///               > Note:
  ///               > If a customer is provided, and no email is provided, the customer's email will be set to this field.
  public var email: GraphQLNullable<String> {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }

  /// The financial status of the order. If not specified, then this will be derived through the given transactions. Note that it's possible to specify a status that doesn't match the given transactions and it will persist, but if an operation later occurs on the order, the status may then be recalculated to match the current state of transactions.
  public var financialStatus: GraphQLNullable<GraphQLEnum<OrderCreateFinancialStatus>> {
    get { __data["financialStatus"] }
    set { __data["financialStatus"] = newValue }
  }

  /// The fulfillment to create for the order. This will apply to all line items.
  public var fulfillment: GraphQLNullable<OrderCreateFulfillmentInput> {
    get { __data["fulfillment"] }
    set { __data["fulfillment"] = newValue }
  }

  /// The fulfillment status of the order. Will default to `unfulfilled` if not included.
  public var fulfillmentStatus: GraphQLNullable<GraphQLEnum<OrderCreateFulfillmentStatus>> {
    get { __data["fulfillmentStatus"] }
    set { __data["fulfillmentStatus"] = newValue }
  }

  /// The line items to create for the order.
  public var lineItems: GraphQLNullable<[OrderCreateLineItemInput]> {
    get { __data["lineItems"] }
    set { __data["lineItems"] = newValue }
  }

  /// A list of metafields to add to the order.
  public var metafields: GraphQLNullable<[MetafieldInput]> {
    get { __data["metafields"] }
    set { __data["metafields"] = newValue }
  }

  /// The order name, generated by combining the `order_number` property with the order prefix and suffix that are set in the merchant's [general settings](https://www.shopify.com/admin/settings/general). This is different from the `id` property, which is the ID of the order used by the API. This field can also be set by the API to be any string value.
  public var name: GraphQLNullable<String> {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  /// The new contents for the note associated with the order.
  public var note: GraphQLNullable<String> {
    get { __data["note"] }
    set { __data["note"] = newValue }
  }

  /// A new customer phone number for the order.
  public var phone: GraphQLNullable<String> {
    get { __data["phone"] }
    set { __data["phone"] = newValue }
  }

  /// The purchase order number associated to this order.
  public var poNumber: GraphQLNullable<String> {
    get { __data["poNumber"] }
    set { __data["poNumber"] = newValue }
  }

  /// The presentment currency that was used to display prices to the customer. This must be specified if any presentment currencies are used in the order.
  public var presentmentCurrency: GraphQLNullable<GraphQLEnum<CurrencyCode>> {
    get { __data["presentmentCurrency"] }
    set { __data["presentmentCurrency"] = newValue }
  }

  /// The date and time ([ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format) when an order was processed. This value is the date that appears on your orders and that's used in the analytic reports. If you're importing orders from an app or another platform, then you can set processed_at to a date and time in the past to match when the original order was created. As of API version 2026-07, values in the future are clamped to the current time. In earlier versions, future values return a `PROCESSED_AT_INVALID` error.
  public var processedAt: GraphQLNullable<DateTime> {
    get { __data["processedAt"] }
    set { __data["processedAt"] = newValue }
  }

  /// The website where the customer clicked a link to the shop.
  public var referringSite: GraphQLNullable<URL> {
    get { __data["referringSite"] }
    set { __data["referringSite"] = newValue }
  }

  /// The mailing address to where the order will be shipped.
  ///
  ///               > Note:
  ///               > If a customer is provided, this field (which has precedence) or `billing_address` will be set as the
  ///               > customer's default address. Additionally, if the provided customer doesn't have a first or last name
  ///               > then it will be set to the first/last name from this address (if provided).
  public var shippingAddress: GraphQLNullable<MailingAddressInput> {
    get { __data["shippingAddress"] }
    set { __data["shippingAddress"] = newValue }
  }

  /// An array of objects, each of which details a shipping method used.
  public var shippingLines: GraphQLNullable<[OrderCreateShippingLineInput]> {
    get { __data["shippingLines"] }
    set { __data["shippingLines"] = newValue }
  }

  /// The ID of the order placed on the originating platform. This value doesn't correspond to the Shopify ID that's generated from a completed draft.
  public var sourceIdentifier: GraphQLNullable<String> {
    get { __data["sourceIdentifier"] }
    set { __data["sourceIdentifier"] = newValue }
  }

  /// The source channel that the order is attributed to. Set this to the handle of an order attribution definition configured for your sales channel app, such as `youtube` or `channel:amazon-us`. To set up order attribution for your app, follow the [order attribution guide](https://shopify.dev/docs/apps/build/sales-channels/order-attribution).
  public var sourceName: GraphQLNullable<String> {
    get { __data["sourceName"] }
    set { __data["sourceName"] = newValue }
  }

  /// A valid URL to the original order on the originating surface. This URL is displayed to merchants on the Order Details page. If the URL is invalid, then it won't be displayed.
  public var sourceUrl: GraphQLNullable<URL> {
    get { __data["sourceUrl"] }
    set { __data["sourceUrl"] = newValue }
  }

  /// A comma separated list of tags that have been added to the draft order.
  public var tags: GraphQLNullable<[String]> {
    get { __data["tags"] }
    set { __data["tags"] = newValue }
  }

  /// Whether taxes are included in the order subtotal.
  public var taxesIncluded: GraphQLNullable<Bool> {
    get { __data["taxesIncluded"] }
    set { __data["taxesIncluded"] = newValue }
  }

  /// An array of tax line objects, each of which details a tax applicable to the order. When creating an order through the API, tax lines can be specified on the order or the line items but not both. Tax lines specified on the order are split across the _taxable_ line items in the created order.
  public var taxLines: GraphQLNullable<[OrderCreateTaxLineInput]> {
    get { __data["taxLines"] }
    set { __data["taxLines"] = newValue }
  }

  /// Whether this is a test order.
  public var test: GraphQLNullable<Bool> {
    get { __data["test"] }
    set { __data["test"] = newValue }
  }

  /// The payment transactions to create for the order.
  public var transactions: GraphQLNullable<[OrderCreateOrderTransactionInput]> {
    get { __data["transactions"] }
    set { __data["transactions"] = newValue }
  }

  /// The ID of the user who processed the order, if applicable.
  public var userId: GraphQLNullable<ID> {
    get { __data["userId"] }
    set { __data["userId"] = newValue }
  }
}
