// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "vivian",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "Vivian", targets: ["Vivian"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Vivian",
            dependencies: [],
            path: "Sources/Vivian"
        ),
        .testTarget(
            name: "VivianTests",
            dependencies: [
                "Vivian"
            ],
            path: "Tests/VivianTests"
        ),
    ]
)
