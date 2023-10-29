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
    var model: MemoryGame<String>
    
}

