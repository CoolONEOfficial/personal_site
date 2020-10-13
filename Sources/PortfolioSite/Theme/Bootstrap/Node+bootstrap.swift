//
//  Node+bootstrap.swift
//  
//
//  Created by Nickolay Truhin on 10.10.2020.
//

import Foundation
import Publish
import Plot

public extension HTML {
    enum BootstrapRowContext: HTMLContext {}
}

enum Breakpoint: String {
    case xs
    case sm
    case md
    case lg
    case xl
}

enum ColSize: String {
    case _1
    case _2
    case _3
    case _4
    case _8
    case _9
    case _10
    case _11
    case _12
    case auto
}

extension ColSize {
    var sizeStr: String {
        switch self {
        case .auto:
            return self.rawValue
        default:
            return String(self.rawValue.dropFirst())
        }
    }
}

struct ColConfig {
    var size: ColSize? = nil
    var breakpoint: Breakpoint? = nil
}

extension ColConfig {
    var classStr: String {
        "col" + (breakpoint != nil ? "-\(breakpoint!)" : "") + (size != nil ? "-\(size!.sizeStr)" : "")
    }
}

struct RowColsConfig {
    var cols: UInt
    var breakpoint: Breakpoint? = nil
    
    var str: String {
        "row-cols\(breakpoint != nil ? "-\(breakpoint!)" : "")-\(cols)"
    }
}

struct RowJustifyConfig {
    var type: RowJustifyType
    var breakpoint: Breakpoint? = nil
    
    var str: String {
        "justify-content-\(breakpoint != nil ? "\(breakpoint!.rawValue)-" : "")\(type.rawValue)"
    }
}

enum RowJustifyType: String {
    case start
    case end
    case center
    case around
    case between
}

enum RowAlignConfig: String {
    case start
    case end
    case center
    
    var str: String {
        "align-items-\(rawValue)"
    }
}

enum Side: String {
    case bottom = "b"
    case top = "t"
    case left = "l"
    case right = "r"
    case horizontal = "x"
    case vertical = "y"
}

extension Node where Context == HTML.BodyContext {
    static func row(
        colsConfig: RowColsConfig? = nil,
        justifyConfigs: [RowJustifyConfig] = [],
        alignConfig: RowAlignConfig? = .center,
        gutters: Bool = false,
        classSuffix: String = "",
        _ nodes: Node<HTML.BootstrapRowContext>...
    ) -> Node {
        var nodes = nodes
        var classStr = ["row"]
        if !gutters {
            classStr.append("no-gutters")
        }
        if let colsConfig = colsConfig {
            classStr.append(colsConfig.str)
        }
        for config in justifyConfigs {
            classStr.append(config.str)
        }
        if let alignConfig = alignConfig {
            classStr.append(alignConfig.str)
        }
        nodes.append(.class(classStr.joined(separator: " ") + " \(classSuffix)"))
        return .element(named: "div", nodes: nodes)
    }
}

extension Node where Context == HTML.BootstrapRowContext {
    static func col(
        _ configs: [ColConfig],
        verticalSpacing: Bool = false,
        _ nodes: Node<HTML.BodyContext>...
    ) -> Node {
        var nodes = nodes
        var configs = configs
        if configs.isEmpty {
            configs.append(.init())
        }
        var classArr = configs.map { $0.classStr }
        if verticalSpacing {
            classArr.append(.spacing([ .init(type: .margin, size: 1, side: .vertical) ]))
        }
        nodes.append(.class(classArr))
        return .element(named: "div", nodes: nodes)
    }
}
