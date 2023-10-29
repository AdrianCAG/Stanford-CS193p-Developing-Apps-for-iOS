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




class EmojiMemoryGame {
    // What static means is, making emojis global but namespace it inside of my class.
    // Global variable are initialized first
    private static let emojis = ["👻","🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    // return types always have to be explicit
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(
            numberOfPairOfCards: 4) { pairIndex in
                if emojis.indices.contains(pairIndex) {
                    return emojis[pairIndex]
                } else{
                    return "⁉️"
                }
            }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}


