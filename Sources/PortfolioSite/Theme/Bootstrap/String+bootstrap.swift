//
//  File.swift
//  
//
//  Created by Nickolay Truhin on 11.10.2020.
//

import Foundation
import Publish
import Plot

struct SpacingConfig {
    var type: SpacingType
    var size: Int
    var side: Side?
    var breakpoint: Breakpoint?
}

enum SpacingType: String {
    case padding = "p"
    case margin = "m"
}

extension String {
    static func spacing(
        _ configs: [SpacingConfig]
    ) -> Self {
        var baseStr = [String]()
        for config in configs {
            var str = [config.type.rawValue]
            if let side = config.side {
                str[0] = str[0] + side.rawValue
            }
            if let breakpoint = config.breakpoint {
                str.append(breakpoint.rawValue)
            }
            str.append(String(config.size).replacingOccurrences(of: "-", with: "n"))
            baseStr.append(str.joined(separator: "-"))
        }
        return baseStr.joined(separator: " ")
    }
}

struct DisplayConfig {
    var type: DisplayType
    var breakpoint: Breakpoint?
}

enum DisplayType: String {
    case none
    case inline
    case iblock = "inline-block"
    case block
    case table
    case tcell = "table-cell"
    case trow = "table-row"
    case flex
    case iflex = "inline-flex"
}

extension String {
    static func display(
        _ configs: [DisplayConfig]
    ) -> Self {
        var baseStr = [String]()
        for config in configs {
            var str = ["d"]
            if let breakpoint = config.breakpoint {
                str.append(breakpoint.rawValue)
            }
            str.append(config.type.rawValue)
            baseStr.append(str.joined(separator: "-"))
        }
        return baseStr.joined(separator: " ")
    }
}
