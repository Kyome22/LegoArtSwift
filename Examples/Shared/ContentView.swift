//
//  ContentView.swift
//  Shared
//
//  Created by Takuto Nakamura on 2021/10/11.
//

import SwiftUI
import LegoArtFilter

struct ContentView: View {
    let studTypeList: [StudType] = [.round, .roundPlate, .square, .squarePlate]
    let maxStudList: [Int] = (0 ..< 8).map { 16 * ($0 + 1) }
    
    @State var contentURL: URL? = nil
    @State var studTypeSelection: Int = 0
    @State var maxStudSelection: Int = 2
    
    var body: some View {
        VStack {
            title
                .font(.title)
                .truncationMode(.middle)
                .lineLimit(1)
                .padding(16)
            legoImage
                .resizable()
                .scaledToFit()
                .padding(16)
            selectButton
                .padding(.bottom, 16)
#if os(iOS)
            VStack(alignment: .leading) {
                Text("Stud Type:")
                studTypeDropDownMenu
                    .padding(.bottom, 8)
                Text("Max Stud:")
                maxStudDropDownMenu
            }
#elseif os(macOS)
            VStack(alignment: .leading) {
                studTypeDropDownMenu
                maxStudDropDownMenu
            }
            .frame(width: 400)
#endif
        }
#if os(iOS)
        .frame(minWidth: 240, minHeight: 180, alignment: .center)
#elseif os(macOS)
        .frame(minWidth: 480, minHeight: 360, alignment: .center)
#endif
        .padding(16)
    }
    
    var title: some View {
        if let url = contentURL {
            return Text(url.lastPathComponent)
        } else {
            return Text("No Image")
        }
    }
    
    var legoImage: Image {
        let studType = studTypeList[studTypeSelection]
        let maxStud = maxStudList[maxStudSelection]
        if let url = contentURL,
           let image = nativeLegoImage(url: url, studType: studType, maxStud: maxStud) {
            return image
        }
        return Image(systemName: "photo")
    }
    
    private func nativeLegoImage(url: URL, studType: StudType, maxStud: Int) -> Image? {
#if os(iOS)
        guard let data = try? Data(contentsOf: url),
              let uiImage = UIImage(data: data),
              let legoArt = LegoArt(from: uiImage, studType: studType, maxStud: maxStud),
              let legoUIImage = legoArt.exportUIImage()
        else {
            return nil
        }
        return Image(uiImage: legoUIImage)
#elseif os(macOS)
        guard let nsImage = NSImage(contentsOf: url),
              let legoArt = LegoArt(from: nsImage, studType: studType, maxStud: maxStud),
              let legoNSImage = legoArt.exportNSImage()
        else {
            return nil
        }
        return Image(nsImage: legoNSImage)
#endif
    }
    
    var selectButton: some View {
#if os(iOS)
        FileSelectView_iOS(contentURL: $contentURL)
#elseif os(macOS)
        FileSelectView_macOS(contentURL: $contentURL)
#endif
    }
    
    var studTypeDropDownMenu: some View {
        Picker("Stud Type:", selection: $studTypeSelection) {
            ForEach(0 ..< studTypeList.count, id: \.self) { i in
                Text(studTypeList[i].label).tag(i)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var maxStudDropDownMenu: some View {
        Picker("Max Stud:", selection: $maxStudSelection) {
            ForEach(0 ..< maxStudList.count, id: \.self) { i in
                Text(String(maxStudList[i])).tag(i)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
