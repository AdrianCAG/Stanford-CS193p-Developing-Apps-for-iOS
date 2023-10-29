//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Adrian on 29/10/2023.
//


/* ViewModel */


// Your ViewModel is part of your UI. It has to be because remember, it's
// packing up the Model for the UI so it has to know what the UI looks like.
// BUT ViewModel is not going to be createing Views or any of that stuff, the
// View is going to do that.
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    // What static means is, making emojis global but namespace it inside of my class.
    // Global variable are initialized first
    private static let emojis = ["👻","🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    // return types always have to be explicit
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(
            numberOfPairOfCards: 16) { pairIndex in
                if emojis.indices.contains(pairIndex) {
                    return emojis[pairIndex]
                } else{
                    return "⁉️"
                }
            }
    }
    
    // If this var changes it will automatically say something changed, and this
    // is the primary way that we do the "something changed", we just mark vars.
    // This var is private, and it doesn't matter, because private just means that the
    // view can't see it, but that doesn't mean it can't cause something changed.
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}


