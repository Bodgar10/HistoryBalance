// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "HistoryBalance",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HistoryBalance",
            targets: ["HistoryBalance"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Bodgar10/DesignSystem.git", .upToNextMajor(from: "1.0.7")),
        .package(url: "https://github.com/Bodgar10/Common.git", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/Bodgar10/CashSwitchboard.git", .upToNextMajor(from: "1.0.3"))
    ],
    targets: [
        .target(
            name: "HistoryBalance", 
            dependencies:
                [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Common", package: "Common"),
                .product(name: "CashSwitchboard", package: "CashSwitchboard")
                ]
        ),
        .testTarget(
            name: "HistoryBalanceTests",
            dependencies: ["HistoryBalance"]),
    ],
    swiftLanguageVersions: [.v5]
)
