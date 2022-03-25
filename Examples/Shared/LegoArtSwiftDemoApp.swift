//
//  LegoArtSwiftDemoApp.swift
//  Shared
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI

#if os(iOS)
@main
struct LegoArtSwiftDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(LegoArtImageModel_iOS()))
        }
    }
}
#elseif os(macOS)
@main
struct LegoArtSwiftDemoApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(LegoArtImageModel_macOS()))
                .frame(minWidth: 480, minHeight: 360, alignment: .center)
        }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
#endif
