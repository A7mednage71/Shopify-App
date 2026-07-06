// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ValidateDiscountCodeQuery: GraphQLQuery {
  public static let operationName: String = "ValidateDiscountCode"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ValidateDiscountCode($code: String!) { codeDiscountNodeByCode(code: $code) { __typename id codeDiscount { __typename ... on DiscountCodeBasic { title status startsAt endsAt usageLimit asyncUsageCount customerGets { __typename value { __typename ... on DiscountPercentage { percentage } ... on DiscountAmount { amount { __typename amount currencyCode } appliesOnEachItem } } items { __typename ... on AllDiscountItems { allItems } } } minimumRequirement { __typename ... on DiscountMinimumQuantity { greaterThanOrEqualToQuantity } ... on DiscountMinimumSubtotal { greaterThanOrEqualToSubtotal { __typename amount currencyCode } } } } ... on DiscountCodeFreeShipping { title status startsAt endsAt usageLimit asyncUsageCount maximumShippingPrice { __typename amount currencyCode } minimumRequirement { __typename ... on DiscountMinimumQuantity { greaterThanOrEqualToQuantity } ... on DiscountMinimumSubtotal { greaterThanOrEqualToSubtotal { __typename amount currencyCode } } } } } } }"#
    ))

  public var code: String

  public init(code: String) {
    self.code = code
  }

  public var __variables: Variables? { ["code": code] }

  public struct Data: ShopifyAdminAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.QueryRoot }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("codeDiscountNodeByCode", CodeDiscountNodeByCode?.self, arguments: ["code": .variable("code")]),
    ] }

    /// Retrieves a [code discount](https://help.shopify.com/manual/discounts/discount-types#discount-codes) by its discount code. The search is case-insensitive, enabling you to find discounts regardless of how customers enter the code.
    ///
    /// Returns a [`DiscountCodeNode`](https://shopify.dev/docs/api/admin-graphql/latest/objects/DiscountCodeNode) that contains the underlying discount details, which could be a basic [amount off discount](https://help.shopify.com/manual/discounts/discount-types/percentage-fixed-amount), a ["Buy X Get Y" (BXGY) discount](https://help.shopify.com/manual/discounts/discount-types/buy-x-get-y), a [free shipping discount](https://help.shopify.com/manual/discounts/discount-types/free-shipping), or an [app-provided discount](https://help.shopify.com/manual/discounts/discount-types/discounts-with-apps).
    ///
    /// Learn more about working with [Shopify's discount model](https://shopify.dev/docs/apps/build/discounts).
    public var codeDiscountNodeByCode: CodeDiscountNodeByCode? { __data["codeDiscountNodeByCode"] }

    /// CodeDiscountNodeByCode
    ///
    /// Parent Type: `DiscountCodeNode`
    public struct CodeDiscountNodeByCode: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountCodeNode }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", ShopifyAdminAPI.ID.self),
        .field("codeDiscount", CodeDiscount.self),
      ] }

      /// A globally-unique ID.
      public var id: ShopifyAdminAPI.ID { __data["id"] }
      /// The underlying code discount object.
      public var codeDiscount: CodeDiscount { __data["codeDiscount"] }

      /// CodeDiscountNodeByCode.CodeDiscount
      ///
      /// Parent Type: `DiscountCode`
      public struct CodeDiscount: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Unions.DiscountCode }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .inlineFragment(AsDiscountCodeBasic.self),
          .inlineFragment(AsDiscountCodeFreeShipping.self),
        ] }

        public var asDiscountCodeBasic: AsDiscountCodeBasic? { _asInlineFragment() }
        public var asDiscountCodeFreeShipping: AsDiscountCodeFreeShipping? { _asInlineFragment() }

        /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic
        ///
        /// Parent Type: `DiscountCodeBasic`
        public struct AsDiscountCodeBasic: ShopifyAdminAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount
          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountCodeBasic }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("title", String.self),
            .field("status", GraphQLEnum<ShopifyAdminAPI.DiscountStatus>.self),
            .field("startsAt", ShopifyAdminAPI.DateTime.self),
            .field("endsAt", ShopifyAdminAPI.DateTime?.self),
            .field("usageLimit", Int?.self),
            .field("asyncUsageCount", Int.self),
            .field("customerGets", CustomerGets.self),
            .field("minimumRequirement", MinimumRequirement?.self),
          ] }

          /// The discount's name that displays to merchants in the Shopify admin and to customers.
          public var title: String { __data["title"] }
          /// The status of the discount that describes its availability,
          /// expiration, or pending activation.
          public var status: GraphQLEnum<ShopifyAdminAPI.DiscountStatus> { __data["status"] }
          /// The date and time when the discount becomes active and is available to customers.
          public var startsAt: ShopifyAdminAPI.DateTime { __data["startsAt"] }
          /// The date and time when the discount expires and is no longer available to customers.
          /// For discounts without a fixed expiration date, specify `null`.
          public var endsAt: ShopifyAdminAPI.DateTime? { __data["endsAt"] }
          /// The maximum number of times the discount can be redeemed.
          /// For unlimited usage, specify `null`.
          public var usageLimit: Int? { __data["usageLimit"] }
          /// The number of times that the discount has been used.
          /// For example, if a "Buy 3, Get 1 Free" t-shirt discount
          /// is automatically applied in 200 transactions, then the
          /// discount has been used 200 times.
          /// This value is updated asynchronously. As a result,
          /// it might be lower than the actual usage count until the
          /// asynchronous process is completed.
          public var asyncUsageCount: Int { __data["asyncUsageCount"] }
          /// The items in the order that qualify for the discount, their quantities, and the total value of the discount.
          public var customerGets: CustomerGets { __data["customerGets"] }
          /// The minimum subtotal or quantity of items that are required for the discount to be applied.
          public var minimumRequirement: MinimumRequirement? { __data["minimumRequirement"] }

          /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets
          ///
          /// Parent Type: `DiscountCustomerGets`
          public struct CustomerGets: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountCustomerGets }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("value", Value.self),
              .field("items", Items.self),
            ] }

            /// Entitled quantity and the discount value.
            public var value: Value { __data["value"] }
            /// The items to which the discount applies.
            public var items: Items { __data["items"] }

            /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Value
            ///
            /// Parent Type: `DiscountCustomerGetsValue`
            public struct Value: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Unions.DiscountCustomerGetsValue }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .inlineFragment(AsDiscountPercentage.self),
                .inlineFragment(AsDiscountAmount.self),
              ] }

              public var asDiscountPercentage: AsDiscountPercentage? { _asInlineFragment() }
              public var asDiscountAmount: AsDiscountAmount? { _asInlineFragment() }

              /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Value.AsDiscountPercentage
              ///
              /// Parent Type: `DiscountPercentage`
              public struct AsDiscountPercentage: ShopifyAdminAPI.InlineFragment {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Value
                public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountPercentage }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("percentage", Double.self),
                ] }

                /// The percentage value of the discount.
                public var percentage: Double { __data["percentage"] }
              }

              /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Value.AsDiscountAmount
              ///
              /// Parent Type: `DiscountAmount`
              public struct AsDiscountAmount: ShopifyAdminAPI.InlineFragment {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Value
                public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountAmount }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("amount", Amount.self),
                  .field("appliesOnEachItem", Bool.self),
                ] }

                /// The value of the discount.
                public var amount: Amount { __data["amount"] }
                /// If true, then the discount is applied to each of the entitled items. If false, then the amount is split across all of the entitled items.
                public var appliesOnEachItem: Bool { __data["appliesOnEachItem"] }

                /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Value.AsDiscountAmount.Amount
                ///
                /// Parent Type: `MoneyV2`
                public struct Amount: ShopifyAdminAPI.SelectionSet {
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
            }

            /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Items
            ///
            /// Parent Type: `DiscountItems`
            public struct Items: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Unions.DiscountItems }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .inlineFragment(AsAllDiscountItems.self),
              ] }

              public var asAllDiscountItems: AsAllDiscountItems? { _asInlineFragment() }

              /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Items.AsAllDiscountItems
              ///
              /// Parent Type: `AllDiscountItems`
              public struct AsAllDiscountItems: ShopifyAdminAPI.InlineFragment {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.CustomerGets.Items
                public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.AllDiscountItems }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("allItems", Bool.self),
                ] }

                /// Whether all items are eligible for the discount. This value always returns `true`.
                public var allItems: Bool { __data["allItems"] }
              }
            }
          }

          /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.MinimumRequirement
          ///
          /// Parent Type: `DiscountMinimumRequirement`
          public struct MinimumRequirement: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Unions.DiscountMinimumRequirement }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsDiscountMinimumQuantity.self),
              .inlineFragment(AsDiscountMinimumSubtotal.self),
            ] }

            public var asDiscountMinimumQuantity: AsDiscountMinimumQuantity? { _asInlineFragment() }
            public var asDiscountMinimumSubtotal: AsDiscountMinimumSubtotal? { _asInlineFragment() }

            /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.MinimumRequirement.AsDiscountMinimumQuantity
            ///
            /// Parent Type: `DiscountMinimumQuantity`
            public struct AsDiscountMinimumQuantity: ShopifyAdminAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.MinimumRequirement
              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountMinimumQuantity }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("greaterThanOrEqualToQuantity", ShopifyAdminAPI.UnsignedInt64.self),
              ] }

              /// The minimum quantity of items that's required for the discount to be applied.
              public var greaterThanOrEqualToQuantity: ShopifyAdminAPI.UnsignedInt64 { __data["greaterThanOrEqualToQuantity"] }
            }

            /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.MinimumRequirement.AsDiscountMinimumSubtotal
            ///
            /// Parent Type: `DiscountMinimumSubtotal`
            public struct AsDiscountMinimumSubtotal: ShopifyAdminAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.MinimumRequirement
              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountMinimumSubtotal }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("greaterThanOrEqualToSubtotal", GreaterThanOrEqualToSubtotal.self),
              ] }

              /// The minimum subtotal that's required for the discount to be applied.
              public var greaterThanOrEqualToSubtotal: GreaterThanOrEqualToSubtotal { __data["greaterThanOrEqualToSubtotal"] }

              /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.MinimumRequirement.AsDiscountMinimumSubtotal.GreaterThanOrEqualToSubtotal
              ///
              /// Parent Type: `MoneyV2`
              public struct GreaterThanOrEqualToSubtotal: ShopifyAdminAPI.SelectionSet {
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
          }
        }

        /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping
        ///
        /// Parent Type: `DiscountCodeFreeShipping`
        public struct AsDiscountCodeFreeShipping: ShopifyAdminAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount
          public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountCodeFreeShipping }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("title", String.self),
            .field("status", GraphQLEnum<ShopifyAdminAPI.DiscountStatus>.self),
            .field("startsAt", ShopifyAdminAPI.DateTime.self),
            .field("endsAt", ShopifyAdminAPI.DateTime?.self),
            .field("usageLimit", Int?.self),
            .field("asyncUsageCount", Int.self),
            .field("maximumShippingPrice", MaximumShippingPrice?.self),
            .field("minimumRequirement", MinimumRequirement?.self),
          ] }

          /// The discount's name that displays to merchants in the Shopify admin and to customers.
          public var title: String { __data["title"] }
          /// The status of the discount that describes its availability,
          /// expiration, or pending activation.
          public var status: GraphQLEnum<ShopifyAdminAPI.DiscountStatus> { __data["status"] }
          /// The date and time when the discount becomes active and is available to customers.
          public var startsAt: ShopifyAdminAPI.DateTime { __data["startsAt"] }
          /// The date and time when the discount expires and is no longer available to customers.
          /// For discounts without a fixed expiration date, specify `null`.
          public var endsAt: ShopifyAdminAPI.DateTime? { __data["endsAt"] }
          /// The maximum number of times the discount can be redeemed.
          /// For unlimited usage, specify `null`.
          public var usageLimit: Int? { __data["usageLimit"] }
          /// The number of times that the discount has been used.
          /// For example, if a "Buy 3, Get 1 Free" t-shirt discount
          /// is automatically applied in 200 transactions, then the
          /// discount has been used 200 times.
          /// This value is updated asynchronously. As a result,
          /// it might be lower than the actual usage count until the
          /// asynchronous process is completed.
          public var asyncUsageCount: Int { __data["asyncUsageCount"] }
          /// The maximum shipping price amount accepted to qualify for the discount.
          public var maximumShippingPrice: MaximumShippingPrice? { __data["maximumShippingPrice"] }
          /// The minimum subtotal or quantity of items that are required for the discount to be applied.
          public var minimumRequirement: MinimumRequirement? { __data["minimumRequirement"] }

          /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MaximumShippingPrice
          ///
          /// Parent Type: `MoneyV2`
          public struct MaximumShippingPrice: ShopifyAdminAPI.SelectionSet {
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

          /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MinimumRequirement
          ///
          /// Parent Type: `DiscountMinimumRequirement`
          public struct MinimumRequirement: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Unions.DiscountMinimumRequirement }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsDiscountMinimumQuantity.self),
              .inlineFragment(AsDiscountMinimumSubtotal.self),
            ] }

            public var asDiscountMinimumQuantity: AsDiscountMinimumQuantity? { _asInlineFragment() }
            public var asDiscountMinimumSubtotal: AsDiscountMinimumSubtotal? { _asInlineFragment() }

            /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MinimumRequirement.AsDiscountMinimumQuantity
            ///
            /// Parent Type: `DiscountMinimumQuantity`
            public struct AsDiscountMinimumQuantity: ShopifyAdminAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MinimumRequirement
              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountMinimumQuantity }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("greaterThanOrEqualToQuantity", ShopifyAdminAPI.UnsignedInt64.self),
              ] }

              /// The minimum quantity of items that's required for the discount to be applied.
              public var greaterThanOrEqualToQuantity: ShopifyAdminAPI.UnsignedInt64 { __data["greaterThanOrEqualToQuantity"] }
            }

            /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MinimumRequirement.AsDiscountMinimumSubtotal
            ///
            /// Parent Type: `DiscountMinimumSubtotal`
            public struct AsDiscountMinimumSubtotal: ShopifyAdminAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MinimumRequirement
              public static var __parentType: ApolloAPI.ParentType { ShopifyAdminAPI.Objects.DiscountMinimumSubtotal }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("greaterThanOrEqualToSubtotal", GreaterThanOrEqualToSubtotal.self),
              ] }

              /// The minimum subtotal that's required for the discount to be applied.
              public var greaterThanOrEqualToSubtotal: GreaterThanOrEqualToSubtotal { __data["greaterThanOrEqualToSubtotal"] }

              /// CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MinimumRequirement.AsDiscountMinimumSubtotal.GreaterThanOrEqualToSubtotal
              ///
              /// Parent Type: `MoneyV2`
              public struct GreaterThanOrEqualToSubtotal: ShopifyAdminAPI.SelectionSet {
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
          }
        }
      }
    }
  }
}
