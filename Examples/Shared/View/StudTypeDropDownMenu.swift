//
//  StudTypeDropDownMenu.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI
import LegoArtFilter

struct StudTypeDropDownMenu: View {
    @ObservedObject var contentViewModel: ContentViewModel

    @State var studTypeSelection: Int

    private let studTypeList: [StudType]

    init(_ contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
        self.studTypeSelection = contentViewModel.studTypeDefaultSelection
        self.studTypeList = contentViewModel.studTypeList
    }

    var body: some View {
        Picker("Stud Type:", selection: $studTypeSelection) {
            ForEach(0 ..< studTypeList.count, id: \.self) { i in
                Text(studTypeList[i].label).tag(i)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: studTypeSelection) { newValue in
            contentViewModel.updateStudType(studTypeList[newValue])
        }
    }
}

struct StudTypeDropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        StudTypeDropDownMenu(ContentViewModel())
    }
}
