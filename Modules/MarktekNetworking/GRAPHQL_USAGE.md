# Using Shopify GraphQL

This guide starts from creating a GraphQL operation and ends with using the generated Swift type in app code.

## 1. Create A GraphQL File

Add a `.graphql` file under:

```text
Modules/MarktekNetworking/GraphQL/Queries
```

Example:

```text
Modules/MarktekNetworking/GraphQL/Queries/GetProducts.graphql
```

Write the operation:

```graphql
query GetProducts {
  products(first: 10) {
    edges {
      node {
        id
        title
        handle
      }
    }
  }
}
```

The operation name is important. `query GetProducts` becomes this Swift type:

```swift
GetProductsQuery
```

## 2. Generate Swift Types

From the networking module:

```bash
cd /Users/eslamelnady/Shopify-App/Modules/MarktekNetworking
./apollo-ios-cli generate --path apollo-codegen-config.json
```

Apollo reads:

```text
GraphQL/**/*.graphql
schema.graphqls
```

and generates Swift files under:

```text
Sources/ShopifyAPI
```

For `GetProducts.graphql`, Apollo generates:

```text
Sources/ShopifyAPI/Operations/Queries/GetProductsQuery.graphql.swift
```

## 3. Use The Generated Query

Import the networking module:

```swift
import MarktekNetworking
```

Call the existing client:

```swift
let data = try await ShopifyGraphQLClient.shared.fetch(GetProductsQuery())
```

The generated response shape matches the `.graphql` file:

```swift
let productNodes = data.products.edges.map { edge in
    edge.node
}
```

Each `node` has only the fields selected in the query:

```swift
node.id
node.title
node.handle
```

## 4. Map GraphQL Data To App Models

Do not use Apollo generated types as your main app models. Convert them into your own models.

Example:

```swift
import MarktekNetworking

struct ProductModel: Identifiable {
    let id: String
    let title: String
    let handle: String

    init(graphQLData: GetProductsQuery.Data.Products.Edge.Node) {
        self.id = graphQLData.id
        self.title = graphQLData.title
        self.handle = graphQLData.handle
    }
}
```

Then map the response:

```swift
let data = try await ShopifyGraphQLClient.shared.fetch(GetProductsQuery())

let products = data.products.edges.map { edge in
    ProductModel(graphQLData: edge.node)
}
```

## 5. Use It From A View Model

Example:

```swift
import Foundation
import MarktekNetworking

@MainActor
final class ProductsViewModel: ObservableObject {
    @Published private(set) var products: [ProductModel] = []
    @Published private(set) var errorMessage: String?

    func loadProducts() async {
        do {
            let data = try await ShopifyGraphQLClient.shared.fetch(GetProductsQuery())

            products = data.products.edges.map { edge in
                ProductModel(graphQLData: edge.node)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
```

## 6. Add More Fields

If you need more data, add it to the `.graphql` operation.

Example:

```graphql
query GetProducts {
  products(first: 10) {
    edges {
      node {
        id
        title
        handle
        description
        featuredImage {
          url
          altText
        }
      }
    }
  }
}
```

Then regenerate:

```bash
cd /Users/eslamelnady/Shopify-App/Modules/MarktekNetworking
./apollo-ios-cli generate --path apollo-codegen-config.json
```

Now Swift can access:

```swift
node.description
node.featuredImage?.url
node.featuredImage?.altText
```

## Important Notes

Files under `Sources/ShopifyAPI/Operations` contain the generated query response types you use in code.

Files under `Sources/ShopifyAPI/Schema/Objects` are Apollo schema metadata, not app models.

For example, this is metadata:

```swift
ShopifyAPI.Objects.Product
```

This is API response data:

```swift
GetProductsQuery.Data.Products.Edge.Node
```

If Swift cannot find a field, it usually means that field is not selected in the `.graphql` operation, or codegen was not run after changing the operation.
