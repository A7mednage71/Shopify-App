// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "MarktekNetworking",
    platforms: [
        .iOS(.v16),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "MarktekNetworking",
            targets: ["MarktekNetworking"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios", exact: "1.5.0"),
    ],
    targets: [
        .target(
            name: "MarktekNetworking",
            dependencies: [
                "ShopifyAPI",
                "ShopifyAdminAPI",
                .product(name: "Apollo", package: "apollo-ios")
            ]
        ),

        .target(
            name: "ShopifyAPI",
            dependencies: [
                .product(name: "ApolloAPI", package: "apollo-ios")
            ],
            path: "Sources/ShopifyAPI"
        ),

        .target(
            name: "ShopifyAdminAPI",
            dependencies: [
                .product(name: "ApolloAPI", package: "apollo-ios")
            ],
            path: "Sources/ShopifyAdminAPI"
        ),

        .testTarget(
            name: "MarktekNetworkingTests",
            dependencies: ["MarktekNetworking"]
        ),
    ]
)
