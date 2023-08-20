//
//  PokeEdit_MacApp.swift
//  PokeEdit Mac
//
//  Created by Vyra Nightingale on 19/08/2023.
//

import SwiftUI

@main
struct PokeEdit_MacApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: PokeSav()) { file in
            ContentView(save: file.$document)
        }
    }
}
