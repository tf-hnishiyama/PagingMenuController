// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PagingMenuController",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "PagingMenuController",
            targets: ["PagingMenuController"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PagingMenuController",
            dependencies: [],
            path: "Sources/PagingMenuController"),
    ]
)
