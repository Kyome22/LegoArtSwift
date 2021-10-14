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
    
    func rgbaData(baseColor: CGColor) -> [UInt8]? {
        let size = self.extent.size
        let rect = CGRect(origin: .zero, size: size)
        guard let cgContext = CGContext(data: nil,
                                        width: Int(size.width),
                                        height: Int(size.height),
                                        bitsPerComponent: 8,
                                        bytesPerRow: 4 * Int(size.width),
                                        space: CGColorSpaceCreateDeviceRGB(),
                                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
                let originalCGImage = CIContext(options: nil).createCGImage(self, from: rect)
        else { return nil }
        cgContext.setFillColor(baseColor)
        cgContext.fill(rect)
        cgContext.draw(originalCGImage, in: rect)
        guard let correctCGImage = cgContext.makeImage(),
              let data = correctCGImage.dataProvider?.data
        else { return nil }
        let length = CFDataGetLength(data)
        var rgbaData = [UInt8](repeating: 0, count: length)
        CFDataGetBytes(data, CFRange(location: 0, length: length), &rgbaData)
        return rgbaData
    }
}
