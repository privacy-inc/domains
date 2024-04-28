// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Domains",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Domains",
            targets: ["Domains"]),
    ],
    targets: [
        .target(
            name: "Domains",
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: ["Domains"],
            path: "Tests"),
    ]
)
