//
//  FileSelectButton_iOS.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI

struct FileSelectButton_iOS: View {
    @State var showingFileChooser = false
    @State var selectedURL: URL?

    private let handler: (URL?) -> Void

    init(didSelect handler: @escaping (URL?) -> Void) {
        self.handler = handler
    }

    var body: some View {
        Button("Select Image") {
            showingFileChooser = true
        }
        .buttonStyle(.bordered)
        .sheet(isPresented: $showingFileChooser) {
            FileChooser(selectedURL: $selectedURL)
        }
        .onChange(of: selectedURL) { newValue in
            handler(newValue)
        }
    }
}

struct FileSelectView_iOS_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectButton_iOS(didSelect: { _ in })
    }
}
