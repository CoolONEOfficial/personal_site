//
//  Attribute+attrs.swift
//  
//
//  Created by Nickolay Truhin on 10.10.2020.
//

import Foundation
import Publish
import Plot

extension Attribute where Context == HTML.ImageContext {
    static func roundedImage(_ ext: String?, force: Bool) -> Attribute {
        .attribute(named: "style", value: ext == ".jpg" || force ? "border-radius: 20px;" : "")
    }
}
