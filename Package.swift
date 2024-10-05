// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JESideMenuController",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "JESideMenuController",
            targets: ["JESideMenuController"]
        )
    ],
    targets: [
        .target(
            name: "JESideMenuController",
            dependencies: []
        ),
        .testTarget(
            name: "JESideMenuControllerTests",
            dependencies: ["JESideMenuController"]
        )
    ]
)
