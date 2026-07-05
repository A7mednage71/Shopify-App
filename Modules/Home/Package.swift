// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        // Products define the ex ecutables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(path: "../MarktekNetworking"),
        .package(path: "../Common"),
        .package(path: "../Favorites"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1"),
        .package(url: "https://github.com/markiv/SwiftUI-Shimmer.git", from: "1.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Home",
            dependencies: [
                .product(name: "MarktekNetworking", package: "MarktekNetworking"),
                .product(name: "Common", package: "Common"),
                .product(name: "Swinject", package: "Swinject"),
                .product(name: "Shimmer", package: "SwiftUI-Shimmer"),
                .product(name: "Favorites", package: "Favorites")
            ]
        ),
        
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]
        ),
    ]
    
)
