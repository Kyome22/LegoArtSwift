//
//  FileSaveView_macOS.swift
//  LegoArtFilterDemo (macOS)
//
//  Created by Takuto Nakamura on 2021/10/16.
//

import SwiftUI

struct FileSaveView_macOS: View {
    @Binding var image: NSImage?
    
    var body: some View {
        Button("Save Image") {
            guard let image = self.image else { return }
            let panel = NSSavePanel()
            panel.canCreateDirectories = true
            panel.directoryURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
            panel.isExtensionHidden = true
            if panel.runModal() == .OK, let url = panel.url {
                self.saveImage(image, url)
            }
        }
    }
    
    private func saveImage(_ image: NSImage, _ url: URL) {
        if let imageData = image.tiffRepresentation,
           let rep = NSBitmapImageRep(data: imageData),
           let pngData = rep.representation(using: .png, properties: [:]) {
            do {
                try pngData.write(to: url)
            } catch {
                Swift.print(error.localizedDescription)
            }
        }
    }
}

struct FileSaveView_macOS_Previews: PreviewProvider {
    @State static var image: NSImage? = nil
    
    static var previews: some View {
        FileSaveView_macOS(image: $image)
    }
}
