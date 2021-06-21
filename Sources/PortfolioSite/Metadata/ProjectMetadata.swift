//
//  ProjectMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Publish
import Plot
import Ink

protocol Iconic {
    var icon: String { get }
}

enum ProjectPlatform: String, Decodable, Iconic {
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

enum ProjectMarketplace: String, Decodable, Iconic {
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

enum ProjectType: String, Decodable {
    case game
    case app
    case website
    case chatbot
}

struct ProjectMetadata: WebsiteItemMetadata {
    var type: ProjectType
    var platforms: [ProjectPlatform]
    var marketplaces: [String]?
    lazy var marketplacesParsed: [ProjectMarketplace: String]? = marketplaces?.reduce([:]) { dict, str in
        var str = str.dropFirst().dropLast()
        guard let dividerIndex = str.firstIndex(of: ":"),
              let key = ProjectMarketplace(rawValue: .init(str[str.startIndex ..< dividerIndex]).trimmingCharacters(in: .whitespacesAndNewlines)),
              var dict = dict else { return dict }

        let val = String(str[dividerIndex ..< str.endIndex]).dropFirst().trimmingCharacters(in: .whitespacesAndNewlines)

        dict[key] = val
        return dict
    }
}

extension ProjectType {
    var name: String {
        switch self {
        case .app:
            return "Приложение"

        case .game:
            return "Игра"

        case .website:
            return "Сайт"

        case .chatbot:
            return "Чат-бот"
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
