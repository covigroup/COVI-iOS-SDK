// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "COVI-iOS-SDK",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "COVI-iOS-SDK",
            targets: ["COVI-iOS-SDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "COVI-iOS-SDK",
            path: "./covisdk.xcframework"
        ),
    ]
)

