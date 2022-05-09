//
//  PortfolioSite+publish.swift
//  
//
//  Created by Nickolay Truhin on 09.05.2022.
//

import Foundation
import Publish
import Plot
import TinySliderPublishPlugin
import DarkImagePublishPlugin
import SplashPublishPlugin

extension PortfolioSite {
    @discardableResult
    public func publish(at path: Publish.Path? = nil) throws -> PublishedWebsite<PortfolioSite> {
        try publish(
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
}

extension PublishingStep where Site == PortfolioSite {
    static func addItemPages() -> Self {
        .step(named: "Add items pages") { context in
            for language in context.site.languages {
                let chunks = context.allItems(
                    sortedBy: \.date,
                    in: language,
                    order: .descending
                ).chunked(into: 10)
                for (index, chunk) in chunks.enumerated() {
                    let index = index + 1
                    context.addPage(.init(path: "/items/\(index)", content: .init(
                        title: language == .russian ? "Все посты" : "All posts",
                        description: language == .russian ? "Список всех постов" : "List of all posts",
                        body: .init(node: .makeItemsPageContent(
                            context: context,
                            items: chunk,
                            pageIndex: index,
                            lastPage: chunks.count == index
                        )),
                        language: language
                    )))
                }
            }
        }
    }
}
