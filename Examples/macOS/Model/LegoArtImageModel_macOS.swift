//
//  LegoArtImageModel_macOS.swift
//  LegoArtSwiftDemo (macOS)
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import AppKit
import LegoArtFilter

struct LegoArtImageModel_macOS: LegoArtImageModel {
    let studTypeDefaultSelection: Int = 0
    let maxStudDefaultSelection: Int = 2
    let studTypeList: [StudType] = [.round, .roundPlate, .square, .squarePlate]
    let maxStudList: [Int] = (0 ..< 8).map { 16 * ($0 + 1) }

    var contentURL: URL?
    var studType: StudType
    var maxStud: Int
    var legoArtCGImage: CGImage?

    init() {
        studType = studTypeList[studTypeDefaultSelection]
        maxStud = maxStudList[maxStudDefaultSelection]
    }

    mutating func convertURLtoLegoArtCGImage() {
        guard let contentURL = contentURL,
              let nsImage = NSImage(contentsOf: contentURL),
              let legoArt = LegoArtFilter(from: nsImage,
                                          studType: studType,
                                          maxStud: maxStud)
        else {
            legoArtCGImage = nil
            return
        }
        legoArtCGImage = legoArt.exportCGImage()
    }
}
