// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlowSwift",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlowSwift",
            targets: ["FlowSwift"]),
        .library(name: "SECP256r1",
            targets: ["SECP256r1"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.18.0"),
        .package(name: "Secp256k1Swift",url: "https://github.com/mathwallet/Secp256k1Swift.git", from: "1.2.5"),
        .package(url: "https://github.com/grpc/grpc-swift", from: "1.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SECP256r1",
            dependencies: []),
        .target(
            name: "FlowSwift",
            dependencies: [.product(name: "SwiftProtobuf", package: "swift-protobuf"), .product(name: "GRPC", package: "grpc-swift"), "CryptoSwift", "Secp256k1Swift", "SECP256r1"]),
        .testTarget(
            name: "FlowSwiftTests",
            dependencies: ["FlowSwift"]),
    ]
)
