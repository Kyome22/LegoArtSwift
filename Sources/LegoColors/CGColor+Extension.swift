//
//  CGColor+Extension.swift
//
//
//  Created by Takuto Nakamura on 2021/10/14.
//

import CoreGraphics

public extension CGColor {
    var rgba: RGBA? {
        guard let sRGB = CGColorSpace(name: CGColorSpace.sRGB),
              let c = self.converted(to: sRGB, intent: .defaultIntent, options: nil),
              c.numberOfComponents == 4,
              let components = c.components
        else { return nil }
        return RGBA(r: components[0],
                    g: components[1],
                    b: components[2],
                    a: components[3])
    }
}
