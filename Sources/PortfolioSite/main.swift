import Foundation
import Publish
import Ink
import Plot
import SplashPublishPlugin
import DarkImagePublishPlugin
import TinySliderPublishPlugin
import Files

@discardableResult
public func publishPortfolioSite(at path: Publish.Path? = nil) throws -> PublishedWebsite<PortfolioSite> {

    try PortfolioSite().publish(
        withTheme: .portfolio,
        at: path,
        additionalSteps: [
            .addItemPages()
        ],
        plugins: [
            .splash(withClassPrefix: ""),
            .darkImage(),
            .tinySlider(jsPath: "/modules/tiny-slider/src/tiny-slider.js", defaultConfig: [
                "mouseDrag": true,
                "swipeAngle": false,
                "controls": false,
                "nav": false,
                "loop": false,
                "lazyload": true,
                "responsive": [
                    "350": [
                        "items": 2
                    ],
                    "500": [
                        "items": 3
                    ]
                ],
            ])
        ]
    )
}

try publishPortfolioSite()
