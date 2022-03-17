// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "Domains",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8)
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
