//
//  AchievementMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Publish
import Plot

public enum AchievementType: String, Codable, CaseIterable {
    case certificate
    case diploma
    case medal
}

extension AchievementType {
    var phrase: LocalizablePhrase {
        switch self {
        case .certificate:
            return .certificate
        case .diploma:
            return .diploma
        case .medal:
            return .medal
        }
    }
}

struct AchievementMetadata: WebsiteItemMetadata {
    var type: AchievementType
    var organisation: String?
}
