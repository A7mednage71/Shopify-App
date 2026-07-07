// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Mutation": return ShopifyAPI.Objects.Mutation
    case "CartLinesRemovePayload": return ShopifyAPI.Objects.CartLinesRemovePayload
    case "Cart": return ShopifyAPI.Objects.Cart
    case "Article": return ShopifyAPI.Objects.Article
    case "AppliedGiftCard": return ShopifyAPI.Objects.AppliedGiftCard
    case "Blog": return ShopifyAPI.Objects.Blog
    case "Collection": return ShopifyAPI.Objects.Collection
    case "Page": return ShopifyAPI.Objects.Page
    case "Product": return ShopifyAPI.Objects.Product
    case "SearchQuerySuggestion": return ShopifyAPI.Objects.SearchQuerySuggestion
    case "Metaobject": return ShopifyAPI.Objects.Metaobject
    case "CartLine": return ShopifyAPI.Objects.CartLine
    case "ComponentizableCartLine": return ShopifyAPI.Objects.ComponentizableCartLine
    case "Comment": return ShopifyAPI.Objects.Comment
    case "Company": return ShopifyAPI.Objects.Company
    case "CompanyContact": return ShopifyAPI.Objects.CompanyContact
    case "CompanyLocation": return ShopifyAPI.Objects.CompanyLocation
    case "ExternalVideo": return ShopifyAPI.Objects.ExternalVideo
    case "MediaImage": return ShopifyAPI.Objects.MediaImage
    case "Model3d": return ShopifyAPI.Objects.Model3d
    case "Video": return ShopifyAPI.Objects.Video
    case "GenericFile": return ShopifyAPI.Objects.GenericFile
    case "Location": return ShopifyAPI.Objects.Location
    case "MailingAddress": return ShopifyAPI.Objects.MailingAddress
    case "Market": return ShopifyAPI.Objects.Market
    case "MediaPresentation": return ShopifyAPI.Objects.MediaPresentation
    case "Menu": return ShopifyAPI.Objects.Menu
    case "MenuItem": return ShopifyAPI.Objects.MenuItem
    case "Metafield": return ShopifyAPI.Objects.Metafield
    case "Order": return ShopifyAPI.Objects.Order
    case "ProductOption": return ShopifyAPI.Objects.ProductOption
    case "ProductOptionValue": return ShopifyAPI.Objects.ProductOptionValue
    case "ProductVariant": return ShopifyAPI.Objects.ProductVariant
    case "Shop": return ShopifyAPI.Objects.Shop
    case "ShopPayInstallmentsFinancingPlan": return ShopifyAPI.Objects.ShopPayInstallmentsFinancingPlan
    case "ShopPayInstallmentsFinancingPlanTerm": return ShopifyAPI.Objects.ShopPayInstallmentsFinancingPlanTerm
    case "ShopPayInstallmentsProductVariantPricing": return ShopifyAPI.Objects.ShopPayInstallmentsProductVariantPricing
    case "ShopPolicy": return ShopifyAPI.Objects.ShopPolicy
    case "TaxonomyCategory": return ShopifyAPI.Objects.TaxonomyCategory
    case "UrlRedirect": return ShopifyAPI.Objects.UrlRedirect
    case "Customer": return ShopifyAPI.Objects.Customer
    case "SellingPlan": return ShopifyAPI.Objects.SellingPlan
    case "CartCost": return ShopifyAPI.Objects.CartCost
    case "MoneyV2": return ShopifyAPI.Objects.MoneyV2
    case "BaseCartLineConnection": return ShopifyAPI.Objects.BaseCartLineConnection
    case "BaseCartLineEdge": return ShopifyAPI.Objects.BaseCartLineEdge
    case "CartUserError": return ShopifyAPI.Objects.CartUserError
    case "CustomerUserError": return ShopifyAPI.Objects.CustomerUserError
    case "MetafieldDeleteUserError": return ShopifyAPI.Objects.MetafieldDeleteUserError
    case "MetafieldsSetUserError": return ShopifyAPI.Objects.MetafieldsSetUserError
    case "UserError": return ShopifyAPI.Objects.UserError
    case "UserErrorsShopPayPaymentRequestSessionUserErrors": return ShopifyAPI.Objects.UserErrorsShopPayPaymentRequestSessionUserErrors
    case "QueryRoot": return ShopifyAPI.Objects.QueryRoot
    case "OrderConnection": return ShopifyAPI.Objects.OrderConnection
    case "OrderEdge": return ShopifyAPI.Objects.OrderEdge
    case "OrderLineItemConnection": return ShopifyAPI.Objects.OrderLineItemConnection
    case "OrderLineItemEdge": return ShopifyAPI.Objects.OrderLineItemEdge
    case "OrderLineItem": return ShopifyAPI.Objects.OrderLineItem
    case "Image": return ShopifyAPI.Objects.Image
    case "CartCreatePayload": return ShopifyAPI.Objects.CartCreatePayload
    case "CartLineCost": return ShopifyAPI.Objects.CartLineCost
    case "CartDiscountCodesUpdatePayload": return ShopifyAPI.Objects.CartDiscountCodesUpdatePayload
    case "CartDiscountCode": return ShopifyAPI.Objects.CartDiscountCode
    case "CollectionConnection": return ShopifyAPI.Objects.CollectionConnection
    case "ProductConnection": return ShopifyAPI.Objects.ProductConnection
    case "ProductEdge": return ShopifyAPI.Objects.ProductEdge
    case "ProductPriceRange": return ShopifyAPI.Objects.ProductPriceRange
    case "ImageConnection": return ShopifyAPI.Objects.ImageConnection
    case "ImageEdge": return ShopifyAPI.Objects.ImageEdge
    case "ProductVariantConnection": return ShopifyAPI.Objects.ProductVariantConnection
    case "ProductVariantEdge": return ShopifyAPI.Objects.ProductVariantEdge
    case "MetafieldReferenceConnection": return ShopifyAPI.Objects.MetafieldReferenceConnection
    case "MetafieldReferenceEdge": return ShopifyAPI.Objects.MetafieldReferenceEdge
    case "MetaobjectField": return ShopifyAPI.Objects.MetaobjectField
    case "PageInfo": return ShopifyAPI.Objects.PageInfo
    case "SearchResultItemConnection": return ShopifyAPI.Objects.SearchResultItemConnection
    case "SearchResultItemEdge": return ShopifyAPI.Objects.SearchResultItemEdge
    case "SelectedOption": return ShopifyAPI.Objects.SelectedOption
    case "CartLinesAddPayload": return ShopifyAPI.Objects.CartLinesAddPayload
    case "CartLinesUpdatePayload": return ShopifyAPI.Objects.CartLinesUpdatePayload
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
