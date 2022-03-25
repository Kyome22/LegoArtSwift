//
//  FileSaveButton_iOS.swift
//  LegoArtSwiftDemo
//
//  Created by Takuto Nakamura on 2022/03/26.
//

import SwiftUI

struct FileSaveButton_iOS: View {
    @Binding private var showingAlert: Bool
    @Binding var message: String

    private let handler: () -> Void

    init(_ showingAlert: Binding<Bool>, _ message: Binding<String>, didPush handler: @escaping () -> Void) {
        self._showingAlert = showingAlert
        self._message = message
        self.handler = handler
    }

    var body: some View {
        return Button("Save Image") {
            handler()
        }
        .buttonStyle(.bordered)
        .alert("Save Image", isPresented: $showingAlert, actions: {
            Button("OK") {
                showingAlert = false
            }
        }, message: {
            Text(message)
        })
    }
}

struct FileSaveButton_iOS_Previews: PreviewProvider {
    @State static var showingAlert: Bool = false
    @State static var message: String = ""

    static var previews: some View {
        FileSaveButton_iOS($showingAlert, $message, didPush: {})
    }
}
