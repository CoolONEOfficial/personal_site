//
//  EventMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation

enum EventType: String, Decodable {
    case other
    case hack
    case meetup
    case conference
    case webinar
    case lecture
    case training
    case master_class
    case forum
    case tournament
    case competition
    case exhibition
    case festival
    case round_table
    case study
    case excursion
    case course
}

struct EventMetadata: WebsiteItemMetadata {
    var location: Location?
    var place: Int?
    var type: EventType
}
