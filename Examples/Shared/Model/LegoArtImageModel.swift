//
//  LegoArtImageModel.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import Foundation
import Combine
import CoreGraphics
import LegoArtFilter

protocol LegoArtImageModel {
    var studTypeList: [StudType] { get }
    var studTypeDefaultSelection: Int { get }

    var maxStudList: [Int] { get }
    var maxStudDefaultSelection: Int { get }

    var legoArtPublisher: AnyPublisher<LegoArtData, Never> { get }
    var saveLegoArtPublisher: AnyPublisher<String, Never> { get }

    func convertLegoArtCGImage(contentURL: URL?, baseColor: CGColor, studType: StudType, maxStud: Int)

    func saveLegoArt(saveURL: URL, legoArtCGImage: CGImage?)
    func saveLegoArt(legoArtCGImage: CGImage?)
}

extension LegoArtImageModel {
    var saveLegoArtPublisher: AnyPublisher<String, Never> {
        return Just("").eraseToAnyPublisher()
    }
    func saveLegoArt(saveURL: URL, legoArtCGImage: CGImage?) {}
    func saveLegoArt(legoArtCGImage: CGImage?) {}
}
