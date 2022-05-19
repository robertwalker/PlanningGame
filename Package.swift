// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlanningGame",
    products: [
        .library(
            name: "PlanningGame",
            targets: ["PlanningGame"]),
    ],
    targets: [
        .target(
            name: "PlanningGame",
            dependencies: []),
        .testTarget(
            name: "PlanningGameTests",
            dependencies: ["PlanningGame"]),
    ]
)
