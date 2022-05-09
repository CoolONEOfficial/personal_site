//
//  EventMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Publish

public enum EventType: String, Codable, CaseIterable {
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

public struct EventMetadata: WebsiteItemMetadata, Encodable {
    public init(location: Location? = nil, place: Int? = nil, type: EventType) {
        self.location = location
        self.place = place
        self.type = type
    }
    
    public var location: Location?
    public var place: Int?
    public var type: EventType
}
