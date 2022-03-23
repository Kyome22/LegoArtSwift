//
//  PartsTable.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/24.
//

import SwiftUI
import LegoArtFilter

struct PartsTable: View {
    @ObservedObject var contentViewModel: ContentViewModel

    init(_ contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
    }

    var body: some View {
        let digitNumber = contentViewModel.digitNumber
        List {
            Section("Parts List:") {
                ForEach(contentViewModel.partsList, id: \.legoColor.name) { data in
                    HStack {
                        Color(data.legoColor.color)
                            .frame(width: 12, height: 12, alignment: .center)
                            .border(Color.secondary, width: 0.5)
                        Text(data.legoColor.name)
                            .font(.body)
                        Spacer()
                        Text(String(format: "%\(digitNumber)d", data.quantity))
                            .font(.system(.body, design: .monospaced))
                    }
                }
            }
        }
    }
}

struct PartsList_Previews: PreviewProvider {
    static var previews: some View {
        PartsTable(ContentViewModel())
    }
}
