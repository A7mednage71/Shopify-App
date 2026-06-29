// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Onboarding",
            targets: ["Onboarding"]
        ),
    ],
    targets: [
        .target(
            name: "Onboarding",
            resources: [
                .process("Resources"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
