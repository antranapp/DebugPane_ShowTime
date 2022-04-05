// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DebugPane_ShowTime",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "DebugPane_ShowTime",
            targets: ["DebugPane_ShowTime"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/antranapp/DebugPane", .branch("master")),
        .package(url: "https://github.com/KaneCheshire/ShowTime", .exact("2.5.3")),
    ],
    targets: [
        .target(
            name: "DebugPane_ShowTime",
            dependencies: [
                "ShowTime",
                "DebugPane",
            ]
        ),
        .testTarget(
            name: "DebugPane_ShowTimeTests",
            dependencies: ["DebugPane_ShowTime"]
        ),
    ]
)
