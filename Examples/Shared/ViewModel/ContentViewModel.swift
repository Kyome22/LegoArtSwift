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
    @Published var baseColor: CGColor = .black
    @Published var studType: StudType
    @Published var maxStud: Int
    @Published var legoArtCGImage: CGImage? = nil
    @Published var partsList = [PartsData]()
    @Published var digitNumber: Int = 0
    @Published var showingAlert: Bool = false
    @Published var message: String = ""

    init(_ model: LegoArtImageModel) {
        self.model = model

        studTypeList = model.studTypeList
        studTypeDefaultSelection = model.studTypeDefaultSelection
        studType = studTypeList[studTypeDefaultSelection]

        maxStudList = model.maxStudList
        maxStudDefaultSelection = model.maxStudDefaultSelection
        maxStud = maxStudList[maxStudDefaultSelection]

        Publishers
            .CombineLatest4($contentURL, $baseColor, $studType, $maxStud)
            .dropFirst()
            .sink(receiveValue: { [weak self] values in
                self?.model.convertLegoArtCGImage(contentURL: values.0,
                                                  baseColor: values.1,
                                                  studType: values.2,
                                                  maxStud: values.3)
            })
            .store(in: &cancellables)

        self.model.legoArtPublisher
            .sink(receiveValue: { [weak self] legoArtData in
                self?.legoArtCGImage = legoArtData.legoArtCGImage
                self?.partsList = legoArtData.partsList
                self?.digitNumber = legoArtData.digitNumber
            })
            .store(in: &cancellables)

        self.model.saveLegoArtPublisher
            .sink(receiveValue: { [weak self] message in
                self?.message = message
                self?.showingAlert = true
            })
            .store(in: &cancellables)
    }

    func saveLegoArt(saveURL: URL) {
        model.saveLegoArt(saveURL: saveURL, legoArtCGImage: legoArtCGImage)
    }

    func saveLegoArt() {
        model.saveLegoArt(legoArtCGImage: legoArtCGImage)
    }
}
