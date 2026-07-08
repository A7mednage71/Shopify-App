// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Common",
            targets: ["Common"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.10.0"),
        .package(url: "https://github.com/markiv/SwiftUI-Shimmer.git", from: "1.4.0"),
        .package(path: "../MarktekNetworking")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Common",
            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Shimmer", package: "SwiftUI-Shimmer"),
                .product(name: "MarktekNetworking", package: "MarktekNetworking")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: ["Common"]
        ),
    ]
)
