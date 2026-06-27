// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
        .package(url: "https://github.com/apollographql/apollo-ios", exact: "2.2.0"),
    ],
    targets: [
        .target(
            name: "MarktekNetworking",
            dependencies: [
                "ShopifyAPI",
                .product(name: "Apollo", package: "apollo-ios"),
                .product(name: "ApolloAPI", package: "apollo-ios"),
            ]
        ),
        .target(
            name: "ShopifyAPI",
            dependencies: [
                .product(name: "ApolloAPI", package: "apollo-ios"),
            ],
            path: "Sources/GraphQL/Sources"
        ),
        .testTarget(
            name: "MarktekNetworkingTests",
            dependencies: ["MarktekNetworking"]
        ),
    ],
    swiftLanguageModes: [.v5]
)
