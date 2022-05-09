// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "PortfolioSite",
    platforms: [.macOS(.v12), .iOS(.v13)],
    products: [
        .library(
            name: "PortfolioSite",
            targets: ["PortfolioSite"]
        ),
        .executable(
            name: "PortfolioSiteExecutable",
            targets: ["PortfolioSiteExecutable"]
        ),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/CoolONEOfficial/Publish.git", revision: "Multi-Language-Mobile"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/CoolONEOfficial/SplashPublishPlugin.git", branch: "master"),
        .package(name: "DarkImagePublishPlugin", url: "https://github.com/CoolONEOfficial/DarkImagePublishPlugin.git", branch: "master"),
        .package(name: "TinySliderPublishPlugin", url: "https://github.com/CoolONEOfficial/TinySliderPublishPlugin.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "PortfolioSite",
            dependencies: [
                .product(name: "Publish", package: "Publish"),
                .product(name: "SplashPublishPlugin", package: "SplashPublishPlugin"),
                .product(name: "DarkImagePublishPlugin", package: "DarkImagePublishPlugin"),
                .product(name: "TinySliderPublishPlugin", package: "TinySliderPublishPlugin"),
            ]
        ),
        .executableTarget(
            name: "PortfolioSiteExecutable",
            dependencies: [
                "PortfolioSite"
            ]
        ),
    ]
)
