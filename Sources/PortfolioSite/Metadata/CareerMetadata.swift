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
    case freeSchedule = "free_schedule"
}

extension JobType {
    var phrase: LocalizablePhrase {
        switch self {
        case .office:
            return .office
        case .contract:
            return .contract
        case .remote:
            return .remote
        case .freelance:
            return .freelance
        case .freeSchedule:
            return .freeSchedule
        }
    }
}

struct CareerMetadata: WebsiteItemMetadata {
    var location: Location?
    var type: JobType
    var position: String
    var achievements: [String]
}
