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

public extension AchievementType {
    func name(for language: Language) -> String {
        switch language {
        case .russian:
            switch self {
            case .certificate:
                return "Сертификат"
            case .diploma:
                return "Диплом"
            case .medal:
                return "Медаль"
            }
            
        default:
            switch self {
            case .certificate:
                return "Certificate"
            case .diploma:
                return "Diploma"
            case .medal:
                return "Medal"
            }
        }
    }
}

public struct AchievementMetadata: WebsiteItemMetadata, Encodable {
    public init(type: AchievementType) {
        self.type = type
    }
    
    public var type: AchievementType
}
