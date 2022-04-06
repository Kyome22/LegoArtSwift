//
//  LegoColor.swift
//
//
//  Created by Takuto Nakamura on 2021/10/10.
//
//  Color Guid of Bricklink.com
//  https://www.bricklink.com/catalogColors.asp

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public struct LegoColor: Equatable {
    public let name: String
    public let color: CGColor
    public let bricklinkID: Int

    init(id: Int, red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1, name: String) {
        self.name = name
        self.color = CGColor(srgbRed: red, green: green, blue: blue, alpha: alpha)
        self.bricklinkID = id
    }

    func diff(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat {
        guard let rgba = self.color.rgba else {
            fatalError("Impossible")
        }
        return abs(rgba.r - red) + abs(rgba.g - green) + abs(rgba.b - blue)
    }

    public static func == (lhs: LegoColor, rhs: LegoColor) -> Bool {
        return lhs.name == rhs.name
    }
}
