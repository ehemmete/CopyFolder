//
//  OutputResults.swift
//  CloudCleanupGUI
//
//  Created by Eric Hemmeter on 7/13/23.
//

import Foundation

class OutputResults: ObservableObject {
    @Published var displayOutput: String
    init(displayOutput: String) {
        self.displayOutput = displayOutput
    }
    
    func updateOutput(newText: String) {
        displayOutput.append(newText)
    }
    
    func resetOutput() {
        displayOutput = ""
    }
}
