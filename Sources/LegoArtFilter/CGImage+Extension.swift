//
//  CGImage+Extension.swift
//  
//
//  Created by Takuto Nakamura on 2021/10/12.
//

import CoreGraphics

extension CGImage {
    var rgbData: [UInt8]? {
        guard let data = self.dataProvider?.data else { return nil }
        let length = CFDataGetLength(data)
        var rawData = [UInt8](repeating: 0, count: length)
        CFDataGetBytes(data, CFRange(location: 0, length: length), &rawData)
        let u = (self.bitsPerPixel / self.bitsPerComponent) // 4のはず
        if u * self.width < self.bytesPerRow {
            rawData = rawData.chunked(by: self.bytesPerRow)
                .map({ Array($0.prefix(u * self.width)) })
                .prefix(self.height)
                .flatMap({ $0 })
        }
        return rawData
    }
}
