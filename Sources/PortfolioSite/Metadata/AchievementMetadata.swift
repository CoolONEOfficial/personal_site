//
//  AchievementMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Publish

enum AchievementType: String, Decodable {
    case certificate
    case diploma
}

extension AchievementType {
    var name: String {
        switch self {
        case .certificate:
            return "Сертификат"
        case .diploma:
            return "Диплом"
        }
    }
}

struct AchievementMetadata: WebsiteItemMetadata {
    var type: AchievementType
}
