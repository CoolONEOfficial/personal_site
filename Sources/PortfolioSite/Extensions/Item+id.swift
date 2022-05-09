//
//  Item+id.swift
//  
//
//  Created by Nickolay Truhin on 09.05.2022.
//

import Publish

extension Item {
    var id: String {
        let path = self.path.absoluteString
        return String(path[path.lastIndex(of: "/")!..<path.endIndex])
    }
}
