//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Adrian on 29/10/2023.
//


/* Model */


import Foundation


struct MemoryGame<CardContent> {
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
    }
    
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
}
