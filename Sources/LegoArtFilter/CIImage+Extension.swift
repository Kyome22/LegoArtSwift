//
//  CIImage+Extensino.swift
//  
//
//  Created by Takuto Nakamura on 2021/10/10.
//

import CoreImage

extension CIImage {
    func resizeAffine(maxStud: Int) -> CIImage? {
        let rect = self.extent
        if rect.width == 0 || rect.height == 0 { return nil }
        let scale = CGFloat(maxStud) / max(rect.width, rect.height)
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        return self.transformed(by: transform)
    }
}
