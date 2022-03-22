//
//  MaxStudDropDownMenu.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI

struct MaxStudDropDownMenu: View {
    @ObservedObject var contentViewModel: ContentViewModel

    @State var maxStudSelection: Int

    private let maxStudList: [Int]

    init(_ contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
        self.maxStudSelection = contentViewModel.maxStudDefaultSelection
        self.maxStudList = contentViewModel.maxStudList
    }

    var body: some View {
        Picker("Max Stud:", selection: $maxStudSelection) {
            ForEach(0 ..< maxStudList.count, id: \.self) { i in
                Text(String(maxStudList[i])).tag(i)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: maxStudSelection) { newValue in
            contentViewModel.updateMaxStud(maxStudList[newValue])
        }
    }
}

struct MaxStudDropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        MaxStudDropDownMenu(ContentViewModel())
    }
}
