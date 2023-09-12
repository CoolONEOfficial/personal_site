//
//  File.swift
//  
//
//  Created by Nikolay Truhin on 12/02/23.
//

import Foundation
import Publish
import Plot

extension Section where Site == PortfolioSite {
    var emojiPhrase: LocalizablePhrase {
        switch id {
        case .projects:
            return .projectsEmoji
        case .books:
            return .booksEmoji
        case .events:
            return .eventsEmoji
        case .achievements:
            return .achievementsEmoji
        }
    }

    var titlePhrase: LocalizablePhrase {
        switch id {
        case .projects:
            return .projects
        case .books:
            return .books
        case .events:
            return .events
        case .achievements:
            return .achievements
        }
    }
}
