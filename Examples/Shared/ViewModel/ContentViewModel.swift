//
//  ContentViewModel.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import Foundation
import CoreGraphics
import LegoArtFilter

@MainActor
class ContentViewModel: ObservableObject {
    @Published var legoArtImageModel: LegoArtImageModel

    var studTypeDefaultSelection: Int {
        return legoArtImageModel.studTypeDefaultSelection
    }
    var maxStudDefaultSelection: Int {
        return legoArtImageModel.maxStudDefaultSelection
    }
    var studTypeList: [StudType] {
        return legoArtImageModel.studTypeList
    }
    var maxStudList: [Int] {
        return legoArtImageModel.maxStudList
    }
    var contentURL: URL? {
        return legoArtImageModel.contentURL
    }
    var legoArtCGImage: CGImage? {
        return legoArtImageModel.legoArtCGImage
    }
    var partsList: [PartsData] {
        return legoArtImageModel.partsList
    }
    var digitNumber: Int {
        let quantity = legoArtImageModel.partsList.first?.quantity ?? 0
        return String(quantity).count
    }

    init() {
#if os(iOS)
        legoArtImageModel = LegoArtImageModel_iOS()
#elseif os(macOS)
        legoArtImageModel = LegoArtImageModel_macOS()
#endif
    }

    func updateContentURL(_ contentURL: URL?) {
        legoArtImageModel.contentURL = contentURL
        legoArtImageModel.convertURLtoLegoArtCGImage()
    }

    func updateStudType(_ studType: StudType) {
        legoArtImageModel.studType = studType
        legoArtImageModel.convertURLtoLegoArtCGImage()
    }

    func updateMaxStud(_ maxStud: Int) {
        legoArtImageModel.maxStud = maxStud
        legoArtImageModel.convertURLtoLegoArtCGImage()
    }
}
