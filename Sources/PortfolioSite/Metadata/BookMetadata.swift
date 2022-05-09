//
//  BookMetadata.swift
//  
//
//  Created by Nickolay Truhin on 01.10.2020.
//

import Foundation

public struct BookMetadata: WebsiteItemMetadata {
    public init(author: String, organisation: String? = nil) {
        self.author = author
        self.organisation = organisation
    }
    
    public var author: String
    public var organisation: String?
}
