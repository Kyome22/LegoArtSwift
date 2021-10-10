// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LegoArtFilter",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "LegoArtFilter",
            targets: ["LegoArtFilter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kyome22/LegoColors", .branch("main"))
    ],
    targets: [
        .target(
            name: "LegoArtFilter",
            dependencies: ["LegoColors"]),
        .testTarget(
            name: "LegoArtFilterTests",
            dependencies: ["LegoArtFilter"]),
    ]
)
