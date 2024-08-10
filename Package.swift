// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "TravelerServer",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(
            name: "travelerserver",
            targets: ["TravelerServer"]
        ),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.99.3"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
    ],
    targets: [
        .executableTarget(
            name: "TravelerServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("DisableOutwardActorInference"),
    .enableExperimentalFeature("StrictConcurrency"),
]
