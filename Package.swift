// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlowSwift",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlowSwift",
            targets: ["FlowSwift"]),
        .library(name: "SECP256r1",
            targets: ["SECP256r1"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.26.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", from: "1.9.0"),
        .package(url: "https://github.com/mathwallet/Secp256k1Swift.git", from: "2.0.1"),
        .package(url: "https://github.com/grpc/grpc-swift", exact: "1.24.2"),
        .package(url: "https://github.com/attaswift/BigInt", from: "5.3.0"),
        .package(url: "https://github.com/mxcl/PromiseKit.git", .upToNextMajor(from: "8.1.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SECP256r1",
            dependencies: []),
        .target(
            name: "FlowSwift",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "GRPC", package: "grpc-swift"),
                "Secp256k1Swift",
                "CryptoSwift",
                "SECP256r1",
                "BigInt",
                "PromiseKit"
            ],
            resources: [.process("Templates/Contracts")]
        ),
        .testTarget(
            name: "FlowSwiftTests",
            dependencies: ["FlowSwift"]),
    ]
)
