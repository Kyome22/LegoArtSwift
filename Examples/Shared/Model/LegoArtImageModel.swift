//
//  LegoArtImageModel.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import Foundation
import CoreGraphics
import LegoArtFilter

protocol LegoArtImageModel {
    var studTypeDefaultSelection: Int { get }
    var maxStudDefaultSelection: Int { get }

    var studTypeList: [StudType] { get }
    var maxStudList: [Int] { get }

    var contentURL: URL? { get set }
    var studType: StudType { get set }
    var maxStud: Int { get set }
    var legoArtCGImage: CGImage? { get set }
    var partsList: [PartsData] { get set }

    mutating func convertURLtoLegoArtCGImage()
}
