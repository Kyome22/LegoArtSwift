//
//  LegoArtSwiftDemoApp.swift
//  Shared
//
//  Created by Takuto Nakamura on 2022/03/22.
//

import SwiftUI

@main
struct LegoArtSwiftDemoApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    #endif

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#if os(macOS)
final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
#endif
