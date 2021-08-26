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
    static var portfolio: Theme<PortfolioSite> {
        Theme<PortfolioSite>(
            htmlFactory: PortfolioHTMLFactory(),
            resourcePaths: [
                "Resources/css/styles.css",
                "Resources/css/splash.css"
            ]
        )
    }
}

struct PortfolioHTMLFactory: HTMLFactory {
    static let cssPaths: [Path] = [
        "/styles.css",
        "/modules/tiny-slider/dist/tiny-slider.css",
        "/modules/bootstrap/dist/css/bootstrap-grid.min.css"
    ]
    
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<PortfolioSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site, stylesheetPaths: PortfolioHTMLFactory.cssPaths),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .div(
                        .class("welcome-block"),
                        .div(
                            .class("content", .spacing([ .init(type: .margin, size: 2, side: .vertical) ])),
                            .contentBody(index.body)
                        )
                    ),
                    .h2("Хронология", .style("text-align: center; margin: 30px 0;")),
                    .itemList(
                        for: Array(context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ).prefix(10)),
                        on: context.site,
                        context: context
                    ),
                    .a(
                        .href(Path("/items/2")),
                        .h2("Остальные посты →", .style("text-align: center"))
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<PortfolioSite>,
                         context: PublishingContext<PortfolioSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site, stylesheetPaths: PortfolioHTMLFactory.cssPaths),
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

    func makeItemHTML(for item: Item<PortfolioSite>,
                      context: PublishingContext<PortfolioSite>) throws -> HTML {
        let metadata = item.metadata
        var item = item
        let html = item.body.html
        if let startHeadIndex = html.index(of: "<h1>"),
           let endHeadIndex = html.endIndex(of: "</h1>") {
            item.body.html.removeSubrange(startHeadIndex..<endHeadIndex)
        }
        let showRightSingleImage = metadata.singleImage != nil && metadata.logo == nil
        return HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site, stylesheetPaths: PortfolioHTMLFactory.cssPaths),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .row(gutters: showRightSingleImage,
                            .col([.init(breakpoint: .sm)],
                                item.header(context: context),
                                .div(
                                    .class("content", .spacing([ .init(type: .margin, size: 2, side: .vertical) ])),
                                    .contentBody(item.body)
                                ),
                                .if(metadata.singleImage != nil && metadata.logo != nil,
                                    .div(
                                        .class(
                                            .spacing([
                                                .init(type: .margin, size: 3, side: .vertical)
                                            ])
                                        ),
                                        item.image(
                                            "singleImage",
                                            metadata.singleImage,
                                            classPrefix: "big-",
                                            preview: false
                                        )
                                    )
                                ),
                                .forEach(metadata.videos ?? []) { video in
                                    .video(video)
                                },
                                item.footer(on: context.site, context: context)
                            ),
                            .col([.init(size: .auto, breakpoint: .sm)],
                                .if(showRightSingleImage,
                                    item.image(
                                        "singleImage",
                                        metadata.singleImage
                                    )
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

    func makePageHTML(for page: Publish.Page,
                      context: PublishingContext<PortfolioSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: PortfolioHTMLFactory.cssPaths),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<PortfolioSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: PortfolioHTMLFactory.cssPaths),
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
                            context: PublishingContext<PortfolioSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: PortfolioHTMLFactory.cssPaths),
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
