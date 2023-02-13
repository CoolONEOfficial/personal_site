//
//  File.swift
//  
//
//  Created by Nikolay Truhin on 12/02/23.
//

import Foundation
import Publish

extension Item {
    var id: String {
        let path = self.path.absoluteString
        return String(path[path.lastIndex(of: "/")!..<path.endIndex])
    }
}
