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

public extension LegoColor {
    static let white =               SolidColors[0_]
    static let vertLightGray =       SolidColors[1_]
    static let veryLightBluishGray = SolidColors[2_]
    static let lightBluishGray =     SolidColors[3_]
    static let lightGray =           SolidColors[4_]
    static let darkGray =            SolidColors[5_]
    static let darkBluishGray =      SolidColors[6_]
    static let black =               SolidColors[7_]
    static let darkRed =             SolidColors[8_]
    static let red =                 SolidColors[9_]
    static let rust =                SolidColors[10]
    static let coral =               SolidColors[11]
    static let darkSalmon =          SolidColors[12]
    static let salmon =              SolidColors[13]
    static let lightSalmon =         SolidColors[14]
    static let sandRed =             SolidColors[15]
    static let reddishBrown =        SolidColors[16]
    static let brown =               SolidColors[17]
    static let darkTan =             SolidColors[18]
    static let tan =                 SolidColors[19]
    static let lightNougat =         SolidColors[20]
    static let nougat =              SolidColors[21]
    static let mediumNougat =        SolidColors[22]
    static let darkNougat =          SolidColors[23]
    static let mediumBrown =         SolidColors[24]
    static let fabulandBrown =       SolidColors[25]
    static let fabulandOrange =      SolidColors[26]
    static let earthOrange =         SolidColors[27]
    static let darkOrange =          SolidColors[28]
    static let neonOrange =          SolidColors[29]
    static let orange =              SolidColors[30]
    static let mediumOrange =        SolidColors[31]
    static let brightLightOrange =   SolidColors[32]
    static let lightOrange =         SolidColors[33]
    static let veryLightOrange =     SolidColors[34]
    static let darkYellow =          SolidColors[35]
    static let yellow =              SolidColors[36]
    static let brightLightYellow =   SolidColors[37]
    static let lightYellow =         SolidColors[38]
    static let lightLime =           SolidColors[39]
    static let yellowishGreen =      SolidColors[40]
    static let neonGreen =           SolidColors[41]
    static let mediumLime =          SolidColors[42]
    static let lime =                SolidColors[43]
    static let oliveGreen =          SolidColors[44]
    static let darkGreen =           SolidColors[45]
    static let green =               SolidColors[46]
    static let brightGreen =         SolidColors[47]
    static let mediumGreen =         SolidColors[48]
    static let lightGreen =          SolidColors[49]
    static let sandGreen =           SolidColors[50]
    static let darkTurquoise =       SolidColors[51]
    static let lightTurquoise =      SolidColors[52]
    static let aqua =                SolidColors[53]
    static let lightAqua =           SolidColors[54]
    static let darkBlue =            SolidColors[55]
    static let blue =                SolidColors[56]
    static let darkAzure =           SolidColors[57]
    static let mediumAzure =         SolidColors[58]
    static let mediumBlue =          SolidColors[59]
    static let maerskBlue =          SolidColors[60]
    static let brightLightBlue =     SolidColors[61]
    static let lightBlue =           SolidColors[62]
    static let skyBlue =             SolidColors[63]
    static let sandBlue =            SolidColors[64]
    static let blueViolet =          SolidColors[65]
    static let darkBlueViolet =      SolidColors[66]
    static let violet =              SolidColors[67]
    static let mediumViolet =        SolidColors[68]
    static let lightViolet =         SolidColors[69]
    static let darkPurple =          SolidColors[70]
    static let purple =              SolidColors[71]
    static let lightPurple =         SolidColors[72]
    static let mediumLavender =      SolidColors[73]
    static let clikitsLavender =     SolidColors[74]
    static let lavender =            SolidColors[75]
    static let sandPurple =          SolidColors[76]
    static let magenta =             SolidColors[77]
    static let darkPink =            SolidColors[78]
    static let mediumDarkPink =      SolidColors[79]
    static let brightPink =          SolidColors[80]
    static let pink =                SolidColors[81]
    static let lightPink =           SolidColors[82]

    init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self = LegoColor.getApproximateColor(r: r, g: g, b: b)
    }

    init?(cgColor: CGColor) {
        guard let rgba = cgColor.rgba else { return nil }
        self = LegoColor.getApproximateColor(r: rgba.r, g: rgba.g, b: rgba.b)
    }

#if canImport(UIKit)
    init?(uiColor: UIColor) {
        self.init(cgColor: uiColor.cgColor)
    }
#elseif canImport(AppKit)
    init?(nsColor: NSColor) {
        self.init(cgColor: nsColor.cgColor)
    }
#endif

    static func getApproximateColor(r: CGFloat, g: CGFloat, b: CGFloat) -> LegoColor {
        var n: Int = 0
        var diff = SolidColors[n].diff(red: r, green: g, blue: b)
        for i in (1 ..< SolidColors.count) {
            let d = SolidColors[i].diff(red: r, green: g, blue: b)
            if d < diff {
                diff = d
                n = i
            }
        }
        return SolidColors[n]
    }
}
