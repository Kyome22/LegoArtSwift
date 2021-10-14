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
    let baseColor: CGColor
    let maxStud: Int
    let studPixelWidth: Int
    let horizontalStudCount: Int
    let colorMap: [LegoColor]
    
    public init?(
        ciImage: CIImage,
        baseColor: CGColor = .black,
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
        baseColor: CGColor = .black,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
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
    #endif
    
    #if canImport(AppKit)
    public convenience init?(
        from nsImage: NSImage,
        baseColor: CGColor = .black,
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
                let r = CGFloat(rgbaData[4 * i]) / 255.0
                let g = CGFloat(rgbaData[4 * i + 1]) / 255.0
                let b = CGFloat(rgbaData[4 * i + 2]) / 255.0
                let a = CGFloat(rgbaData[4 * i + 3]) / 255.0
                return LegoColor(r: r, g: g, b: b, a: a)
            }
        return (colorMap, Int(size.width))
    }
    
    #if canImport(UIKit)
    public func exportUIImage() -> UIImage? {
        if colorMap.isEmpty { return nil }
        let w = horizontalStudCount
        let h = colorMap.count / horizontalStudCount
        let size = CGSize(width: (studPixelWidth + 1) * w - 1,
                          height: (studPixelWidth + 1) * h - 1)
        
        return UIGraphicsImageRenderer(size: size).image { _ in
//            let bgRect = UIBezierPath(rect: CGRect(origin: .zero, size: size))
//            UIColor.black.setFill()
//            bgRect.fill()
            
            let u = CGFloat(studPixelWidth)
            for i in (0 ..< colorMap.count) {
                let x = CGFloat(i % w) * (u + 1)
                let y = CGFloat(i / w) * (u + 1)
                
                switch studType {
                case .round, .roundPlate:
                    let path = UIBezierPath(ovalIn: CGRect(x: x, y: y, width: u, height: u))
                    UIColor(colorMap[i].color).setFill()
                    path.fill()
                case .square, .squarePlate:
                    let path = UIBezierPath(rect: CGRect(x: x, y: y, width: u, height: u))
                    UIColor(colorMap[i].color).setFill()
                    path.fill()
                }
                if studType == .round || studType == .square {
                    let v = 0.64 * u
                    let r = 0.5 * (u - v)
                    let rect = CGRect(x: CGFloat(x) + r, y: CGFloat(y) + r, width: v, height: v)
                    let path = UIBezierPath(ovalIn: rect)
                    let blendedColor = UIColor(colorMap[i].color)
                        .blended(withFraction: 0.2, of: UIColor.black)
                    if colorMap[i] == .transClear {
                        blendedColor.withAlphaComponent(0.1).setFill()
                    } else {
                        blendedColor.withAlphaComponent(0.6).setFill()
                    }
                    path.fill()
                }
            }
        }
    }
    #endif
    
    #if canImport(AppKit)
    public func exportNSImage() -> NSImage? {
        if colorMap.isEmpty { return nil }
        let w = horizontalStudCount
        let h = colorMap.count / horizontalStudCount
        let size = NSSize(width: (studPixelWidth + 1) * w - 1,
                          height: (studPixelWidth + 1) * h - 1)
        let image = NSImage(size: size)
        image.lockFocus()
//        let bgRect = NSBezierPath(rect: NSRect(origin: .zero, size: size))
//        NSColor.black.setFill()
//        bgRect.fill()
        
        let q = colorMap.count / w - 1
        let u = CGFloat(studPixelWidth)
        for i in (0 ..< colorMap.count) {
            let x = CGFloat(i % w) * (u + 1)
            let y = CGFloat(q - i / w) * (u + 1)
            
            switch studType {
            case .round, .roundPlate:
                let path = NSBezierPath(ovalIn: NSRect(x: x, y: y, width: u, height: u))
                NSColor(colorMap[i].color).setFill()
                path.fill()
            case .square, .squarePlate:
                let path = NSBezierPath(rect: NSRect(x: x, y: y, width: u, height: u))
                NSColor(colorMap[i].color).setFill()
                path.fill()
            }
            if studType == .round || studType == .square {
                let v = 0.64 * u
                let r = 0.5 * (u - v)
                let rect = NSRect(x: CGFloat(x) + r, y: CGFloat(y) + r, width: v, height: v)
                let path = NSBezierPath(ovalIn: rect)
                if let blendedColor = NSColor(colorMap[i].color)
                    .blended(withFraction: 0.2, of: NSColor.black) {
                    if colorMap[i] == .transClear {
                        blendedColor.withAlphaComponent(0.1).setFill()
                    } else {
                        blendedColor.withAlphaComponent(0.6).setFill()
                    }
                }
                path.fill()
            }
        }
        image.unlockFocus()
        return image
    }
    #endif
}
