//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Adrian on 28/09/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // Apps like Views can have @StateObjects. But somewhere there needs be state.
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
