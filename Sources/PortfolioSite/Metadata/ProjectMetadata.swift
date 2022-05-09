//
//  ProjectMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Plot
import Publish

protocol Iconic {
    var icon: String { get }
}

public enum ProjectPlatform: String, Codable, Iconic, CaseIterable {
    case android
    case ios
    case linux
    case mac
    case windows
    case web
    case vk
    case telegram

    public var icon: String {
        "/projects/icons/platforms/\(self.rawValue).png"
    }
}

public enum ProjectMarketplace: String, Codable, Iconic, CaseIterable {
    case app_store
    case google_play
    case website
    case vk
    case telegram
    case github
    
    public var icon: String {
        "/projects/icons/marketplaces/\(self.rawValue).png"
    }
}

public enum ProjectType: String, Codable, CaseIterable {
    case game
    case app
    case website
    case chatbot
    case framework
}

public struct ProjectMetadata: WebsiteItemMetadata, Encodable {
    public init(type: ProjectType, platforms: [ProjectPlatform], marketplaces: [String]? = nil) {
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
    
    public var type: ProjectType
    public var platforms: [ProjectPlatform]
    public var marketplaces: [String]?
    public var marketplacesParsed: [ProjectMarketplace: String]?
}

public extension ProjectType {
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
