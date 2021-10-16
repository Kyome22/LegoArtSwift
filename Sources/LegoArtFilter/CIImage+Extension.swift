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
        if rect.width * rect.height == 0 { return nil }
        let newRect = rect.scaled(maxPoint: maxStud)
        let scaleX = newRect.width / rect.width
        let scaleY = newRect.height / rect.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        return self.transformed(by: transform).settingAlphaOne(in: newRect)
    }
    
    func correctImage(_ baseColor: CGColor?) -> CGImage? {
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
        if let baseColor = baseColor {
            cgContext.setFillColor(baseColor)
            cgContext.fill(rect)
        }
        cgContext.draw(originalCGImage, in: rect)
        return cgContext.makeImage()
    }
    
    func rgbaData(baseColor: CGColor) -> [UInt8]? {
        guard let cgImage = self.correctImage(baseColor),
              let data = cgImage.dataProvider?.data
        else { return nil }
        let length = CFDataGetLength(data)
        var rgbaData = [UInt8](repeating: 0, count: length)
        CFDataGetBytes(data, CFRange(location: 0, length: length), &rgbaData)
        return rgbaData
    }
}
