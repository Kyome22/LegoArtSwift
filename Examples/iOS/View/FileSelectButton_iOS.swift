//
//  FileSelectButton_iOS.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI

struct FileSelectButton_iOS: View {
    @ObservedObject var contentViewModel: ContentViewModel

    @State var showingFileChooser = false
    @State var selectedURL: URL?

    init(_ contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
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
            contentViewModel.updateContentURL(newValue)
        }
    }
}

struct FileSelectView_iOS_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectButton_iOS(ContentViewModel())
    }
}
