// swift-tools-version: 5.8

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
    dependencies: [
        .package(path: "../../Common"),
    ],
    targets: [
        .target(
            name: "Onboarding",
            dependencies: [
                "Common",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
