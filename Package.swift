// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SBSwifterSwift",
    platforms: [
        .iOS(.v13), .tvOS(.v13), .macOS(.v10_15), .watchOS(.v6),
    ],
    products: [
        .library(name: "SBSwifterSwift", targets: ["SBSwifterSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/s-brenner/SBLogging", from: "2.0.1"),
    ],
    targets: [
        .target(name: "SBSwifterSwift", dependencies: ["SBLogging",]),
        .testTarget(name: "SBSwifterSwiftTests", dependencies: ["SBSwifterSwift"]),
    ]
)
