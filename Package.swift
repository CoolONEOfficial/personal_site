// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "PortfolioSite",
    products: [
        .executable(
            name: "PortfolioSite",
            targets: ["PortfolioSite"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin.git", from: "0.1.0"),
        .package(name: "DarkImagePublishPlugin", url: "https://github.com/insidegui/DarkImagePublishPlugin.git", from: "0.1.0"),
        .package(name: "TinySliderPublishPlugin", url: "https://github.com/CoolONEOfficial/TinySliderPlugin.git", from: "0.1.1")
    ],
    targets: [
        .target(
            name: "PortfolioSite",
            dependencies: [
                "Publish",
                "SplashPublishPlugin",
                "DarkImagePublishPlugin",
                "TinySliderPublishPlugin"
            ]
        )
    ]
)
