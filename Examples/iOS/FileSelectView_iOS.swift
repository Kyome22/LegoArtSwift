//
//  FileSelectView.swift
//  LegoArtFilterDemo (macOS)
//
//  Created by Takuto Nakamura on 2021/10/11.
//

import SwiftUI

struct FileSelectView_iOS: View {
    @State var showingFileChooser = false
    @Binding var contentURL: URL?
    
    var body: some View {
        Button("Select Image") {
            showingFileChooser = true
        }
        .sheet(isPresented: $showingFileChooser) {
            return FileChooser(selectedURL: $contentURL)
        }
    }
}

struct FileSelectView_iOS_Previews: PreviewProvider {
    @State static var contentURL: URL? = nil
    
    static var previews: some View {
        FileSelectView_iOS(contentURL: $contentURL)
    }
}
