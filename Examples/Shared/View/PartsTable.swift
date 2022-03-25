//
//  PartsTable.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/24.
//

import SwiftUI
import LegoArtFilter

struct PartsTable: View {
    @Binding var partsList: [PartsData]
    @Binding var digitNumber: Int

    var body: some View {
        List {
            Section("Parts List:") {
                ForEach(partsList, id: \.legoColor.name) { data in
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
    @State static var partsList = [PartsData]()
    @State static var digitNumber = 0

    static var previews: some View {
        PartsTable(partsList: $partsList, digitNumber: $digitNumber)
    }
}
