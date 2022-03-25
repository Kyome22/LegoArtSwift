//
//  LegoArtImageModel_macOS.swift
//  LegoArtSwiftDemo (macOS)
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import AppKit.NSImage
import Combine
import LegoArtFilter

final class LegoArtImageModel_macOS: LegoArtImageModel {
    let studTypeList: [StudType] = [.round, .roundPlate, .square, .squarePlate]
    let studTypeDefaultSelection: Int = 0

    let maxStudList: [Int] = (0 ..< 8).map { 16 * ($0 + 1) }
    let maxStudDefaultSelection: Int = 2

    private let legoArtSubject = PassthroughSubject<LegoArtData, Never>()
    var legoArtPublisher: AnyPublisher<LegoArtData, Never> {
        return legoArtSubject.eraseToAnyPublisher()
    }

    func convertLegoArtCGImage(
        contentURL: URL?,
        studType: StudType,
        maxStud: Int
    ) {
        if let contentURL = contentURL,
           let nsImage = NSImage(contentsOf: contentURL),
           let legoArt = LegoArtFilter(from: nsImage, studType: studType, maxStud: maxStud) {
            legoArtSubject.send(LegoArtData(legoArt.exportCGImage(), legoArt.partsList))
        } else {
            legoArtSubject.send(LegoArtData())
        }
    }
}
