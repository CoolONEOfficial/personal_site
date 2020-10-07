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

enum ProjectPlatform: String, Decodable {
    case mobile
    case desktop
    case android
    case ios
    case web
    case linux
    case mac
}

enum ProjectType: String, Decodable {
    case game
    case app
}

extension ProjectPlatform {
    var icon: String {
        "/projects/icons/\(self).png"
    }
}

struct ProjectMetadata: WebsiteItemMetadata {
    var type: ProjectType
    var platform: ProjectPlatform
    var github: String?
    var app_store: String?
    var google_play: String?
}

extension ProjectType {
    var name: String {
        switch self {
        case .app:
            return "Приложение"
        case .game:
            return "Игра"
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
