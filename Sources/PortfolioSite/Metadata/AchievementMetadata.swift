//
//  AchievementMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation

public enum AchievementType: String, Codable, CaseIterable {
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

public struct AchievementMetadata: WebsiteItemMetadata {
    public init(type: AchievementType) {
        self.type = type
    }
    
    var type: AchievementType
}
