// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateOrderMutation: GraphQLMutation {
  public static let operationName: String = "CreateOrder"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateOrder($order: OrderCreateOrderInput!, $options: OrderCreateOptionsInput) { orderCreate(order: $order, options: $options) { __typename order { __typename id name displayFinancialStatus displayFulfillmentStatus subtotalPriceSet { __typename presentmentMoney { __typename amount currencyCode } } totalDiscountsSet { __typename presentmentMoney { __typename amount currencyCode } } totalShippingPriceSet { __typename presentmentMoney { __typename amount currencyCode } } totalTaxSet { __typename presentmentMoney { __typename amount currencyCode } } totalPriceSet { __typename presentmentMoney { __typename amount currencyCode } } customer { __typename id } shippingAddress { __typename city provinceCode countryCodeV2 formattedArea } discountCodes lineItems(first: 20) { __typename nodes { __typename id title quantity variant { __typename id inventoryQuantity availableForSale } } } } userErrors { __typename field message } } }"#
    ))

  public var order: OrderCreateOrderInput
  public var options: GraphQLNullable<OrderCreateOptionsInput>

  public init(
    order: OrderCreateOrderInput,
    options: GraphQLNullable<OrderCreateOptionsInput>
  ) {
    self.order = order
    self.options = options
  }

  public var __variables: Variables? { [
    "order": order,
    "options": options
  ] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("orderCreate", OrderCreate?.self, arguments: [
        "order": .variable("order"),
        "options": .variable("options")
      ]),
    ] }

    /// Creates an order with attributes such as customer information, line items, and shipping and billing addresses.
    ///
    /// Use the `orderCreate` mutation to programmatically generate orders in scenarios where
    /// orders aren't created through the standard checkout process, such as when importing orders from an external
    /// system or creating orders for wholesale customers.
    ///
    /// The `orderCreate` mutation doesn't support applying multiple discounts, such as discounts on line items.
    /// Automatic discounts won't be applied unless you replicate the logic of those discounts in your custom
    /// implementation. You can [apply a discount code](https://shopify.dev/docs/api/admin-graphql/latest/input-objects/OrderCreateDiscountCodeInput),
    /// but only one discount code can be set for each order.
    ///
    /// > Note:
    /// > If you're using the `orderCreate` mutation with a
    /// > [trial](https://help.shopify.com/manual/intro-to-shopify/pricing-plans/free-trial) or
    /// > [development store](https://shopify.dev/docs/api/development-stores), then you can create a
    /// > maximum of five new orders per minute.
    ///
    /// After you create an order, you can make subsequent edits to the order using one of the following mutations:
    /// * [`orderUpdate`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/orderUpdate):
    /// Used for simple updates to an order, such as changing the order's note, tags, or customer information.
    /// * [`orderEditBegin`](https://shopify.dev/docs/api/admin-graphql/latest/mutations/orderEditBegin):
    /// Used when you need to make significant updates to an order, such as adding or removing line items, changing
    /// quantities, or modifying discounts. The `orderEditBegin` mutation initiates an order editing session,
    /// allowing you to make multiple changes before finalizing them. Learn more about using the `orderEditBegin`
    /// mutation to [edit existing orders](https://shopify.dev/docs/apps/build/orders-fulfillment/order-management-apps/edit-orders).
    ///
    /// Learn how to build apps that integrate with
    /// [order management and fulfillment processes](https://shopify.dev/docs/apps/build/orders-fulfillment).
    public var orderCreate: OrderCreate? { __data["orderCreate"] }

    /// OrderCreate
    ///
    /// Parent Type: `OrderCreatePayload`
    public struct OrderCreate: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.OrderCreatePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("order", Order?.self),
        .field("userErrors", [UserError].self),
      ] }

      /// The order that was created.
      public var order: Order? { __data["order"] }
      /// The list of errors that occurred from executing the mutation.
      public var userErrors: [UserError] { __data["userErrors"] }

      /// OrderCreate.Order
      ///
      /// Parent Type: `Order`
      public struct Order: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Order }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAdminAPI.ID.self),
          .field("name", String.self),
          .field("displayFinancialStatus", GraphQLEnum<ShopifyAdminAPI.OrderDisplayFinancialStatus>?.self),
          .field("displayFulfillmentStatus", GraphQLEnum<ShopifyAdminAPI.OrderDisplayFulfillmentStatus>.self),
          .field("subtotalPriceSet", SubtotalPriceSet?.self),
          .field("totalDiscountsSet", TotalDiscountsSet?.self),
          .field("totalShippingPriceSet", TotalShippingPriceSet.self),
          .field("totalTaxSet", TotalTaxSet?.self),
          .field("totalPriceSet", TotalPriceSet.self),
          .field("customer", Customer?.self),
          .field("shippingAddress", ShippingAddress?.self),
          .field("discountCodes", [String].self),
          .field("lineItems", LineItems.self, arguments: ["first": 20]),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAdminAPI.ID { __data["id"] }
        /// The unique identifier for the order that appears on the order page in the Shopify admin and the **Order status** page.
        /// For example, "#1001", "EN1001", or "1001-A".
        /// This value isn't unique across multiple stores. Use this field to identify orders in the Shopify admin and for order tracking.
        public var name: String { __data["name"] }
        /// An order's financial status for display in the Shopify admin.
        public var displayFinancialStatus: GraphQLEnum<ShopifyAdminAPI.OrderDisplayFinancialStatus>? { __data["displayFinancialStatus"] }
        /// The order's fulfillment status that displays in the Shopify admin to merchants. For example, an order might be unfulfilled or scheduled.
        /// For detailed processing, use the [`FulfillmentOrder`](https://shopify.dev/docs/api/admin-graphql/latest/objects/FulfillmentOrder) object.
        public var displayFulfillmentStatus: GraphQLEnum<ShopifyAdminAPI.OrderDisplayFulfillmentStatus> { __data["displayFulfillmentStatus"] }
        /// The sum of the prices for all line items after discounts and before returns, in shop and presentment currencies.
        /// If `taxesIncluded` is `true`, then the subtotal also includes tax.
        public var subtotalPriceSet: SubtotalPriceSet? { __data["subtotalPriceSet"] }
        /// The total amount discounted on the order before returns, in shop and presentment currencies.
        /// This includes both order and line level discounts.
        public var totalDiscountsSet: TotalDiscountsSet? { __data["totalDiscountsSet"] }
        /// The total shipping costs returned to the customer, in shop and presentment currencies. This includes fees and any related discounts that were refunded.
        public var totalShippingPriceSet: TotalShippingPriceSet { __data["totalShippingPriceSet"] }
        /// The total tax amount before returns, in shop and presentment currencies.
        public var totalTaxSet: TotalTaxSet? { __data["totalTaxSet"] }
        /// The total price of the order, before returns, in shop and presentment currencies.
        /// This includes taxes and discounts.
        public var totalPriceSet: TotalPriceSet { __data["totalPriceSet"] }
        /// The customer who placed an order. Returns `null` if an order was created through a checkout without customer authentication, such as a guest checkout.
        /// Learn more about [customer accounts](https://help.shopify.com/manual/customers/customer-accounts).
        public var customer: Customer? { __data["customer"] }
        /// The shipping address where the order will be delivered.
        /// Contains the customer's delivery location for fulfillment and shipping label generation.
        /// Returns `null` for digital orders or orders that don't require shipping.
        public var shippingAddress: ShippingAddress? { __data["shippingAddress"] }
        /// The discount codes used for the order. Multiple codes can be applied to a single order.
        public var discountCodes: [String] { __data["discountCodes"] }
        /// A list of the order's line items. Line items represent the individual products and quantities that make up the order.
        public var lineItems: LineItems { __data["lineItems"] }

        /// OrderCreate.Order.SubtotalPriceSet
        ///
        /// Parent Type: `MoneyBag`
        public struct SubtotalPriceSet: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("presentmentMoney", PresentmentMoney.self),
          ] }

          /// Amount in presentment currency.
          public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

          /// OrderCreate.Order.SubtotalPriceSet.PresentmentMoney
          ///
          /// Parent Type: `MoneyV2`
          public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAdminAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
            ] }

            /// A monetary value in decimal format, allowing for precise representation of cents or fractional
            /// currency. For example, 12.99.
            public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
            /// The three-letter currency code that represents a world currency used in a store. Currency codes
            /// include standard [standard ISO 4217 codes](https://en.wikipedia.org/wiki/ISO_4217), legacy codes,
            /// and non-standard codes. For example, USD.
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }

        /// OrderCreate.Order.TotalDiscountsSet
        ///
        /// Parent Type: `MoneyBag`
        public struct TotalDiscountsSet: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("presentmentMoney", PresentmentMoney.self),
          ] }

          /// Amount in presentment currency.
          public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

          /// OrderCreate.Order.TotalDiscountsSet.PresentmentMoney
          ///
          /// Parent Type: `MoneyV2`
          public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAdminAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
            ] }

            /// A monetary value in decimal format, allowing for precise representation of cents or fractional
            /// currency. For example, 12.99.
            public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
            /// The three-letter currency code that represents a world currency used in a store. Currency codes
            /// include standard [standard ISO 4217 codes](https://en.wikipedia.org/wiki/ISO_4217), legacy codes,
            /// and non-standard codes. For example, USD.
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }

        /// OrderCreate.Order.TotalShippingPriceSet
        ///
        /// Parent Type: `MoneyBag`
        public struct TotalShippingPriceSet: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("presentmentMoney", PresentmentMoney.self),
          ] }

          /// Amount in presentment currency.
          public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

          /// OrderCreate.Order.TotalShippingPriceSet.PresentmentMoney
          ///
          /// Parent Type: `MoneyV2`
          public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAdminAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
            ] }

            /// A monetary value in decimal format, allowing for precise representation of cents or fractional
            /// currency. For example, 12.99.
            public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
            /// The three-letter currency code that represents a world currency used in a store. Currency codes
            /// include standard [standard ISO 4217 codes](https://en.wikipedia.org/wiki/ISO_4217), legacy codes,
            /// and non-standard codes. For example, USD.
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }

        /// OrderCreate.Order.TotalTaxSet
        ///
        /// Parent Type: `MoneyBag`
        public struct TotalTaxSet: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("presentmentMoney", PresentmentMoney.self),
          ] }

          /// Amount in presentment currency.
          public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

          /// OrderCreate.Order.TotalTaxSet.PresentmentMoney
          ///
          /// Parent Type: `MoneyV2`
          public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAdminAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
            ] }

            /// A monetary value in decimal format, allowing for precise representation of cents or fractional
            /// currency. For example, 12.99.
            public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
            /// The three-letter currency code that represents a world currency used in a store. Currency codes
            /// include standard [standard ISO 4217 codes](https://en.wikipedia.org/wiki/ISO_4217), legacy codes,
            /// and non-standard codes. For example, USD.
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }

        /// OrderCreate.Order.TotalPriceSet
        ///
        /// Parent Type: `MoneyBag`
        public struct TotalPriceSet: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("presentmentMoney", PresentmentMoney.self),
          ] }

          /// Amount in presentment currency.
          public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

          /// OrderCreate.Order.TotalPriceSet.PresentmentMoney
          ///
          /// Parent Type: `MoneyV2`
          public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("amount", ShopifyAdminAPI.Decimal.self),
              .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
            ] }

            /// A monetary value in decimal format, allowing for precise representation of cents or fractional
            /// currency. For example, 12.99.
            public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
            /// The three-letter currency code that represents a world currency used in a store. Currency codes
            /// include standard [standard ISO 4217 codes](https://en.wikipedia.org/wiki/ISO_4217), legacy codes,
            /// and non-standard codes. For example, USD.
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
          }
        }

        /// OrderCreate.Order.Customer
        ///
        /// Parent Type: `Customer`
        public struct Customer: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.Customer }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAdminAPI.ID.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAdminAPI.ID { __data["id"] }
        }

        /// OrderCreate.Order.ShippingAddress
        ///
        /// Parent Type: `MailingAddress`
        public struct ShippingAddress: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.MailingAddress }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("city", String?.self),
            .field("provinceCode", String?.self),
            .field("countryCodeV2", GraphQLEnum<ShopifyAdminAPI.CountryCode>?.self),
            .field("formattedArea", String?.self),
          ] }

          /// The name of the city, district, village, or town.
          public var city: String? { __data["city"] }
          /// The alphanumeric code for the region.
          ///
          /// For example, ON.
          public var provinceCode: String? { __data["provinceCode"] }
          /// The two-letter code for the country of the address.
          ///
          /// For example, US.
          public var countryCodeV2: GraphQLEnum<ShopifyAdminAPI.CountryCode>? { __data["countryCodeV2"] }
          /// A comma-separated list of the values for city, province, and country.
          public var formattedArea: String? { __data["formattedArea"] }
        }

        /// OrderCreate.Order.LineItems
        ///
        /// Parent Type: `LineItemConnection`
        public struct LineItems: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.LineItemConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
          ] }

          /// A list of nodes that are contained in LineItemEdge. You can fetch data about an individual node, or you can follow the edges to fetch data about a collection of related nodes. At each node, you specify the fields that you want to retrieve.
          public var nodes: [Node] { __data["nodes"] }

          /// OrderCreate.Order.LineItems.Node
          ///
          /// Parent Type: `LineItem`
          public struct Node: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.LineItem }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", ShopifyAdminAPI.ID.self),
              .field("title", String.self),
              .field("quantity", Int.self),
              .field("variant", Variant?.self),
            ] }

            /// A globally-unique ID.
            public var id: ShopifyAdminAPI.ID { __data["id"] }
            /// The title of the product at time of order creation.
            public var title: String { __data["title"] }
            /// The number of units ordered, including refunded and removed units.
            public var quantity: Int { __data["quantity"] }
            /// The Variant object associated with this line item.
            public var variant: Variant? { __data["variant"] }

            /// OrderCreate.Order.LineItems.Node.Variant
            ///
            /// Parent Type: `ProductVariant`
            public struct Variant: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.ProductVariant }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", ShopifyAdminAPI.ID.self),
                .field("inventoryQuantity", Int?.self),
                .field("availableForSale", Bool.self),
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAdminAPI.ID { __data["id"] }
              /// The total sellable quantity of the variant.
              public var inventoryQuantity: Int? { __data["inventoryQuantity"] }
              /// Whether the product variant is available for sale.
              public var availableForSale: Bool { __data["availableForSale"] }
            }
          }
        }
      }

      /// OrderCreate.UserError
      ///
      /// Parent Type: `OrderCreateUserError`
      public struct UserError: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.OrderCreateUserError }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("field", [String]?.self),
          .field("message", String.self),
        ] }

        /// The path to the input field that caused the error.
        public var field: [String]? { __data["field"] }
        /// The error message.
        public var message: String { __data["message"] }
      }
    }
  }
}
