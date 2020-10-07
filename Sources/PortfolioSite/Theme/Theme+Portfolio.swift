//
//  File.swift
//  
//
//  Created by Nickolay Truhin on 29.09.2020.
//

import Foundation

import Plot
import Publish
import Ink

public extension Theme {
    static var portfolio: Self {
        Theme(
            htmlFactory: PortfolioHTMLFactory(),
            resourcePaths: [
                "Resources/css/styles.css",
                "Resources/css/splash.css"
            ]
        )
    }
}

private struct PortfolioHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(.text(index.title)),
                    .p(
                        .class("description"),
                        .text(context.site.description)
                    ),
                    .h2("Хронология", .style("text-align: center; margin-bottom: 30px;")),
                    .itemList(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site,
                        context: context
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .h1(.text(section.title)),
                    .itemList(for: section.items, on: context.site, context: context, sectionShow: false)
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        guard let metadata = item.metadata as? PortfolioSite.ItemMetadata else { return HTML(.text("error")) }
        return HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site, stylesheetPaths: [
                    "/styles.css",
                    "/modules/tiny-slider/dist/tiny-slider.css"
            ]),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .row(
                            .div(
                                .if(metadata.logo != nil,
                                    .image(for: item, "logo", metadata.logo, alt: "item-right")
                                ),
                                .div(
                                    .class("content"),
                                    .contentBody(item.body)
                                ),
                                .if(metadata.singleImage != nil && metadata.logo != nil,
                                    .image(
                                        for: item,
                                        "singleImage",
                                        metadata.singleImage,
                                        classPrefix: "big-",
                                        preview: false
                                    )
                                ),
                                .itemHeader(for: item, context: context),
                                .div(.style("height: 5px;")),
                                .tagList(for: item, on: context.site)
                            ),
                            .if(metadata.singleImage != nil && metadata.logo == nil,
                                .image(
                                    for: item,
                                    "singleImage",
                                    metadata.singleImage
                                )
                            )
                        )
                    ),
                    .script(
                        .src("https://utteranc.es/client.js"),
                        .attribute(named: "repo", value: "CoolONEOfficial/personal_site_utterances"),
                        .attribute(named: "issue-term", value: "pathname"),
                        .attribute(named: "theme", value: "github-dark"),
                        .attribute(named: "crossorigin", value: "anonymous"),
                        .attribute(named: "async")
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Другие теги"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Записи с ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Другие теги"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site,
                        context: context
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .img(
                    .src("/img/avatar.jpg"),
                    .class("logo")
                ),
                .div(
                    .class("logo-column"),
                    .a(
                        .href("/"),
                        .p(
                            .class("logo-title"),
                            .text("Николай Трухин")
                        ),
                        .p(
                            .class("logo-subtitle"),
                            .text("iOS разработчик")
                        )
                    )
                ),
                .div(
                    .class("header-right"),
                    .forEach(sectionIDs) { section in
                        .a(
                            .class(section == selectedSection ? "selected" : ""),
                            .href(context.sections[section].path),
                            .text(context.sections[section].title)
                        )
                    }
                )
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T, context: PublishingContext<T>, sectionShow: Bool = true) -> Node {
        .ul(
            .class("item-list"),
            .forEach(items) { .item(for: $0, on: site, context: context, sectionShow: sectionShow)}
        )
    }
    
    static func row(_ left: Node, _ right: Node) -> Node {
        .table( .tr(
            .th(left),
            .th(right)
        ))
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Сгенерировано с помощью "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS лента"),
                .href("/feed.rss")
            ))
        )
    }
    
    static func image<T: Website>(for item: Item<T>, _ name: String, _ ext: String?, classPrefix: String = "", alt: String = "", preview: Bool = true) -> Node {
        .if(ext != nil,
            .img(
                .src("/img/\(item.path)/\(name)\(preview ? "_400x400" : "")\(ext ?? "")"),
                .alt(alt),
                .class("item-\(classPrefix)\(name)"),
                .roundedImage(ext)
            )
        )
    }
    
    static func adaptiveImage<T: Website>(_ path: String, _ altText: String, context: PublishingContext<T>) -> Node {
        let html = context.markdownParser.html(from: "![\(altText)](\(path))")
        return .contentBody(Content.Body(html: html))
    }
    
    static func icon<T: Website>(_ path: String, context: PublishingContext<T>) -> Node {
        .adaptiveImage(path, "icon", context: context)
    }
    
    static func itemHeader<T: Website>(
        for item: Item<T>,
        context: PublishingContext<T>,
        sectionShow: Bool = true
    ) -> Node {
        guard let item = item as? Item<PortfolioSite>,
              let context = context as? PublishingContext<PortfolioSite> else { return .text("error") }
        
        let metadata = item.metadata
        let sectionId = item.sectionID
        let section = context.sections[sectionId]
        
        var subNode: Node<HTML.BodyContext>?
        var sameLine: Bool = false
        switch sectionId {
        case .projects:
            guard let metaProject = metadata.project else { break }
            let iconUrl = metaProject.platform.icon
            subNode = .row(
                .h4(
                    .text(metaProject.type.name + " для"),
                    .style("margin-right: 8px;")
                ),
                .icon(iconUrl, context: context)
            )
            
            sameLine = true
        case .books:
            guard let metaBook = metadata.book else { break }
            subNode = .h4(.text(
                metaBook.author
            ))
        case .events:
            guard let metaEvent = metadata.event else { break }
            subNode = .h4(.text(
                metaEvent.location?.title ?? ""
            ))
        case .career:
            guard let metaCareer = metadata.career else { break }
            subNode = .h4(.text(
                ""//metaBook.author
            ))
        case .achievements:
            guard let metaAchievement = metadata.achievement else { break }
            subNode = .h4(.text(
                metaAchievement.type.name
            ))
        }
        
        return .div(
            .row(
                .if(sameLine, subNode ?? .div()),
                .if(sectionShow,
                    .h4(.a(
                        .href(section.path),
                        .text(section.title)
                    ))
                )
            ),
            .if(!sameLine && subNode != nil, .div(subNode ?? .div(), .class("item-sameLine")))
        )
    }
}

private extension Attribute where Context == HTML.ImageContext {
    static func roundedImage(_ ext: String?) -> Attribute {
        .attribute(named: "style", value: ext == ".jpg" ? "border-radius: 20px;" : "")
    }
}

private extension Node where Context == HTML.ListContext {
    
    static func item<T: Website>(for item: Item<T>, on site: T, context: PublishingContext<T>, sectionShow: Bool) -> Node {
        guard let item = item as? Item<PortfolioSite>,
              let site = site as? PortfolioSite,
              let context = context as? PublishingContext<PortfolioSite> else { return .text("error") }
        let metadata = item.metadata
        let html = MarkdownParser().html(from: item.description)
        
        return .li(.article(
            .row(
                .div(
                    .row(
                        .image(for: item, "logo", metadata.logo),
                        .div(
                            .h1(.a(
                                .href(item.path),
                                .text(item.title)
                            )),
                            .itemHeader(for: item, context: context, sectionShow: sectionShow)
                        )
                    ),
                    .contentBody(Content.Body(html: html)),
                    .tagList(for: item, on: site)
                ),
                .image(for: item, "singleImage", metadata.singleImage)
            )
        ))
    }
}
