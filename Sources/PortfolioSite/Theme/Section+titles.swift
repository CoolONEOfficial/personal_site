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
    var phrase: LocalizablePhrase {
        switch id {
        case .projects:
            return .projects
        case .books:
            return .books
        case .events:
            return .events
        case .career:
            return .career
        case .achievements:
            return .achievements
        }
    }
}
