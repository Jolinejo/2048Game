//
//  _048GameApp.swift
//  2048Game
//
//  Created by Maryiam Ajlan on 07/09/2023.
//

import SwiftUI

@main
struct _048GameApp: App {
    let game = NumbersGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
