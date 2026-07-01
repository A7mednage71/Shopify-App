// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Checkout",
    platforms: [
        .iOS(.v15),
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
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3"),
    ],
    targets: [
        .target(
            name: "Checkout",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "Swinject", package: "Swinject"),
            ]
        ),
    ]
)
