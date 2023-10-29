//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adrian on 28/09/2023.
//


/* View */


import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    let emojis = ["👻","🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    var body: some View {
        ScrollView {
            cards
        }
        .padding()
        
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))] ) {
            ForEach(emojis.indices, id: \.self) { index in return
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundStyle(.orange)
        }
    }
}

struct CardView: View {
    let content: String
    @State  var isFaceUp: Bool = true
    
    var body: some View {
        ZStack(content:  {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        })
        .onTapGesture(perform: {
            // Instead of isFaceUp = !isFaceUp
            isFaceUp.toggle()
        })
    }
}


#Preview {
    EmojiMemoryGameView()
}
