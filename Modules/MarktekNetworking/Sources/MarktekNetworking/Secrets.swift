import Foundation

enum Secrets {
    static var shopifyHost: String {
        value(for: "SHOPIFY_HOST")
    }

    static var shopifyAPIVersion: String {
        value(for: "SHOPIFY_API_VERSION")
    }

    static var shopifyStorefrontAccessToken: String {
        value(for: "SHOPIFY_STOREFRONT_ACCESS_TOKEN")
    }

    static var shopifyStorefrontGraphQLEndpoint: Foundation.URL {
        let urlString = "https://\(shopifyHost)/api/\(shopifyAPIVersion)/graphql.json"

        guard let url = Foundation.URL(string: urlString) else {
            fatalError("Invalid Shopify Storefront GraphQL endpoint.")
        }

        return url
    }

    static var shopifyAdminAccessToken: String {
        value(for: "SHOPIFY_ADMIN_ACCESS_TOKEN")
    }

    static var shopifyAdminGraphQLEndpoint: Foundation.URL {
        let urlString = "https://\(shopifyHost)/admin/api/\(shopifyAPIVersion)/graphql.json"

        guard let url = Foundation.URL(string: urlString) else {
            fatalError("Invalid Shopify Admin GraphQL endpoint.")
        }

        return url
    }

    private static func value(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String,
              !value.isEmpty,
              !value.contains("$(") else {
            fatalError("Missing secret value for key: \(key)")
        }

        return value
    }
}
