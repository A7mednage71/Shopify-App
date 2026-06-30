// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "MarktekNetworking",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "MarktekNetworking",
            targets: ["MarktekNetworking"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios", exact: "1.9.3"),
    ],
    targets: [
        .target(
            name: "MarktekNetworking",
            dependencies: [
                "ShopifyAPI",
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

        .testTarget(
            name: "MarktekNetworkingTests",
            dependencies: ["MarktekNetworking"]
        ),
    ]
)
