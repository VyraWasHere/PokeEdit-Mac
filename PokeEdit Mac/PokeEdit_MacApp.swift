//
//  PokeEdit_MacApp.swift
//  PokeEdit Mac
//
//  Created by Vyra Nightingale on 19/08/2023.
//

import SwiftUI



@main
struct PokeEdit_MacApp: App {
    @State var save: SaveFile = SaveFile()
    
    var body: some Scene {
        // TODO: Open up a dummy file first instead of launching with file importer
        DocumentGroup(newDocument: SaveFile()) { file in
            ContentView()
                .environment(\.saveFile, file.document)
        }
    }
}
