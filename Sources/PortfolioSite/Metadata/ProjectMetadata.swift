//
//  ProjectMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Plot

protocol Iconic {
    var icon: String { get }
}

enum ProjectPlatform: String, Codable, Iconic, CaseIterable {
    case android
    case ios
    case visionos
    case linux
    case mac
    case windows
    case web
    case vk
    case telegram

    var icon: String {
        "/projects/icons/platforms/\(self.rawValue).png"
    }
}

enum ProjectMarketplace: String, Codable, Iconic, CaseIterable {
    case app_store
    case google_play
    case website
    case vk
    case telegram
    case github
    
    var icon: String {
        "/projects/icons/marketplaces/\(self.rawValue).png"
    }
}

enum ProjectType: String, Codable, CaseIterable {
    case game
    case app
    case website
    case chatbot
    case framework
    case library
}

struct ProjectMetadata: WebsiteItemMetadata {
    internal init(type: ProjectType, platforms: [ProjectPlatform], marketplaces: [String]? = nil) {
        self.type = type
        self.platforms = platforms
        self.marketplaces = marketplaces
        self.marketplacesParsed = marketplaces?.reduce([:]) { dict, str in
            let str = str.dropFirst().dropLast()
            guard let dividerIndex = str.firstIndex(of: ":"),
                  let key = ProjectMarketplace(rawValue: .init(str[str.startIndex ..< dividerIndex]).trimmingCharacters(in: .whitespacesAndNewlines)),
                  var dict = dict else { return dict }

            let val = String(str[dividerIndex ..< str.endIndex]).dropFirst().trimmingCharacters(in: .whitespacesAndNewlines)

            dict[key] = val
            return dict
        }
    }
    
    var type: ProjectType
    var platforms: [ProjectPlatform]
    var marketplaces: [String]?
    var marketplacesParsed: [ProjectMarketplace: String]?
}

extension ProjectType {
    var phrase: LocalizablePhrase {
        switch self {
        case .game:
            return .game
        case .app:
            return .app
        case .website:
            return .website
        case .chatbot:
            return .chatbot
        case .framework:
            return .framework
        case .library:
            return .library
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
