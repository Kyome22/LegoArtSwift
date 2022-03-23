//
//  ContentView.swift
//  Shared
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI
import LegoArtFilter

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()

    var body: some View {
        VStack {
            Title()
                .font(.title)
                .truncationMode(.middle)
                .lineLimit(1)
                .padding(8)
            LegoArtImage()
                .resizable()
                .scaledToFit()
                .padding(8)
            SelectButton()
                .padding(8)
            DropDownMenus()
                .padding(8)
            PartsTable(contentViewModel)
        }
        .padding(16)
    }

    func Title() -> some View {
        if let url = contentViewModel.contentURL {
            return Text(url.lastPathComponent)
        } else {
            return Text("No Image")
        }
    }

    func LegoArtImage() -> Image {
        if let cgImage = contentViewModel.legoArtCGImage {
            return Image(cgImage, scale: 1.0, label: Text("hoge"))
        } else {
            return Image(systemName: "photo")
        }
    }

    func SelectButton() -> some View {
#if os(iOS)
        FileSelectButton_iOS(contentViewModel)
#elseif os(macOS)
        FileSelectButton_macOS(contentViewModel)
#endif
    }

    func DropDownMenus() -> some View {
        VStack(alignment: .leading) {
            StudTypeDropDownMenu(contentViewModel)
                .padding(.bottom, 8)
            MaxStudDropDownMenu(contentViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
