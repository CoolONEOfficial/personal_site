//
//  Section+title.swift
//  
//
//  Created by Nickolay Truhin on 09.05.2022.
//

import Foundation
import Plot
import Publish

extension Section where Site == PortfolioSite {
    public func title(in language: Language) -> String {
        switch language {
        case .russian:
            switch id {
            case .projects:
                return "Проекты"
            case .books:
                return "Книги"
            case .events:
                return "Мероприятия"
            case .career:
                return "Карьера"
            case .achievements:
                return "Достижения"
            }

        default:
            switch id {
            case .projects:
                return "Projects"
            case .books:
                return "Books"
            case .events:
                return "Events"
            case .career:
                return "Career"
            case .achievements:
                return "Achievements"
            }
        }
    }
}
