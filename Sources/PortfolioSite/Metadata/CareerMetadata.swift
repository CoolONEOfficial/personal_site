//
//  CareerMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Plot

enum JobType: String, Codable, CaseIterable {
    case office
    case contract
    case remote
    case freelance
    case free_schedule
}

extension JobType {
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

public struct CareerMetadata: WebsiteItemMetadata {
    var location: Location?
    var type: JobType
    var position: String
    var achievements: [String]
}
