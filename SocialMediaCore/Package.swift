// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SocialMediaCore",
    defaultLocalization: .init("en"),
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "App",targets: ["App"]),
        .library(name: "SharedUI", targets: ["SharedUI"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
        .library(name: "NetworkHerizon", targets: ["NetworkHerizon"]),
        .library(name: "HorizonStorage", targets: ["HorizonStorage"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.0.0"),
        .package(url: "https://github.com/evgenyneu/keychain-swift", exact: "20.0.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "SharedUI",
                "NetworkHerizon",
                "SharedModels",
                "HorizonStorage",
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                "App",
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "SharedUI",
            dependencies: [],
            resources: [
                .process("Assets/Resources")
            ]
        ),
        .target(
            name: "NetworkHerizon",
            dependencies: [],
            resources: []
        ),
        .target(
            name: "SharedModels",
            dependencies: [],
            resources: []
        ),
        .target(
            name: "HorizonStorage",
            dependencies: [
                .product(name: "KeychainSwift", package: "keychain-swift"),
                .product(name: "Dependencies", package: "swift-dependencies")
            ],
            resources: [
                .process("CoreData/SocialNetwork.xcdatamodeld")
            ]
        )
    ]
)
