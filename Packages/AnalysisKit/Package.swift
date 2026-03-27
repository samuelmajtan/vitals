// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalysisKit",
    products: [
        .library(
            name: "AnalysisKit",
            targets: ["AnalysisKit"]
        ),
    ],
    targets: [
        .target(
            name: "AnalysisKit"
        ),
        .testTarget(
            name: "AnalysisKitTests",
            dependencies: ["AnalysisKit"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
