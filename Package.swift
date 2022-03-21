// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LegoArtSwift",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "LegoColors",
            targets: ["LegoColors"]
        ),
        .library(
            name: "LegoArtFilter",
            targets: ["LegoArtFilter"]
        )
    ],
    targets: [
        .target(
            name: "LegoColors"
        ),
        .target(
            name: "LegoArtFilter",
            dependencies: ["LegoColors"]
        ),
        .testTarget(
            name: "LegoColorsTests",
            dependencies: ["LegoColors"]
        ),
        .testTarget(
            name: "LegoArtFilterTests",
            dependencies: ["LegoArtFilter"],
            resources: [.process("Images")]
        )
    ]
)
