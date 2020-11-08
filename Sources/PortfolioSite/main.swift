import Foundation
import Publish
import Ink
import Plot
import SplashPublishPlugin
import DarkImagePublishPlugin
import TinySliderPublishPlugin
import FTPPublishDeploy
import Files

// This type acts as the configuration for your website.
public struct PortfolioSite: Website {
    public enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case projects
        case books
        case events
        case career
        case achievements
    }

    public struct ItemMetadata: WebsiteItemMetadata {
        var project: ProjectMetadata?
        var event: EventMetadata?
        var career: CareerMetadata?
        var book: BookMetadata?
        var achievement: AchievementMetadata?
        
        var videos: [String]?
        var logo: String?
        var singleImage: String?
        var endDate: String?
    }

    public var url = URL(string: "https://coolone.ru")!
    public var name = "Сайт Николая Трухина"
    public var description = "Здесь собрана вся информация проектах, мероприятиях, книгах и многое другое"
    public var language: Language { .russian }
    public var imagePath: Path? { "/img/avatar.jpg" }
    public var favicon: Favicon? { .init(path: "/img/avatar.jpg", type: "image/jpg") }
}

extension PortfolioSite.ItemMetadata {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }()
    
    var parsedEndDate: Date? {
        if let endDate = endDate {
            return PortfolioSite.ItemMetadata.dateFormatter.date(from: endDate)
        }
        return nil
    }
}

let file = try File(path: #file)
guard let ftpConnection = try FTPConnection(file: file) else {
    throw FilesError(path: file.path, reason: LocationErrorReason.missing)
}

// This will generate your website using the built-in Foundation theme:
try PortfolioSite().publish(
    withTheme: .portfolio,
    deployedUsing: .ftp(connection: ftpConnection, useSSL: false),
    additionalSteps: [
        .addDefaultSectionTitles(),
        .addItemPages()
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
    
    static func addItemPages() -> Self {
        .step(named: "Add items pages") { context in
            let chunks = context.allItems(
                sortedBy: \.date,
                order: .descending
            ).chunked(into: 10)
            for (index, chunk) in chunks.enumerated() {
                let index = index + 1
                context.addPage(.init(path: "/items/\(index)", content: .init(
                    title: "Все посты",
                    description: "Список всех постов",
                    body: .init(node: .makeItemsPageContent(
                        context: context,
                        items: chunk,
                        pageIndex: index,
                        lastPage: chunks.count == index
                    ))
                )))
            }
        }
    }
}

extension Plugin {
    static func itemImage(suffix: String = "-dark") -> Self {
        Plugin(name: "DarkItemImage") { context in
            context.markdownParser.addModifier(
                .itemImage(suffix: suffix, context: context)
            )
        }
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
