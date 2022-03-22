//
//  FileSelectButton_macOS.swift
//  LegoArtSwiftDemo (macOS)
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileSelectButton_macOS: View {
    @ObservedObject var contentViewModel: ContentViewModel

    init(_ contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
    }

    var body: some View {
        Button("Select Image") {
            let panel = NSOpenPanel()
            panel.allowedContentTypes = [UTType.png, UTType.jpeg]
            panel.canChooseDirectories = false
            panel.allowsMultipleSelection = false
            if panel.runModal() == .OK, let url = panel.url {
                contentViewModel.updateContentURL(url)
            }
        }
    }
}

struct FileSelectView_macOS_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectButton_macOS(ContentViewModel())
    }
}
