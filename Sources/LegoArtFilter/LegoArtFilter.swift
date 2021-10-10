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

public class LegoArt {
    let studType: StudType
    let maxStud: Int
    let studPixelWidth: Int
    let horizontalStudCount: Int
    let colorMap: [LegoColor]
    
    // 透明度のことは考えていない
    public init?(
        ciImage: CIImage,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
        if maxStud <= 0 { return nil }
        let (colorMap, count) = LegoArt.getColorMap(from: ciImage, maxStud: maxStud)
        if colorMap.isEmpty { return nil }
        self.studType = studType
        self.maxStud = maxStud
        self.studPixelWidth = studPixelWidth
        self.horizontalStudCount = count
        self.colorMap = colorMap
    }
    
    #if canImport(UIKit)
    public convenience init?(
        from uiImage: UIImage,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
        guard let ciImage = uiImage.ciImage else { return nil }
        self.init(ciImage: ciImage,
                  studType: studType,
                  maxStud: maxStud,
                  studPixelWidth: studPixelWidth)
    }
    #endif
    
    #if canImport(AppKit)
    public convenience init?(
        from nsImage: NSImage,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
        guard let imageData = nsImage.tiffRepresentation,
              let ciImage = CIImage(data: imageData)
        else { return nil }
        self.init(ciImage: ciImage,
                  studType: studType,
                  maxStud: maxStud,
                  studPixelWidth: studPixelWidth)
    }
    #endif
    
    private static func getColorMap(from ciImage: CIImage, maxStud: Int) -> ([LegoColor], Int) {
        let context = CIContext(options: nil)
        guard let resizedImage = ciImage.resizeAffine(maxStud: maxStud),
              let cgImage = context.createCGImage(resizedImage, from: resizedImage.extent),
              let pixelData = cgImage.dataProvider?.data
        else { return ([], 0) }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let size = resizedImage.extent.size
        let colorMap = (0 ..< Int(size.width * size.height)).map { i -> LegoColor in
            let r = CGFloat(data[4 * i]) / 255.0
            let g = CGFloat(data[4 * i + 1]) / 255.0
            let b = CGFloat(data[4 * i + 2]) / 255.0
            // let a = CGFloat(data[4 * i + 3]) / 255.0
            return LegoColor(r: r, g: g, b: b)
        }
        return (colorMap, Int(size.width))
    }
    
//        #if canImport(UIKit)
//        public var uiImage: UIImage? {
//            return nil
//        }
//        #endif
    
    #if canImport(AppKit)
    public func exportNSImage(backgroundColor: NSColor = .black) -> NSImage? {
        let w = horizontalStudCount
        let h = colorMap.count / horizontalStudCount
        let size = NSSize(width: studPixelWidth * w,
                          height: studPixelWidth * h)
        let image = NSImage(size: size)
        image.lockFocus()
        let bgRect = NSBezierPath(rect: NSRect(origin: .zero, size: size))
        backgroundColor.setFill()
        bgRect.fill()
        
        let q = colorMap.count / w
        for i in (0 ..< colorMap.count) {
            let x = (i % w) * studPixelWidth + 1
            let y = (q - i / w) * studPixelWidth + 1
            let u = studPixelWidth - 2
            let path = NSBezierPath(ovalIn: NSRect(x: x, y: y, width: u, height: u))
            NSColor(colorMap[i].color).setFill()
            path.fill()
        }
        image.unlockFocus()
        return image
    }
    #endif
}
