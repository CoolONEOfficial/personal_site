//
//  CareerMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation

enum JobType: String, Decodable {
    case office
    case contract
    case remote
    case freelance
    case free_schedule
}

extension JobType {
    var name: String {
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
    }
}

struct CareerMetadata: WebsiteItemMetadata {
    var location: Location?
    var type: JobType
    var position: String
    var achievements: [String]
}
