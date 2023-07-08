import Foundation
import Publish
import Ink
import Plot
import SplashPublishPlugin
import DarkImagePublishPlugin
import TinySliderPublishPlugin
import Files

public struct PortfolioSite: MultiLanguageWebsite {
    public enum SectionID: String, WebsiteSectionID {
        case projects
        case books
        case events
        case achievements
        case career
        
        public static var allCases: [SectionID] {
            return [
                .projects, .books, .events, .achievements
            ]
        }
    }

    public struct ItemMetadata: MultiLanguageWebsiteItemMetadata {
        var project: ProjectMetadata?
        var event: EventMetadata?
        var career: CareerMetadata?
        var book: BookMetadata?
        var achievement: AchievementMetadata?
        
        var videos: [String]?
        var logo: String?
        var singleImage: String?
        var endDate: String?
        public var alternateLinkIdentifier: String?
    }

    public var url = Constants.websiteUrl
    public var names: [Language : String] {
        LocalizablePhrase.websiteName.allTranslations
    }
    public var descriptions: [Language : String] {
        LocalizablePhrase.websiteDescription.allTranslations
    }
    public var languages: [Language] { [ .english, .russian ] }
    public var imagePath: Path? { Path("/" + Constants.avatarFilename) }
    public var favicon: Favicon? { Favicon(path: Path("/" + Constants.avatarFilename), type: "image/jpg") }
}

try PortfolioSite().publish(
    withTheme: .portfolio,
    additionalSteps: [
        .addItemPages()
    ],
    plugins: [
        .splash(withClassPrefix: ""),
        .darkImage(),
        .tinySlider(jsPath: "/modules/tiny-slider/src/tiny-slider.js", minimizedImagesConfig: [ .init(suffix: "_400x400", imageSize: "400px") ], defaultConfig: [
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
                        title: language.localized(.allPosts),
                        description: language.localized(.listAllPosts),
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
