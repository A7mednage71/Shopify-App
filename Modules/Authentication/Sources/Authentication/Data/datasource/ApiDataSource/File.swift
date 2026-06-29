//
//  File.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import Foundation
import Apollo

class ShopifyApolloClient {
    static let shared = ShopifyApolloClient()
    
    private(set) lazy var apollo: ApolloClient = {
        let store = ApolloStore()
        let client = URLSessionClient()
        let provider = DefaultInterceptorProvider(client: client, store: store)
        
        let url = URL(string: "https://YOUR-STORE.myshopify.com/api/2024-01/graphql.json")!
        
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url,
            additionalHeaders: [
                "X-Shopify-Storefront-Access-Token": "YOUR-STOREFRONT-TOKEN",
                "Content-Type": "application/json"
            ]
        )
        return ApolloClient(networkTransport: transport, store: store)
    }()
}
