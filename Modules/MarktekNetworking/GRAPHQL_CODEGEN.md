# Shopify GraphQL Codegen

This module uses Apollo iOS to generate Swift types from Shopify Storefront GraphQL operations.

## Files

- `GraphQL/**/*.graphql`: GraphQL operations that the app can execute.
- `schema.graphqls`: The Shopify Storefront schema used by Apollo codegen.
- `apollo-codegen-config.json`: Shared config. Safe to commit. Does not contain secrets.
- `apollo-codegen-config.local.json`: Local config for fetching the schema. Ignored by git and can contain private values.
- `Sources/ShopifyAPI`: Generated Apollo Swift files.

## Generate Swift From Existing Schema

Use this when you changed a `.graphql` query but do not need to download a new Shopify schema.

```bash
cd /Users/eslamelnady/Shopify-App/Modules/MarktekNetworking
./apollo-ios-cli generate --path apollo-codegen-config.json
```

This reads `schema.graphqls` and files under `GraphQL/**/*.graphql`, then updates generated Swift files in `Sources/ShopifyAPI`.

## Fetch Schema And Generate Swift

Use this when Shopify schema fields changed, or when you need to download the schema again.

First edit the ignored local config:

```bash
/Users/eslamelnady/Shopify-App/Modules/MarktekNetworking/apollo-codegen-config.local.json
```

Replace these placeholders:

```text
YOUR_SHOPIFY_HOST
YOUR_SHOPIFY_API_VERSION
YOUR_STOREFRONT_ACCESS_TOKEN
```

Then run:

```bash
cd /Users/eslamelnady/Shopify-App/Modules/MarktekNetworking
./apollo-ios-cli generate --path apollo-codegen-config.local.json --fetch-schema
```

This downloads `schema.graphqls` from Shopify and regenerates `Sources/ShopifyAPI`.

## Using Generated Types

App code should use generated operation result types, not schema object metadata.

Example:

```swift
import MarktekNetworking

let data = try await ShopifyGraphQLClient.shared.fetch(GetProductsQuery())

let products = data.products.edges.map { edge in
    edge.node
}
```

For the current `GetProducts` query, the product node type is:

```swift
GetProductsQuery.Data.Products.Edge.Node
```

Fields are available only if they are selected in the `.graphql` operation. If you need `description`, `featuredImage`, variants, prices, or any other field, add it to the query and regenerate.

## Important Security Notes

Do not commit `apollo-codegen-config.local.json`.

Do not put `X-Shopify-Storefront-Access-Token` in `apollo-codegen-config.json`.

If a token was ever committed or shared accidentally, rotate it in Shopify.
