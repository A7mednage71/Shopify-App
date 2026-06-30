// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cart",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Cart",
            targets: ["Cart"]
        ),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../MarktekNetworking"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Cart",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "MarktekNetworking", package: "MarktekNetworking"),
                .product(name: "Swinject", package: "Swinject"),
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "CartTests",
            dependencies: ["Cart"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
