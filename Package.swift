// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "PortfolioSite",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "PortfolioSite",
            targets: ["PortfolioSite"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/CoolONEOfficial/Publish.git", branch: "Multi-Language"),
        .package(url: "https://github.com/johnsundell/SplashPublishPlugin.git", from: "0.2.0"),
        .package(url: "https://github.com/CoolONEOfficial/DarkImagePublishPlugin.git", branch: "patch-1"),
        .package(url: "https://github.com/CoolONEOfficial/TinySliderPublishPlugin.git", exact: "0.1.5")
//        .package(url: "https://github.com/CoolONEOfficial/FTPPublishDeploy.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "PortfolioSite",
            dependencies: [
                .product(name: "Publish", package: "Publish"),
                .product(name: "SplashPublishPlugin", package: "SplashPublishPlugin"),
                .product(name: "DarkImagePublishPlugin", package: "DarkImagePublishPlugin"),
                .product(name: "TinySliderPublishPlugin", package: "TinySliderPublishPlugin"),
//                "FTPPublishDeploy"
            ]
        )
    ]
)
