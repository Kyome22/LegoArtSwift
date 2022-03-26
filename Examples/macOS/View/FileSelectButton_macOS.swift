//
//  FileSelectButton_macOS.swift
//  LegoArtSwiftDemo (macOS)
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileSelectButton_macOS: View {
    private let handler: (URL?) -> Void

    init(didSelect handler: @escaping (URL?) -> Void) {
        self.handler = handler
    }
    
    var body: some View {
        Button("Select Image") {
            let panel = NSOpenPanel()
            panel.allowedContentTypes = [UTType.png, UTType.jpeg]
            panel.canChooseDirectories = false
            panel.allowsMultipleSelection = false
            panel.message = "Select Image"
            if let window = NSApplication.shared.mainWindow {
                panel.beginSheetModal(for: window) { response in
                    if response == .OK {
                        handler(panel.url)
                    }
                }
            } else if panel.runModal() == .OK {
                handler(panel.url)
            }
        }
    }
}

struct FileSelectView_macOS_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectButton_macOS(didSelect: { _ in })
    }
}
