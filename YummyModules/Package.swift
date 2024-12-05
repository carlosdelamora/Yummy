// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YummyModules",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "YummyModules", targets: ["Networking"]),
    ],
    targets: [
        .target(name: "Networking"),
        .testTarget(name: "NetworkingTests", dependencies: ["Networking"]),
    ]
)
