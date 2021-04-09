// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlanningGame",
    products: [
        .library(
            name: "PlanningGame",
            targets: ["App"]),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: []),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]),
    ]
)
