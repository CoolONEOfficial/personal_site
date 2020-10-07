import Foundation
import Publish
import Ink
import Plot
import SplashPublishPlugin
import DarkImagePublishPlugin
import TinySliderPublishPlugin

// This type acts as the configuration for your website.
struct PortfolioSite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case projects
        case books
        case events
        case career
        case achievements
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var project: ProjectMetadata?
        var event: EventMetadata?
        var career: CareerMetadata?
        var book: BookMetadata?
        var achievement: AchievementMetadata?
        
        var logo: String?
        var singleImage: String?
    }

    var url = URL(string: "https://coolone.ru")!
    var name = "Сайт Николая Трухина"
    var description = "Здесь собрана вся информация проектах, мероприятиях, книгах и многое другое"
    var language: Language { .russian }
    var imagePath: Path? { "/img/avatar.jpg" }
    var favicon: Favicon? { .init(path: "/img/avatar.jpg", type: "image/jpg") }
}

// This will generate your website using the built-in Foundation theme:
try PortfolioSite().publish(
    withTheme: .portfolio,
    additionalSteps: [
        .addDefaultSectionTitles()
        //.addPage(.init(path: "/all", content: <#T##Content#>))
    ],
    plugins: [
        .splash(withClassPrefix: ""),
        .darkImage(),
        .itemImage(),
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

extension PublishingStep where Site == PortfolioSite {
    static func addDefaultSectionTitles() -> Self {
        .step(named: "Default section titles") { context in
            context.mutateAllSections { section in
                switch section.id {
                case .projects:
                    section.title = "Проекты"
                case .books:
                    section.title = "Книги"
                case .events:
                    section.title = "Мероприятия"
                case .career:
                    section.title = "Карьера"
                case .achievements:
                    section.title = "Достижения"
                }
            }
        }
    }
}

public extension Plugin {
    static func itemImage(suffix: String = "-dark") -> Self {
        Plugin(name: "DarkItemImage") { context in
            context.markdownParser.addModifier(
                .itemImage(suffix: suffix, context: context)
            )
        }
    }
}

extension Collection where Element: Equatable {
    /// Returns the second index where the specified value appears in the collection.
    func secondIndex(of element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        return self[self.index(after: index)...].firstIndex(of: element)
    }
}

extension Item {
    var id: String {
        let path = self.path.absoluteString
        return String(path[path.lastIndex(of: "/")!..<path.endIndex])
    }
}

public extension Modifier {
    static func itemImage<T: Website>(suffix: String, context: PublishingContext<T>) -> Self {
        Modifier(target: .images) { html, markdown in
            html.replacingOccurrences(of: "src=\"", with: "src=\"/img")
                .replacingOccurrences(of: "srcset=\"", with: "srcset=\"/img")
        }
    }
}
