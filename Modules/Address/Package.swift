// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Address",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Address",
            targets: ["Address"]),
    ],
    dependencies: [
        .package(path: "../MarktekNetworking"),
        .package(path: "../Common"),
        .package(url: "https://github.com/Swinject/Swinject.git",.upToNextMajor(from: "2.8.3") )

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Address",
            dependencies: [
                .product(name: "MarktekNetworking", package: "MarktekNetworking"),
                .product(name: "Common", package: "Common"),
    
                .product(name: "Swinject" , package: "Swinject")
            ]),
        .testTarget(
            name: "AddressTests",
            dependencies: ["Address"]),
    ]
)
