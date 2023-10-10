//
//  ContentView.swift
//  CopyFolder
//
//  Created by Eric Hemmeter on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var outputLocationURL: URL?
    @State var sourceFolderURL: URL?
    @MainActor @StateObject var outputResults = OutputResults(displayOutput: "")
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Select source folder:")
                TextField("", text: Binding(
                    get: { sourceFolderURL?.path ?? "" },
                    set: { sourceFolderURL = URL(filePath: $0) })
                )
                .disabled(true)
                
                Button {
                    let panel = NSOpenPanel()
                    panel.title = "Where to create a copy:"
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = true
                    panel.canCreateDirectories = true
                    if panel.runModal() == .OK {
                        sourceFolderURL = panel.url
                    }
                } label: {
                    Image(systemName: "folder.fill.badge.plus")
                }
            }
            HStack {
                Text("Select output location:")
                TextField("", text: Binding(
                    get: { outputLocationURL?.path ?? "" },
                    set: { outputLocationURL = URL(filePath: $0) })
                )
                .disabled(true)
                
                Button {
                    let panel = NSOpenPanel()
                    panel.title = "Where to create a copy:"
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = true
                    panel.canCreateDirectories = true
                    if panel.runModal() == .OK {
                        outputLocationURL = panel.url
                    }
                } label: {
                    Image(systemName: "folder.fill.badge.plus")
                }
            }
            Button("Copy") {
                let rootDirFolderName = sourceFolderURL!.lastPathComponent
                let fileManager = FileManager.default
                do {
                    try fileManager.copyItem(at: sourceFolderURL!, to: outputLocationURL!.appending(component: rootDirFolderName))
                    outputResults.updateOutput(newText: "Copied \(sourceFolderURL!.path) to \(outputLocationURL!.path)")
                } catch {
                    outputResults.updateOutput(newText: "Copy failed - \(error)")
                }
            }.disabled(sourceFolderURL == nil || outputLocationURL == nil)
            Text(outputResults.displayOutput)
                .textSelection(.enabled)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
