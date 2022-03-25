//
//  FileSaveButton_macOS.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileSaveButton_macOS: View {
    private let handler: (URL) -> Void

    init(didDecide handler: @escaping (URL) -> Void) {
        self.handler = handler
    }
    
    var body: some View {
        Button("Save Image") {
            let panel = NSSavePanel()
            panel.directoryURL = URL(fileURLWithPath: "\(NSHomeDirectory())/Desktop")
            panel.allowedContentTypes = [UTType.png, UTType.jpeg]
            panel.canCreateDirectories = true
            panel.isExtensionHidden = false
            panel.message = "Save Image (PNG or JPEG)"
            if let window = NSApplication.shared.mainWindow {
                panel.beginSheetModal(for: window) { response in
                    if response == .OK, let url = panel.url {
                        handler(url)
                    }
                }
            } else if panel.runModal() == .OK, let url = panel.url {
                handler(url)
            }
        }
    }
}

struct FileSaveButton_macOS_Previews: PreviewProvider {
    static var previews: some View {
        FileSaveButton_macOS(didDecide: { _ in })
    }
}
