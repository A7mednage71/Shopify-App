// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

nonisolated public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

nonisolated public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

nonisolated public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

nonisolated public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

nonisolated public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  private static let objectTypeMap: [String: ApolloAPI.Object] = [
    "AppliedGiftCard": ShopifyAPI.Objects.AppliedGiftCard,
    "Article": ShopifyAPI.Objects.Article,
    "BaseCartLineConnection": ShopifyAPI.Objects.BaseCartLineConnection,
    "BaseCartLineEdge": ShopifyAPI.Objects.BaseCartLineEdge,
    "Blog": ShopifyAPI.Objects.Blog,
    "Cart": ShopifyAPI.Objects.Cart,
    "CartCost": ShopifyAPI.Objects.CartCost,
    "CartCreatePayload": ShopifyAPI.Objects.CartCreatePayload,
    "CartDiscountCode": ShopifyAPI.Objects.CartDiscountCode,
    "CartDiscountCodesUpdatePayload": ShopifyAPI.Objects.CartDiscountCodesUpdatePayload,
    "CartLine": ShopifyAPI.Objects.CartLine,
    "CartLineCost": ShopifyAPI.Objects.CartLineCost,
    "CartLinesAddPayload": ShopifyAPI.Objects.CartLinesAddPayload,
    "CartLinesRemovePayload": ShopifyAPI.Objects.CartLinesRemovePayload,
    "CartLinesUpdatePayload": ShopifyAPI.Objects.CartLinesUpdatePayload,
    "CartUserError": ShopifyAPI.Objects.CartUserError,
    "Collection": ShopifyAPI.Objects.Collection,
    "Comment": ShopifyAPI.Objects.Comment,
    "Company": ShopifyAPI.Objects.Company,
    "CompanyContact": ShopifyAPI.Objects.CompanyContact,
    "CompanyLocation": ShopifyAPI.Objects.CompanyLocation,
    "ComponentizableCartLine": ShopifyAPI.Objects.ComponentizableCartLine,
    "Customer": ShopifyAPI.Objects.Customer,
    "CustomerUserError": ShopifyAPI.Objects.CustomerUserError,
    "ExternalVideo": ShopifyAPI.Objects.ExternalVideo,
    "GenericFile": ShopifyAPI.Objects.GenericFile,
    "Image": ShopifyAPI.Objects.Image,
    "ImageConnection": ShopifyAPI.Objects.ImageConnection,
    "ImageEdge": ShopifyAPI.Objects.ImageEdge,
    "Location": ShopifyAPI.Objects.Location,
    "MailingAddress": ShopifyAPI.Objects.MailingAddress,
    "Market": ShopifyAPI.Objects.Market,
    "MediaImage": ShopifyAPI.Objects.MediaImage,
    "MediaPresentation": ShopifyAPI.Objects.MediaPresentation,
    "Menu": ShopifyAPI.Objects.Menu,
    "MenuItem": ShopifyAPI.Objects.MenuItem,
    "Metafield": ShopifyAPI.Objects.Metafield,
    "MetafieldDeleteUserError": ShopifyAPI.Objects.MetafieldDeleteUserError,
    "MetafieldsSetUserError": ShopifyAPI.Objects.MetafieldsSetUserError,
    "Metaobject": ShopifyAPI.Objects.Metaobject,
    "Model3d": ShopifyAPI.Objects.Model3d,
    "MoneyV2": ShopifyAPI.Objects.MoneyV2,
    "Mutation": ShopifyAPI.Objects.Mutation,
    "Order": ShopifyAPI.Objects.Order,
    "Page": ShopifyAPI.Objects.Page,
    "Product": ShopifyAPI.Objects.Product,
    "ProductConnection": ShopifyAPI.Objects.ProductConnection,
    "ProductEdge": ShopifyAPI.Objects.ProductEdge,
    "ProductOption": ShopifyAPI.Objects.ProductOption,
    "ProductOptionValue": ShopifyAPI.Objects.ProductOptionValue,
    "ProductPriceRange": ShopifyAPI.Objects.ProductPriceRange,
    "ProductVariant": ShopifyAPI.Objects.ProductVariant,
    "ProductVariantConnection": ShopifyAPI.Objects.ProductVariantConnection,
    "ProductVariantEdge": ShopifyAPI.Objects.ProductVariantEdge,
    "QueryRoot": ShopifyAPI.Objects.QueryRoot,
    "SearchQuerySuggestion": ShopifyAPI.Objects.SearchQuerySuggestion,
    "SelectedOption": ShopifyAPI.Objects.SelectedOption,
    "SellingPlan": ShopifyAPI.Objects.SellingPlan,
    "Shop": ShopifyAPI.Objects.Shop,
    "ShopPayInstallmentsFinancingPlan": ShopifyAPI.Objects.ShopPayInstallmentsFinancingPlan,
    "ShopPayInstallmentsFinancingPlanTerm": ShopifyAPI.Objects.ShopPayInstallmentsFinancingPlanTerm,
    "ShopPayInstallmentsProductVariantPricing": ShopifyAPI.Objects.ShopPayInstallmentsProductVariantPricing,
    "ShopPolicy": ShopifyAPI.Objects.ShopPolicy,
    "TaxonomyCategory": ShopifyAPI.Objects.TaxonomyCategory,
    "UrlRedirect": ShopifyAPI.Objects.UrlRedirect,
    "UserError": ShopifyAPI.Objects.UserError,
    "UserErrorsShopPayPaymentRequestSessionUserErrors": ShopifyAPI.Objects.UserErrorsShopPayPaymentRequestSessionUserErrors,
    "Video": ShopifyAPI.Objects.Video
  ]

  @_spi(Execution) public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    objectTypeMap[typename]
  }
}

nonisolated public enum Objects {}
nonisolated public enum Interfaces {}
nonisolated public enum Unions {}
