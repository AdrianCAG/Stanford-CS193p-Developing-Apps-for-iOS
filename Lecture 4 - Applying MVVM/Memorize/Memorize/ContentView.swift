//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adrian on 28/09/2023.
//


/* View */


import SwiftUI

struct EmojiMemoryGameView: View {
    // Never say @ObservedObject equal something. Observed objects always have to
    // be passed into, because they have to be marked as the truth, as state. An
    // @ObservedObject is not a truth thing. It's just saying "I'm observing this
    // thing". You can use @StateObject equal something: @StateObject var test = ...
    // This also isn't much better tha just doing @State on your model because it's
    // only inside this View, so you could never share this ViewModel with any other
    // View.
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Button("shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0 ) {
            ForEach(viewModel.cards.indices, id: \.self) { index in return
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
            .foregroundStyle(.orange)
        }
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack(content:  {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        })
    }
}


#Preview {
    // Like the explanation from above here is a good example of how everyone who
    // creates this would pass it into you, like any other struct. Here is ok to
    // create on the fly because your preview is constanlty getting redrawn all
    // the time anyway. The other really important place you would chanege it is
    // in your app (MemorizeApp)
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
