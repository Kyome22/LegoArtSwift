//
//  MaxStudDropDownMenu.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI

struct MaxStudDropDownMenu: View {
    @State var maxStudSelection: Int

    private let maxStudList: [Int]
    private let handler: (Int) -> Void

    init(
        maxStudList: [Int],
        defaultSelection: Int,
        didChange handler: @escaping (Int) -> Void
    ) {
        self.maxStudList = maxStudList
        self.maxStudSelection = defaultSelection
        self.handler = handler
    }

    var body: some View {
        Picker("Max Stud:", selection: $maxStudSelection) {
            ForEach(0 ..< maxStudList.count, id: \.self) { i in
                Text(String(maxStudList[i])).tag(i)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: maxStudSelection) { newValue in
            handler(maxStudList[newValue])
        }
    }
}

struct MaxStudDropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        MaxStudDropDownMenu(maxStudList: [],
                            defaultSelection: 0,
                            didChange: { _ in })
    }
}
