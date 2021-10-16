//
//  CGRect+Extension.swift
//  
//
//  Created by Takuto Nakamura on 2021/10/16.
//

import CoreGraphics

extension CGRect {
    func scaled(maxPoint: Int) -> CGRect {
        let scale = CGFloat(maxPoint) / max(self.width, self.height)
        let size = CGSize(width: ceil(scale * self.width),
                          height: ceil(scale * self.height))
        return CGRect(origin: self.origin, size: size)
    }
}

