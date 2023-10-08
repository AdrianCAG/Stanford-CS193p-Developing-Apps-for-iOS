//
//  ContentView.swift
//  Memorize
//
//  Created by Adrian on 28/09/2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    // @State is good for demos
    @State var cardCount = 4
    
    var body: some View {
        // Declarative UI
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
        
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        // One line of code (Creates an HStack and then modifies it)
        /*
         HStack {
            // use empjis.indices instead of range to show content of array
            ForEach(0..<cardCount, id: \.self) { index in return
                CardView(content: emojis[index])
            }
         */
        
        // LazyVGrid uses as little spaces as it can, whereas HStack uses as
        // much space as it can. When a whole row of cards are face down,
        // it shrinks down, because a LazyVGrid makes it as small as possible,
        // and when there're no emoji showing those cards can be really small.
        // To fix this we need to change code in CardView.
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))] ) {
            ForEach(0..<cardCount, id: \.self) { index in return
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundStyle(.orange)
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    // Closure-based View
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
      
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
            // This mechanism of using opacity is a good way to switch
            // between two states where you need sizing and spacing for
            // all of states. The problem with if-else was that when we
            // had it being face up then the background was not even there,
            // and vice versa.
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        })
        .onTapGesture(perform: {
            // Instead of isFaceUp = !isFaceUp
            isFaceUp.toggle()
        })
    }
}

/*
struct CardView: View {
    let content: String
    @State  var isFaceUp: Bool = true
    
    var body: some View {
        ZStack(content:  {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        })
        .onTapGesture(perform: {
            // Instead of isFaceUp = !isFaceUp
            isFaceUp.toggle()
        })
    }
}
*/

#Preview {
    ContentView()
}
