//
//  Types.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation
import Publish

public struct Location: WebsiteItemMetadata, Encodable {
    var latitude: Double
    var longitude: Double
    var title: String
}
