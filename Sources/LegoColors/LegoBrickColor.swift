//
//  LegoBrickColor.swift
//
//
//  Created by Takuto Nakamura on 2022/04/06.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public enum LegoBrickColor: RawRepresentable, CaseIterable {
    public typealias RawValue = LegoColor

    case white
    case vertLightGray
    case veryLightBluishGray
    case lightBluishGray
    case lightGray
    case darkGray
    case darkBluishGray
    case black
    case darkRed
    case red
    case rust
    case coral
    case darkSalmon
    case salmon
    case lightSalmon
    case sandRed
    case brown
    case mediumBrown
    case reddishBrown
    case fabulandBrown
    case darkTan
    case tan
    case lightNougat
    case nougat
    case mediumNougat
    case darkNougat
    case fabulandOrange
    case earthOrange
    case darkOrange
    case neonOrange
    case orange
    case mediumOrange
    case brightLightOrange
    case lightOrange
    case veryLightOrange
    case darkYellow
    case yellow
    case lightYellow
    case brightLightYellow
    case neonYellow
    case neonGreen
    case lightLime
    case yellowishGreen
    case mediumLime
    case lime
    case oliveGreen
    case darkGreen
    case green
    case brightGreen
    case mediumGreen
    case lightGreen
    case sandGreen
    case darkTurquoise
    case lightTurquoise
    case aqua
    case lightAqua
    case darkBlue
    case blue
    case darkAzure
    case maerskBlue
    case mediumAzure
    case skyBlue
    case mediumBlue
    case brightLightBlue
    case lightBlue
    case sandBlue
    case darkBlueViolet
    case violet
    case blueViolet
    case mediumViolet
    case lightViolet
    case darkPurple
    case purple
    case lightPurple
    case mediumLavender
    case lavender
    case clikitsLavender
    case sandPurple
    case magenta
    case darkPink
    case mediumDarkPink
    case brightPink
    case pink
    case lightPink

    public init?(rawValue: RawValue) {
        return nil
    }

    public var rawValue: RawValue {
        switch self {
        case .white:                return SolidColors[0_]
        case .vertLightGray:        return SolidColors[1_]
        case .veryLightBluishGray:  return SolidColors[2_]
        case .lightBluishGray:      return SolidColors[3_]
        case .lightGray:            return SolidColors[4_]
        case .darkGray:             return SolidColors[5_]
        case .darkBluishGray:       return SolidColors[6_]
        case .black:                return SolidColors[7_]
        case .darkRed:              return SolidColors[8_]
        case .red:                  return SolidColors[9_]
        case .rust:                 return SolidColors[10]
        case .coral:                return SolidColors[11]
        case .darkSalmon:           return SolidColors[12]
        case .salmon:               return SolidColors[13]
        case .lightSalmon:          return SolidColors[14]
        case .sandRed:              return SolidColors[15]
        case .brown:                return SolidColors[16]
        case .mediumBrown:          return SolidColors[17]
        case .reddishBrown:         return SolidColors[18]
        case .fabulandBrown:        return SolidColors[19]
        case .darkTan:              return SolidColors[20]
        case .tan:                  return SolidColors[21]
        case .lightNougat:          return SolidColors[22]
        case .nougat:               return SolidColors[23]
        case .mediumNougat:         return SolidColors[24]
        case .darkNougat:           return SolidColors[25]
        case .fabulandOrange:       return SolidColors[26]
        case .earthOrange:          return SolidColors[27]
        case .darkOrange:           return SolidColors[28]
        case .neonOrange:           return SolidColors[29]
        case .orange:               return SolidColors[30]
        case .mediumOrange:         return SolidColors[31]
        case .brightLightOrange:    return SolidColors[32]
        case .lightOrange:          return SolidColors[33]
        case .veryLightOrange:      return SolidColors[34]
        case .darkYellow:           return SolidColors[35]
        case .yellow:               return SolidColors[36]
        case .lightYellow:          return SolidColors[37]
        case .brightLightYellow:    return SolidColors[38]
        case .neonYellow:           return SolidColors[39]
        case .neonGreen:            return SolidColors[40]
        case .lightLime:            return SolidColors[41]
        case .yellowishGreen:       return SolidColors[42]
        case .mediumLime:           return SolidColors[43]
        case .lime:                 return SolidColors[44]
        case .oliveGreen:           return SolidColors[45]
        case .darkGreen:            return SolidColors[46]
        case .green:                return SolidColors[47]
        case .brightGreen:          return SolidColors[48]
        case .mediumGreen:          return SolidColors[49]
        case .lightGreen:           return SolidColors[50]
        case .sandGreen:            return SolidColors[51]
        case .darkTurquoise:        return SolidColors[52]
        case .lightTurquoise:       return SolidColors[53]
        case .aqua:                 return SolidColors[54]
        case .lightAqua:            return SolidColors[55]
        case .darkBlue:             return SolidColors[56]
        case .blue:                 return SolidColors[57]
        case .darkAzure:            return SolidColors[58]
        case .maerskBlue:           return SolidColors[59]
        case .mediumAzure:          return SolidColors[60]
        case .skyBlue:              return SolidColors[61]
        case .mediumBlue:           return SolidColors[62]
        case .brightLightBlue:      return SolidColors[63]
        case .lightBlue:            return SolidColors[64]
        case .sandBlue:             return SolidColors[65]
        case .darkBlueViolet:       return SolidColors[66]
        case .violet:               return SolidColors[67]
        case .blueViolet:           return SolidColors[68]
        case .mediumViolet:         return SolidColors[69]
        case .lightViolet:          return SolidColors[70]
        case .darkPurple:           return SolidColors[71]
        case .purple:               return SolidColors[72]
        case .lightPurple:          return SolidColors[73]
        case .mediumLavender:       return SolidColors[74]
        case .lavender:             return SolidColors[75]
        case .clikitsLavender:      return SolidColors[76]
        case .sandPurple:           return SolidColors[77]
        case .magenta:              return SolidColors[78]
        case .darkPink:             return SolidColors[79]
        case .mediumDarkPink:       return SolidColors[80]
        case .brightPink:           return SolidColors[81]
        case .pink:                 return SolidColors[82]
        case .lightPink:            return SolidColors[83]
        }
    }
}

public extension LegoBrickColor {
    init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self = LegoBrickColor.getApproximateColor(r: r, g: g, b: b)
    }

    init?(cgColor: CGColor) {
        guard let rgba = cgColor.rgba else { return nil }
        self = LegoBrickColor.getApproximateColor(r: rgba.r, g: rgba.g, b: rgba.b)
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

    static func getApproximateColor(r: CGFloat, g: CGFloat, b: CGFloat) -> LegoBrickColor {
        let colors = LegoBrickColor.allCases
        var n: Int = 0
        var diff = colors[n].rawValue.diff(red: r, green: g, blue: b)
        for i in (1 ..< colors.count) {
            let d = colors[i].rawValue.diff(red: r, green: g, blue: b)
            if d < diff {
                diff = d
                n = i
            }
        }
        return colors[n]
    }
}
