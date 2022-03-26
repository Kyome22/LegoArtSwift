//
//  CGImage+Extension.swift
//  
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import CoreGraphics
import CoreImage
#if canImport(UIKit)
import UIKit
#endif

extension CGImage {
    static func createStudImage(with ciImage: CIImage, baseColor: CGColor?, maxStud: Int) -> CGImage? {
        let newRect = CGRect(origin: .zero, size: ciImage.extent.size)
            .scaled(maxPoint: maxStud)
        guard let cgColorSpace = CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
        let ciContext = CIContext(options: [
            CIContextOption.cacheIntermediates : true,
            CIContextOption.priorityRequestLow : false,
            CIContextOption.workingColorSpace : cgColorSpace,
            CIContextOption.workingFormat : CIFormat.RGBAh,
            CIContextOption.highQualityDownsample : false
        ])
        guard let cgContext = CGContext(data: nil,
                                        width: Int(newRect.width),
                                        height: Int(newRect.height),
                                        bitsPerComponent: 8,
                                        bytesPerRow: 4 * Int(newRect.width),
                                        space: cgColorSpace,
                                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
              let originalCGImage = ciContext.createCGImage(ciImage, from: ciImage.extent)
        else { return nil }
        cgContext.interpolationQuality = .low
        if let baseColor = baseColor {
            cgContext.setFillColor(baseColor)
            cgContext.fill(newRect)
        }
        cgContext.draw(originalCGImage, in: newRect)
        return cgContext.makeImage()
    }

    func rgbaData() -> [UInt8]? {
        guard let data = self.dataProvider?.data else { return nil }
        let length = CFDataGetLength(data)
        var rgbaData = [UInt8](repeating: 0, count: length)
        CFDataGetBytes(data, CFRange(location: 0, length: length), &rgbaData)
        return rgbaData
    }
}

#if canImport(UIKit)
extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch (uiOrientation) {
        case .up:            self = .up
        case .down:          self = .down
        case .left:          self = .left
        case .right:         self = .right
        case .upMirrored:    self = .upMirrored
        case .downMirrored:  self = .downMirrored
        case .leftMirrored:  self = .leftMirrored
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError("Unknown uiOrientation \(uiOrientation)")
        }
    }
}
#endif
