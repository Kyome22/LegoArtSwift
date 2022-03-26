//
//  LegoArtImageModel_macOS.swift
//  LegoArtSwiftDemo (macOS)
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import AppKit.NSImage
import Combine
import LegoArtFilter
import UniformTypeIdentifiers

final class LegoArtImageModel_macOS: LegoArtImageModel {
    let studTypeList: [StudType] = [.round, .roundPlate, .square, .squarePlate]
    let studTypeDefaultSelection: Int = 0

    let maxStudList: [Int] = (0 ..< 8).map { 16 * ($0 + 1) }
    let maxStudDefaultSelection: Int = 2

    private let legoArtSubject = PassthroughSubject<LegoArtData, Never>()
    var legoArtPublisher: AnyPublisher<LegoArtData, Never> {
        return legoArtSubject.eraseToAnyPublisher()
    }

    func convertLegoArtCGImage(contentURL: URL?, baseColor: CGColor, studType: StudType, maxStud: Int) {
        if let contentURL = contentURL,
           let nsImage = NSImage(contentsOf: contentURL),
           let legoArt = LegoArtFilter(from: nsImage, baseColor: baseColor, studType: studType, maxStud: maxStud) {
            legoArtSubject.send(LegoArtData(legoArt.exportCGImage(), legoArt.partsList))
        } else {
            legoArtSubject.send(LegoArtData())
        }
    }

    func saveLegoArt(saveURL: URL, legoArtCGImage: CGImage?) {
        if let legoArtCGImage = legoArtCGImage {
            let imageRep = NSBitmapImageRep(cgImage: legoArtCGImage)
            switch UTType(filenameExtension: saveURL.pathExtension) {
            case UTType.png:
                let pngData = imageRep.representation(using: .png, properties: [:])
                try? pngData?.write(to: saveURL)
            case UTType.jpeg:
                let jpegData = imageRep.representation(using: .jpeg, properties: [:])
                try? jpegData?.write(to: saveURL)
            default:
                return
            }
        }
    }
}
