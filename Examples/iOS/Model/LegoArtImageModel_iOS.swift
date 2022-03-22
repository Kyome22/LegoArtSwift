//
//  LegoArtImageModel_iOS.swift
//  LegoArtSwiftDemo (iOS)
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import UIKit
import LegoArtFilter

struct LegoArtImageModel_iOS: LegoArtImageModel {
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
              let uiImage = UIImage(contentsOfFile: contentURL.path),
              let legoArt = LegoArtFilter(from: uiImage,
                                          studType: studType,
                                          maxStud: maxStud)
        else {
            legoArtCGImage = nil
            return
        }
        self.legoArtCGImage = legoArt.exportCGImage()
    }
}
