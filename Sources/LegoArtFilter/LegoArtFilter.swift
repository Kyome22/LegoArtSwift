//
//  LegoArtFilter.swift
//
//
//  Created by Takuto Nakamura on 2021/10/10.
//

import SwiftUI
import LegoColors

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public let LegoBlack = LegoColor.black.cgColor

public class LegoArt {
    let studType: StudType
    let baseColor: CGColor
    let maxStud: Int
    let studPixelWidth: Int
    let horizontalStudCount: Int
    let colorMap: [LegoColor]
    
    public init?(
        ciImage: CIImage,
        baseColor: CGColor = LegoBlack,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
        if maxStud <= 0 { return nil }
        let (colorMap, count) = LegoArt.getColorMap(from: ciImage,
                                                    baseColor: baseColor,
                                                    maxStud: maxStud)
        if colorMap.isEmpty { return nil }
        self.baseColor = baseColor
        self.studType = studType
        self.maxStud = maxStud
        self.studPixelWidth = studPixelWidth
        self.horizontalStudCount = count
        self.colorMap = colorMap
    }
    
    #if canImport(UIKit)
    public convenience init?(
        from uiImage: UIImage,
        baseColor: CGColor = LegoBlack,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
        // Correcting the image orientation
        let correctUIImage = UIGraphicsImageRenderer(size: uiImage.size)
            .image(actions: { _ in
                uiImage.draw(at: .zero)
            })
        guard let cgImage = correctUIImage.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        self.init(ciImage: ciImage,
                  baseColor: baseColor,
                  studType: studType,
                  maxStud: maxStud,
                  studPixelWidth: studPixelWidth)
    }
    #elseif canImport(AppKit)
    public convenience init?(
        from nsImage: NSImage,
        baseColor: CGColor = LegoBlack,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
        guard let imageData = nsImage.tiffRepresentation,
              let ciImage = CIImage(data: imageData)
        else { return nil }
        self.init(ciImage: ciImage,
                  baseColor: baseColor,
                  studType: studType,
                  maxStud: maxStud,
                  studPixelWidth: studPixelWidth)
    }
    #endif
    
    private static func getColorMap(
        from ciImage: CIImage,
        baseColor: CGColor,
        maxStud: Int
    ) -> ([LegoColor], Int) {
        guard let resizedImage = ciImage.resizeAffine(maxStud: maxStud),
              let rgbaData = resizedImage.rgbaData(baseColor: baseColor)
        else { return ([], 0) }
        let size = resizedImage.extent.size
        let colorMap = (0 ..< Int(size.width * size.height))
            .map { i -> LegoColor in
                let r = CGFloat(rgbaData[4 * i + 0]) / 255.0
                let g = CGFloat(rgbaData[4 * i + 1]) / 255.0
                let b = CGFloat(rgbaData[4 * i + 2]) / 255.0
                let a = CGFloat(rgbaData[4 * i + 3]) / 255.0
                return LegoColor(r: r, g: g, b: b, a: a)
            }
        return (colorMap, Int(size.width))
    }
    
    public func exportCGImage() -> CGImage? {
        if colorMap.isEmpty { return nil }
        let w = horizontalStudCount
        let h = colorMap.count / horizontalStudCount
        let size = CGSize(width: (studPixelWidth + 1) * w - 1,
                          height: (studPixelWidth + 1) * h - 1)
        let rect = CGRect(origin: .zero, size: size)
        
        guard let cgContext = CGContext(data: nil,
                                        width: Int(size.width),
                                        height: Int(size.height),
                                        bitsPerComponent: 8,
                                        bytesPerRow: 4 * Int(size.width),
                                        space: CGColorSpaceCreateDeviceRGB(),
                                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return nil }
        // fill black
        let cgBlack = CGColor(gray: 0, alpha: 1)
        cgContext.setFillColor(cgBlack)
        cgContext.fill(rect)
        
        // draw studs
        let u = CGFloat(studPixelWidth)
        for i in (0 ..< colorMap.count) {
            let x = CGFloat(i % w) * (u + 1)
            let y = CGFloat(i / w) * (u + 1)
            let c = colorMap[i].cgColor
            switch studType {
            case .round, .roundPlate:
                cgContext.setFillColor(c)
                cgContext.fillEllipse(in: CGRect(x: x, y: y, width: u, height: u))
            case .square, .squarePlate:
                cgContext.setFillColor(c)
                cgContext.fill(CGRect(x: x, y: y, width: u, height: u))
            }
            if studType == .round || studType == .square {
                let alpha: CGFloat = (colorMap[i] == .transClear) ? 0.1 : 0.6
                if let bc = c.blended(cgBlack, fraction: 0.2, alpha: alpha) {
                    cgContext.setFillColor(bc)
                    let v = 0.64 * u
                    let r = 0.5 * (u - v)
                    let studRect = CGRect(x: CGFloat(x) + r, y: CGFloat(y) + r, width: v, height: v)
                    cgContext.fillEllipse(in: studRect)
                }
            }
        }
        
        return cgContext.makeImage()
    }
    
    #if canImport(UIKit)
    public func exportUIImage() -> UIImage? {
        guard let cgImage = exportCGImage() else { return nil }
        return UIImage(cgImage: cgImage)
    }
    #elseif canImport(AppKit)
    public func exportNSImage() -> NSImage? {
        guard let cgImage = exportCGImage() else { return nil }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        return NSImage(cgImage: cgImage, size: size)
    }
    #endif
}
