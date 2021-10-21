//
//  FileChooser.swift
//  LegoArtFilterDemo (macOS)
//
//  Created by Takuto Nakamura on 2021/10/11.
//

import UIKit
import SwiftUI

struct FileChooser: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedURL: URL?
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<FileChooser>
    ) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.allowsEditing = false
        controller.sourceType = sourceType
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {}
    
    func makeCoordinator() -> FileChooserCoordinator {
        return FileChooserCoordinator(self)
    }
}

final class FileChooserCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: FileChooser
    
    init(_ parent: FileChooser) {
        self.parent = parent
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let url = info[.imageURL] as? URL {
            parent.selectedURL = url
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
}
