//
//  LegoArtData.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/25.
//

import CoreGraphics
import LegoArtFilter

struct LegoArtData {
    let legoArtCGImage: CGImage?
    let partsList: [PartsData]
    let digitNumber: Int

    init(_ legoArtCGImage: CGImage? = nil, _ partsList: [PartsData] = []) {
        self.legoArtCGImage = legoArtCGImage
        self.partsList = partsList
        let quantity = partsList.first?.quantity ?? 0
        self.digitNumber = String(quantity).count
    }
}
