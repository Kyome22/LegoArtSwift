//
//  LegoArtImageModel.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import Foundation
import Combine
import LegoArtFilter

protocol LegoArtImageModel {
    var studTypeList: [StudType] { get }
    var studTypeDefaultSelection: Int { get }

    var maxStudList: [Int] { get }
    var maxStudDefaultSelection: Int { get }

    var legoArtPublisher: AnyPublisher<LegoArtData, Never> { get }

    func convertLegoArtCGImage(contentURL: URL?, studType: StudType, maxStud: Int)

    func saveLegoArt(saveURL: URL, legoArtCGImage: CGImage?)
}
