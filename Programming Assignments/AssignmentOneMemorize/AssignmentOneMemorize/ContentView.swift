//
//  ContentView.swift
//  AssignmentOneMemorize
//
//  Created by Adrian on 08/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    let halloween = ["👻","🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    let christmas = ["🎅", "🎄", "🦌", "🎁", "⛄", "🔔", "🕯️", "🤶", "🧑‍🎄", "❄️", "🍪", "🥛", "🏠", "🌟", "🔮", "🦌"]
    let space = ["🚀", "🌠", "🛰️", "🪐", "🌕", "🌌", "👾", "🌑", "🌙", "🌎", "🌟", "🌗", "🌛", "🛸"]
    
    @State var emoji: Array<String> = []
    @State var cardCount = 0
    @State var color: Color = Color.clear
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle).fontDesign(.serif)
            ScrollView {
                cards
            }
            cardCountAdjusters
        }
        .padding()
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            themePicker
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var themePicker: some View {
        HStack {
            halloweenTheme
            spaceTheme
            christmasTheme
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount)))] ) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emoji[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundStyle(color)
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emoji.count)
    }
    
    func themeButton(_ theme: [String], _ themeName: String, _ themeEmoji: String, _ colorChange: Color) -> some View {
        Button(action: {
            color = colorChange
            emoji = theme.shuffled()
            cardCount = Int.random(in: 2..<emoji.count)
        }, label: {
            VStack {
                Image(systemName: themeEmoji)
                Text(themeName)
            }
            .font(.footnote)
        })
    }
    
    func widthThatBestFits(_ cardCount: Int) -> CGFloat {return CGFloat(1/sqrt(Double(cardCount)) * 200)}
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var halloweenTheme: some View {
        themeButton(halloween, "Halloween", "figure.2.and.child.holdinghands", Color.orange)
    }
    
    var christmasTheme: some View {
        themeButton(christmas, "Christmas", "cloud.snow.fill", Color.blue)
    }
    
    var spaceTheme: some View {
        themeButton(space, "Space", "sparkles", Color.purple)
    }
    
}


struct CardView: View {
    let content: String
    @State  var isFaceUp: Bool = false
    
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
            isFaceUp.toggle()
        })
    }
}


#Preview {
    ContentView()
}
