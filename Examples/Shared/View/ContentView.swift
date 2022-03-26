//
//  ContentView.swift
//  Shared
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI
import LegoArtFilter

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel

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
            Buttons()
                .padding(8)
            DropDownMenus()
                .padding(8)
            PartsTable(partsList: $viewModel.partsList,
                       digitNumber: $viewModel.digitNumber)
        }
        .padding(16)
    }

    func Title() -> some View {
        if let url = viewModel.contentURL {
            return Text(url.lastPathComponent)
        } else {
            return Text("No Image")
        }
    }

    func LegoArtImage() -> Image {
        if let cgImage = viewModel.legoArtCGImage {
            return Image(cgImage, scale: 1.0, label: Text("hoge"))
        } else {
            return Image(systemName: "photo")
        }
    }

    func Buttons() -> some View {
        HStack {
#if os(iOS)
            FileSelectButton_iOS { url in
                viewModel.contentURL = url
            }
            FileSaveButton_iOS($viewModel.showingAlert, $viewModel.message) {
                viewModel.saveLegoArt()
            }
            .disabled(viewModel.legoArtCGImage == nil)
#elseif os(macOS)
            FileSelectButton_macOS { url in
                viewModel.contentURL = url
            }
            FileSaveButton_macOS { url in
                viewModel.saveLegoArt(saveURL: url)
            }
            .disabled(viewModel.legoArtCGImage == nil)
#endif
        }
    }

    func DropDownMenus() -> some View {
        VStack(alignment: .leading) {
            StudTypeDropDownMenu(studTypeList: viewModel.studTypeList,
                                 defaultSelection: viewModel.studTypeDefaultSelection,
                                 didChange: { studType in
                viewModel.studType = studType
            })
                .padding(.bottom, 8)
            MaxStudDropDownMenu(maxStudList: viewModel.maxStudList,
                                defaultSelection: viewModel.maxStudDefaultSelection,
                                didChange: { maxStud in
                viewModel.maxStud = maxStud
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
#if os(iOS)
        ContentView(viewModel: ContentViewModel(LegoArtImageModel_iOS()))
#elseif os(macOS)
        ContentView(viewModel: ContentViewModel(LegoArtImageModel_macOS()))
#endif
    }
}
