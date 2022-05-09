//
//  File.swift
//  
//
//  Created by Nickolay Truhin on 09.05.2022.
//

import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
public struct PortfolioSite: MultiLanguageWebsite {
    public init(url: URL = URL(string: "https://coolone.ru")!) {
        self.url = url
    }
    
    public enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case projects
        case books
        case events
        case career
        case achievements
    }

    public var url = URL(string: "https://coolone.ru")!
    public var names: [Language : String] {
        [
            .russian: "Сайт Николая Трухина",
            .english: "Nikolai Trukhin's website"
        ]
    }
    public var descriptions: [Language : String] {
        [
            .russian: "Здесь собрана вся информация о моих проектах, мероприятиях что я посетил, книгах что прочитал и многое другое",
            .english: "Here is all the information about projects, events, books, and more"
        ]
    }
    public var languages: [Language] { [ .english, .russian ] }
    public var imagePath: Path? { "/avatar.jpg" }
    public var favicon: Favicon? { .init(path: "/avatar.jpg", type: "image/jpg") }
}
