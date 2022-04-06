//
//  LegoArtFilter.swift
//
//
//  Created by Takuto Nakamura on 2021/10/10.
//

import LegoColors
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public class LegoArtFilter {
    let studType: StudType
    let baseColor: CGColor
    let maxStud: Int
    let studPixelWidth: Int
    let horizontalStudCount: Int
    let colorMap: [LegoColor]

    // Processing takes longer with the complexity of the image.
    public init?(
        ciImage: CIImage,
        baseColor: CGColor = .black,
        studType: StudType = .round,
        maxStud: Int = 48,
        studPixelWidth: Int = 10
    ) {
        if maxStud <= 0 { return nil }
        let (colorMap, count) = LegoArtFilter.getColorMap(from: ciImage,
                                                          baseColor: baseColor,
                                                          studType: studType,
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
        // Correcting the image orientation
        guard let ciImage = CIImage(image: uiImage) else { return nil }
        let orientation = CGImagePropertyOrientation(uiImage.imageOrientation)
        self.init(ciImage: ciImage.oriented(orientation),
                  baseColor: baseColor,
                  studType: studType,
                  maxStud: maxStud,
                  studPixelWidth: studPixelWidth)
    }
#elseif canImport(AppKit)
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
        studType: StudType,
        maxStud: Int
    ) -> ([LegoColor], Int) {
        guard let studImage = CGImage.createStudImage(with: ciImage,
                                                      baseColor: baseColor,
                                                      maxStud: maxStud),
              let rgbaData = studImage.rgbaData()
        else { return ([], 0) }
        var memo: [String : LegoColor] = [:]
        let colorMap = (0 ..< studImage.width * studImage.height)
            .map { i -> LegoColor in
                let keyR = rgbaData[4 * i] / 8
                let keyG = rgbaData[4 * i + 1] / 8
                let keyB = rgbaData[4 * i + 2] / 8
                let key = String(format: "%02d%02d%02d", keyR, keyG, keyB)
                if let legoColor = memo[key] {
                    return legoColor
                }
                let r = CGFloat(rgbaData[4 * i]) / 255.0
                let g = CGFloat(rgbaData[4 * i + 1]) / 255.0
                let b = CGFloat(rgbaData[4 * i + 2]) / 255.0
                let legoColor: LegoColor
                switch studType {
                case .round, .roundPlate:
                    legoColor = LegoRoundTileColor(r: r, g: g, b: b).rawValue
                case .square, .squarePlate:
                    legoColor = LegoSquareTileColor(r: r, g: g, b: b).rawValue
                }
                memo[key] = legoColor
                return legoColor
            }
        return (colorMap, studImage.width)
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
        // fill baseColor
        cgContext.setFillColor(baseColor)
        cgContext.fill(rect)
        
        // draw studs
        let q = colorMap.count / w - 1
        let u = CGFloat(studPixelWidth)
        let cgBlack = CGColor(gray: 0, alpha: 1)
        for i in (0 ..< colorMap.count) {
            let x = CGFloat(i % w) * (u + 1)
            let y = CGFloat(q - i / w) * (u + 1)
            let c = colorMap[i].color
            switch studType {
            case .round, .roundPlate:
                cgContext.setFillColor(c)
                cgContext.fillEllipse(in: CGRect(x: x, y: y, width: u, height: u))
            case .square, .squarePlate:
                cgContext.setFillColor(c)
                cgContext.fill(CGRect(x: x, y: y, width: u, height: u))
            }
            if studType == .round || studType == .square {
                if let bc = c.blended(cgBlack, fraction: 0.2, alpha: 0.6) {
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

    public var partsList: [PartsData] {
        var memo: [String : PartsData] = [:]
        colorMap.forEach { legoColor in
            let key = legoColor.name
            if memo[key] != nil {
                memo[key]!.countUp()
            } else {
                memo[key] = PartsData(legoColor: legoColor)
            }
        }
        return memo.values.sorted { a, b in
            a.quantity > b.quantity
        }
    }
}
