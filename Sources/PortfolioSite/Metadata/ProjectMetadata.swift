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
    func name(in language: Language) -> String {
        switch language {
        case .russian:
            switch self {
            case .app:
                return "Приложение"

            case .game:
                return "Игра"

            case .website:
                return "Сайт"

            case .chatbot:
                return "Чат-бот"

            case .framework:
                return "Фреймворк"
            }
            
        default:
            switch self {
            case .app:
                return "App"

            case .game:
                return "Game"

            case .website:
                return "Website"

            case .chatbot:
                return "Chatbot"

            case .framework:
                return "Framework"
            }
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
