//
//  Types.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation

#if os(iOS)
public typealias WebsiteItemMetadata = Codable & Hashable
#else
import Publish
public typealias WebsiteItemMetadata = Publish.WebsiteItemMetadata
#endif

struct Location: WebsiteItemMetadata {
    var latitude: Double
    var longitude: Double
    var title: String
}
