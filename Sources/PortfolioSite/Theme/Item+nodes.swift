//
//  Item+nodes.swift
//  
//
//  Created by Nickolay Truhin on 10.10.2020.
//

import Foundation
import Plot
import Publish
import Ink

extension Item where Site == PortfolioSite {
    static var itemDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    func node(on site: PortfolioSite, context: PublishingContext<PortfolioSite>, sectionShow: Bool) -> Node<HTML.ListContext> {
        let html = MarkdownParser().html(from: description)
        return .li(.article(
            .row(justifyConfigs: [.init(type: .center)],
                .col([],
                    header(context: context, sectionShow: sectionShow),
                    .div(
                        .class("item-description"),
                        .contentBody(Content.Body(html: html))
                    ),
                    singleImage(hideOnSm: false),
                    footer(on: site, context: context)
                ),
                .col([.init(size: .auto, breakpoint: .sm)],
                     .div(
                        .class(.spacing([
                            .init(type: .margin, size: 3, side: .left, breakpoint: .sm),
                            .init(type: .margin, size: 0, side: .left)
                        ])),
                        singleImage(hideOnSm: true)
                     )
                )
            )
        ))
    }
    
    private func singleImage(hideOnSm: Bool) -> Node<HTML.BodyContext> {
        .div(
           .class(
               .spacing([
                   .init(type: .margin, size: 3, side: .vertical),
                   .init(type: .margin, size: 0, side: .vertical, breakpoint: .sm)
               ]),
               .display([
                .init(type: hideOnSm ? .block : .none, breakpoint: .sm),
                .init(type: hideOnSm ? .none : .block)
               ])
           ),
           image("singleImage", metadata.singleImage)
        )
    }
    
    func footer(
        on site: PortfolioSite,
        context: PublishingContext<PortfolioSite>
    ) -> Node<HTML.BodyContext> {
        var dateStr = Item<PortfolioSite>.itemDateFormatter.string(from: date)
        if let endDate = metadata.parsedEndDate {
            dateStr += " — " + Item<PortfolioSite>.itemDateFormatter.string(from: endDate)
        } else if sectionID == .career {
            dateStr += " — по настоящее время"
        }
        
        return .row(
            .col([], verticalSpacing: true,
                tagList(on: site)
            ),
            .col([.init(size: .auto)], verticalSpacing: true,
                .span(
                    .text(dateStr),
                    .class("item-date")
                )
            )
        )
    }
    
    func header(
        context: PublishingContext<PortfolioSite>,
        sectionShow: Bool = true
    ) -> Node<HTML.BodyContext> {
        .row(
            .col([.init(size: .auto)],
                 image("logo", metadata.logo)
            ),
            .col([.init(breakpoint: .md)],
                .h1(.a(
                    .href(path),
                    .text(title)
                )),
                subheader(context: context, sectionShow: sectionShow)
            )
        )
    }
    
    func subheader(
        context: PublishingContext<PortfolioSite>,
        sectionShow: Bool = true
    ) -> Node<HTML.BodyContext> {
        let section = context.sections[sectionID]

        var subNode: Node<HTML.BodyContext>?
        switch sectionID {
        case .projects:
            guard let metaProject = metadata.project else { break }
            let iconUrl = metaProject.platform.icon
            subNode = .row(
                classSuffix: .spacing([ .init(type: .margin, size: 1, side: .top) ]),
                .col([.init(size: .auto)],
                     .icon(iconUrl, context: context)
                ),
                .col([],
                    .h4(
                        .text(metaProject.type.name)
                    )
                )
            )
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
                metaCareer.position + ", " + metaCareer.type.name
            ))
        case .achievements:
            guard let metaAchievement = metadata.achievement else { break }
            subNode = .h4(.text(
                metaAchievement.type.name
            ))
        }
        
        return .div(
            .if(sectionShow,
                .h4(.a(
                    .href(section.path),
                    .text(section.title)
                ))
            ),
            subNode ?? .div()
        )
    }

    func tagList(on site: PortfolioSite) -> Node<HTML.BodyContext> {
        .ul(.class("tag-list"), .forEach(tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    
    func image(
        _ name: String,
        _ ext: String?,
        classPrefix: String = "",
        alt: String = "",
        preview: Bool = true
    ) -> Node<HTML.BodyContext> {
        .if(ext != nil,
            .img(
                .src("/img/\(path)/\(name)\(preview ? "_400x400" : "")\(ext ?? "")"),
                .alt(alt),
                .class("item-\(classPrefix)\(name)"),
                .roundedImage(ext)
            )
        )
    }
}
