//
//  ContentViewModel.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import Foundation
import Combine
import CoreGraphics
import LegoArtFilter

@MainActor
final class ContentViewModel: ObservableObject {
    private let model: LegoArtImageModel
    private var cancellables = Set<AnyCancellable>()

    let studTypeList: [StudType]
    let studTypeDefaultSelection: Int

    let maxStudList: [Int]
    let maxStudDefaultSelection: Int

    @Published var contentURL: URL? = nil
    @Published var studType: StudType
    @Published var maxStud: Int
    @Published var legoArtCGImage: CGImage? = nil
    @Published var partsList = [PartsData]()
    @Published var digitNumber: Int = 0

    init(_ model: LegoArtImageModel) {
        self.model = model

        studTypeList = model.studTypeList
        studTypeDefaultSelection = model.studTypeDefaultSelection
        studType = studTypeList[studTypeDefaultSelection]

        maxStudList = model.maxStudList
        maxStudDefaultSelection = model.maxStudDefaultSelection
        maxStud = maxStudList[maxStudDefaultSelection]

        $contentURL
            .combineLatest($studType, $maxStud)
            .dropFirst()
            .sink(receiveValue: { [weak self] (contentURL, studType, maxStud) in
                self?.model.convertLegoArtCGImage(contentURL: contentURL,
                                            studType: studType,
                                            maxStud: maxStud)
            })
            .store(in: &cancellables)

        self.model.legoArtPublisher
            .sink(receiveValue: { [weak self] legoArtData in
                self?.legoArtCGImage = legoArtData.legoArtCGImage
                self?.partsList = legoArtData.partsList
                self?.digitNumber = legoArtData.digitNumber
            })
            .store(in: &cancellables)
    }

    func saveLegoArt(saveURL: URL) {
        model.saveLegoArt(saveURL: saveURL, legoArtCGImage: legoArtCGImage)
    }

    func saveLegoArt(callback: @escaping (String) -> Void) {
        model.saveLegoArt(legoArtCGImage: legoArtCGImage, callback: callback)
    }
}
