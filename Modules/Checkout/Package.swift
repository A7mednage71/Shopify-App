// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Checkout",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "Checkout",
            targets: ["Checkout"]
        ),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../MarktekNetworking"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3"),
    ],
    targets: [
        .target(
            name: "Checkout",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "MarktekNetworking", package: "MarktekNetworking"),
                .product(name: "Swinject", package: "Swinject"),
            ]
        ),
        .testTarget(
            name: "CheckoutTests",
            dependencies: [
                "Checkout",
                .product(name: "Common", package: "Common"),
            ]
        ),
    ]
)
