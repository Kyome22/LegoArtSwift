//
//  LegoArtImageModel_iOS.swift
//  LegoArtSwiftDemo (iOS)
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import UIKit.UIImage
import Combine
import LegoArtFilter

final class LegoArtImageModel_iOS: NSObject, LegoArtImageModel {
    let studTypeList: [StudType] = [.round, .roundPlate, .square, .squarePlate]
    let studTypeDefaultSelection: Int = 0

    let maxStudList: [Int] = (0 ..< 8).map { 16 * ($0 + 1) }
    let maxStudDefaultSelection: Int = 2

    private let legoArtSubject = PassthroughSubject<LegoArtData, Never>()
    var legoArtPublisher: AnyPublisher<LegoArtData, Never> {
        return legoArtSubject.eraseToAnyPublisher()
    }

    private let saveLegoArtSubject = PassthroughSubject<String, Never>()
    var saveLegoArtPublisher: AnyPublisher<String, Never> {
        return saveLegoArtSubject.eraseToAnyPublisher()
    }

    func convertLegoArtCGImage(contentURL: URL?, baseColor: CGColor, studType: StudType, maxStud: Int) {
        if let contentURL = contentURL,
           let uiImage = UIImage(contentsOfFile: contentURL.path),
           let legoArt = LegoArtFilter(from: uiImage, baseColor: baseColor, studType: studType, maxStud: maxStud) {
            legoArtSubject.send(LegoArtData(legoArt.exportCGImage(), legoArt.partsList))
        } else {
            legoArtSubject.send(LegoArtData())
        }
    }

    func saveLegoArt(legoArtCGImage: CGImage?) {
        if let legoArtCGImage = legoArtCGImage {
            UIImageWriteToSavedPhotosAlbum(UIImage(cgImage: legoArtCGImage), self,
                                           #selector(saveComplete(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    @objc func saveComplete(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            saveLegoArtSubject.send(error.localizedDescription)
        } else {
            saveLegoArtSubject.send("Succeed🎉")
        }
    }
}
