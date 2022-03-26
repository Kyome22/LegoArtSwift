//
//  StudTypeDropDownMenu.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI
import LegoArtFilter

struct StudTypeDropDownMenu: View {
    @State var studTypeSelection: Int

    private let studTypeList: [StudType]
    private let handler: (StudType) -> Void

    init(
        studTypeList: [StudType],
        defaultSelection: Int,
        didChange handler: @escaping (StudType) -> Void
    ) {
        self.studTypeList = studTypeList
        self.studTypeSelection = defaultSelection
        self.handler = handler
    }

    var body: some View {
        Picker("Stud Type:", selection: $studTypeSelection) {
            ForEach(0 ..< studTypeList.count, id: \.self) { i in
                Text(studTypeList[i].label).tag(i)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: studTypeSelection) { newValue in
            handler(studTypeList[newValue])
        }
    }
}

struct StudTypeDropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        StudTypeDropDownMenu(studTypeList: [],
                             defaultSelection: 0,
                             didChange: { _ in })
    }
}
