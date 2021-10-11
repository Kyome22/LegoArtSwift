//
//  UIColor+Extension.swift
//  
//
//  Created by Takuto Nakamura on 2021/10/12.
//

#if canImport(UIKit)
import UIKit.UIColor

extension UIColor {
    func blended(withFraction fraction: CGFloat, of color: UIColor) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(red: fraction * (r2 - r1) + r1,
                       green: fraction * (g2 - g1) + g1,
                       blue: fraction * (b2 - b1) + b1,
                       alpha: fraction * (a2 - a1) + a1)
    }
}
#endif
