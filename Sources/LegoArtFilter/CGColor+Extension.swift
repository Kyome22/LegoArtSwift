//
//  CGColor+Extension.swift
//  
//
//  Created by Takuto Nakamura on 2021/10/14.
//

import CoreGraphics

public extension CGColor {
    func blended(_ color: CGColor, fraction: CGFloat, alpha: CGFloat) -> CGColor? {
        guard let rgba1 = self.rgba, let rgba2 = color.rgba else { return nil }
        let fi: CGFloat = 1 - fraction
        return CGColor(red:   fi * rgba1.r + fraction * rgba2.r,
                       green: fi * rgba1.g + fraction * rgba2.g,
                       blue:  fi * rgba1.b + fraction * rgba2.b,
                       alpha: alpha)
    }
    
    #if os(iOS)
    static let black = CGColor(gray: 0, alpha: 1)
    #endif
}
