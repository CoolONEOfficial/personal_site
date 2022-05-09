//
//  CareerMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Plot
import Publish

public enum JobType: String, Codable, CaseIterable {
    case office
    case contract
    case remote
    case freelance
    case free_schedule
}

public extension JobType {
    func name(in language: Language) -> String {
        switch language {
        case .russian:
            switch self {
            case .office:
                return "в офисе"
            case .contract:
                return "по контракту"
            case .remote:
                return "удаленка"
            case .freelance:
                return "на фрилансе"
            case .free_schedule:
                return "свободный график"
            }
            
        default:
            switch self {
            case .office:
                return "office"
            case .contract:
                return "contract"
            case .remote:
                return "remote"
            case .freelance:
                return "freelance"
            case .free_schedule:
                return "free schedule"
            }
        }
        
    }
}

public struct CareerMetadata: WebsiteItemMetadata, Encodable {
    public init(location: Location? = nil, type: JobType, position: String, achievements: [String]) {
        self.location = location
        self.type = type
        self.position = position
        self.achievements = achievements
    }
    
    public var location: Location?
    public var type: JobType
    public var position: String
    public var achievements: [String]
}
