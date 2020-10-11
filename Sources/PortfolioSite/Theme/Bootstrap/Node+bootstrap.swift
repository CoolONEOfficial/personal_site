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
    var breakpoint: Breakpoint? = nil
    var cols: UInt
    
    var str: String {
        "row-cols\(breakpoint != nil ? "-\(breakpoint!)" : "")-\(cols)"
    }
}

enum RowJustifyConfig: String {
    case start
    case end
    case center
    case around
    case between
    
    var str: String {
        "justify-content-\(rawValue)"
    }
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
        justifyConfig: RowJustifyConfig? = nil,
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
        if let justifyConfig = justifyConfig {
            classStr.append(justifyConfig.str)
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
        _ nodes: Node<HTML.BodyContext>...
    ) -> Node {
        var nodes = nodes
        var configs = configs
        if configs.isEmpty {
            configs.append(.init())
        }
        nodes.append(.class(configs.map { $0.classStr }.joined(separator: " ")))
        return .element(named: "div", nodes: nodes)
    }
}
