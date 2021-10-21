//
//  FileSelectView_macOS.swift
//  LegoArtFilterDemo (macOS)
//
//  Created by Takuto Nakamura on 2021/10/11.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileSelectView_macOS: View {
    @Binding var contentURL: URL?
        
    var body: some View {
        Button("Select Image") {
            let panel = NSOpenPanel()
            panel.allowedContentTypes = [UTType.png, UTType.jpeg]
            panel.canChooseDirectories = false
            panel.allowsMultipleSelection = false
            if panel.runModal() == .OK, let url = panel.url {
                contentURL = url
            }
        }
    }
}

struct FileSelectView_macOS_Previews: PreviewProvider {
    @State static var contentURL: URL? = nil
    
    static var previews: some View {
        FileSelectView_macOS(contentURL: $contentURL)
    }
}
