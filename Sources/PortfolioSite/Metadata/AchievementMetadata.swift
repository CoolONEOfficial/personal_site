//
//  AchievementMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Publish

public enum AchievementType: String, Codable, CaseIterable {
    case certificate
    case diploma
}

public extension AchievementType {
    var name: String {
        switch self {
        case .certificate:
            return "Сертификат"
        case .diploma:
            return "Диплом"
        }
    }
}

public struct AchievementMetadata: WebsiteItemMetadata, Encodable {
    public init(type: AchievementType) {
        self.type = type
    }
    
    public var type: AchievementType
}
