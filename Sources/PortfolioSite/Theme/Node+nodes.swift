//
//  Node+nodes.swift
//  
//
//  Created by Nickolay Truhin on 10.10.2020.
//

import Foundation
import Publish
import Plot

extension Node where Context == HTML.BodyContext {
    static func makeItemsPageContent(context: PublishingContext<PortfolioSite>, items: [Item<PortfolioSite>], pageIndex: Int, lastPage: Bool) -> Node {
        let navNode: Node<HTML.BodyContext> = .div(
            .style("margin: 10px"),
            .table(
                .tr(
                    .th(
                        .if(pageIndex > 1, .a(
                            .text("Назад"),
                            .href("/items/\(pageIndex - 1)")
                        )),
                        .class("pagination-prev")
                    ),
                    .th(
                        .h4(.text("Страница \(pageIndex)")),
                        .class("pagination-title")
                    ),
                    .th(
                        .if(!lastPage, .a(
                            .text("Вперед"),
                            .href("/items/\(pageIndex + 1)")
                        )),
                        .class("pagination-next")
                    )
                )
            )
        )
        return .div(
            .h1(.text("Последние посты")),
            
            navNode,
            .itemList(
                for: items,
                on: context.site,
                context: context
            ),
            navNode
        )
    }

    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header(
        for context: PublishingContext<PortfolioSite>,
        selectedSection: PortfolioSite.SectionID?
    ) -> Node {
        var sectionIDs: [PortfolioSite.SectionID?] = PortfolioSite.SectionID.allCases
        sectionIDs.insert(nil, at: sectionIDs.count / 2 + 1)

        return .header(
            .wrapper(
                .row(justifyConfigs: [
                        .init(type: .between, breakpoint: .md),
                        .init(type: .center)
                    ],
                    .col([.init(size: .auto)],
                         .row(gutters: true,
                            .col([.init(size: .auto, breakpoint: .md)],
                                .img(
                                    .src("/img/avatar.jpg"),
                                    .class("logo")
                                )
                            ),
                            .col([],
                                .div(
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
                                )
                            )
                        )
                    ),
                    .col([.init(size: .auto, breakpoint: .md)],
                        .row(justifyConfigs: [
                                .init(type: .end, breakpoint: .md),
                                .init(type: .center)
                            ],
                            .forEach(sectionIDs) { section in
                                if let section = section {
                                    return .col([.init(size: .auto)],
                                        .a(
                                            .class(
                                                section == selectedSection ? "selected" : "",
                                                .spacing([ .init(type: .margin, size: 2, side: .horizontal) ])
                                            ),
                                            .href(context.sections[section].path),
                                            .text(context.sections[section].title)
                                        )
                                    )
                                } else {
                                    return .element(named: "div", nodes: [ .class("header-wrap") ])
                                }
                            }
                        )
                    )
                )
                
            )
        )
    }

    static func itemList(
        for items: [Item<PortfolioSite>],
        on site: PortfolioSite,
        context: PublishingContext<PortfolioSite>,
        sectionShow: Bool = true
    ) -> Node {
        .ul(
            .class("item-list"),
            .forEach(items) { $0.node(on: site, context: context, sectionShow: sectionShow)}
        )
    }
    
    static func footer(for site: PortfolioSite) -> Node {
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
    
    static func adaptiveImage(_ path: String, _ altText: String, context: PublishingContext<PortfolioSite>) -> Node {
        let html = context.markdownParser.html(from: "![\(altText)](\(path))")
        return .contentBody(Content.Body(html: html))
    }
    
    static func icon(_ path: String, context: PublishingContext<PortfolioSite>) -> Node {
        .adaptiveImage(path, "icon", context: context)
    }
}

public extension Node where Context: HTMLContext {
    /// Assign a class name to the current element. May also be a list of
    /// space-separated class names.
    static func `class`(_ classNames: String...) -> Node {
        .class(classNames.joined(separator: " "))
    }
    
    static func `class`(_ classNames: [String]) -> Node {
        .class(classNames.joined(separator: " "))
    }
}
