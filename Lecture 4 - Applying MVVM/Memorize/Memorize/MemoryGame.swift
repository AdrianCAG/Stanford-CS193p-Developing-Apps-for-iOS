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
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
    
    private(set) var cards: Array<Card>
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
}
