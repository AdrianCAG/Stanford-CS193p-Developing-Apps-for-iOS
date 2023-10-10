//
//  ContentView.swift
//  AssignmentOneMemorizeWithComments
//
//  Created by Adrian on 10/10/2023.
//


import SwiftUI

struct ContentView: View {
     
    // These arrays store emoji symbols representing various themes, such as Halloween, Christmas, and Space.
    // The arrays serve as sources for emoji content used in the card game.
    let halloween = ["👻","🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    let christmas = ["🎅", "🎄", "🦌", "🎁", "⛄", "🔔", "🕯️", "🤶", "🧑‍🎄", "❄️", "🍪", "🥛", "🏠", "🌟", "🔮", "🦌"]
    let space = ["🚀", "🌠", "🛰️", "🪐", "🌕", "🌌", "👾", "🌑", "🌙", "🌎", "🌟", "🌗", "🌛", "🛸"]
    
    
    /**
     An array of emoji symbols for the currently displayed cards.
     
     This array stores the emoji symbols that will be displayed on the cards in the grid.
     It is used to control the content of the cards during gameplay.

     - Note: The contents of this array change when themes are selected.

     - SeeAlso: `halloween`, `christmas`, `space`
     */
    @State var emoji: Array<String> = []
    
    
    /**
     The number of cards to display in the grid.
     
     This state property controls the number of cards shown in the grid.
     It can be adjusted using the card count adjustment controls.

     - Note: The range of card count can be controlled to ensure it's within a valid range.

     - SeeAlso: `cardAdjustmentControls`
     */
    @State var cardCount = 0
    
    
    /**
     The color style for the displayed cards.
     
     This state property determines the color style applied to the cards in the grid.
     It can be changed when selecting different themes.

     - Note: The color style affects the appearance of the cards in the grid.

     - SeeAlso: `themeButton`
     */
    @State var color: Color = Color.clear
    
    
    /**
     The body of the main content view.

     This property defines the structure and layout of the main content view. It consists of a vertical stack containing the game title, card grid, and card adjustment controls.

     - Returns: A SwiftUI view representing the main content of the card-matching game.
     */
    var body: some View {
        VStack {
            // Display the game title with a large serif font.
            Text("Memorize!").font(.largeTitle).fontDesign(.serif)
            // Create a scrollable view to display the game cards.
            ScrollView {
                cards
            }
            
            cardAdjustmentControls
        }
        .padding()
    }
    
    
    /**
     A view containing card count adjustment controls.

     This view provides user interface elements for increasing or decreasing the number of displayed cards. It also includes a theme picker to select different themes for the cards.

     - Returns: A SwiftUI view with card count adjustment controls.
     */
    var cardAdjustmentControls: some View {
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
    
    
    /**
     A view containing theme selection buttons.

     This view displays buttons for selecting different themes. Users can tap these buttons to change the theme of the cards displayed in the grid.

     - Returns: A SwiftUI view with theme selection buttons.
     */
    var themePicker: some View {
        HStack {
            halloweenTheme
            spaceTheme
            christmasTheme
        }
    }
    

    /**
     A view displaying the grid of game cards.

     This computed property creates a SwiftUI view representing the grid of game cards. It uses a `LazyVGrid` to arrange the cards in a grid layout, and it populates the grid with emoji symbols. The card count and appearance are influenced by the `cardCount` and `color` properties.

     - Returns: A SwiftUI view representing the grid of game cards.
     */
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount)))] ) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emoji[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundStyle(color)
        }
    }
    
   
    /**
     Creates a card count adjustment button.

     This function generates a SwiftUI button with an action to adjust the card count based on the specified offset. It also includes a symbol as a visual representation of the adjustment.

     - Parameters:
       - offset: The amount by which to adjust the card count (positive or negative).
       - symbol: The system symbol name used as the button's visual representation.

     - Returns: A SwiftUI button for adjusting the card count.
     */
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emoji.count)
    }
    
    
    /**
     Creates a themed button for selecting a new theme.

     This function generates a SwiftUI button associated with a specific theme. When tapped, it updates the card color, emoji content, and card count based on the selected theme.

     - Parameters:
       - theme: An array of emoji strings representing the theme.
       - themeName: The name of the theme.
       - themeEmoji: The emoji symbol representing the theme.
       - colorChange: The color style to apply when the theme is selected.

     - Returns: A SwiftUI button with the specified theme and functionality.
     */
    func themeButton(_ theme: [String], _ themeName: String, _ themeEmoji: String, _ colorChange: Color) -> some View {
        Button(action: {
            // Update the card color, emoji content, and card count.
            color = colorChange
            emoji = theme.shuffled()
            cardCount = Int.random(in: 2..<emoji.count)
        }, label: {
            VStack {
                // Display the theme emoji and name.
                Image(systemName: themeEmoji)
                Text(themeName)
            }
            .font(.footnote)
        })
    }
    

    /**
     Calculates the width that best fits the given number of cards in a grid.

     This function calculates the ideal width for cards in a grid layout based on the provided `cardCount`. The width is determined using a mathematical formula that considers the square root of the card count.

     - Parameters:
       - cardCount: The number of cards to be displayed in the grid.

     - Returns: The recommended width for cards in the grid.
     */
    func widthThatBestFits(_ cardCount: Int) -> CGFloat {
        // Calculate and return the recommended width based on the card count.
        return CGFloat(1/sqrt(Double(cardCount)) * 200)
    }
    
    
    /**
     A view that provides a card count reduction control.

     This computed property creates a view containing a button for decreasing the card count by one. The button is represented by a system symbol.

     - Returns: A SwiftUI view for reducing the card count.
     */
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    
    /**
     A view that provides a card count increase control.

     This computed property creates a view containing a button for increasing the card count by one. The button is represented by a system symbol.

     - Returns: A SwiftUI view for increasing the card count.
     */
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    
    /**
     A view that provides a Halloween theme selection control.

     This computed property creates a view containing a button for selecting the Halloween theme. When tapped, it changes the color style and shuffles emoji symbols associated with Halloween.

     - Returns: A SwiftUI view for selecting the Halloween theme.
     */
    var halloweenTheme: some View {
        themeButton(halloween, "Halloween", "figure.2.and.child.holdinghands", Color.orange)
    }
    
    
    /**
     A view that provides a Christmas theme selection control.

     This computed property creates a view containing a button for selecting the Christmas theme. When tapped, it changes the color style and shuffles emoji symbols associated with Christmas.

     - Returns: A SwiftUI view for selecting the Christmas theme.
     */
    var christmasTheme: some View {
        themeButton(christmas, "Christmas", "cloud.snow.fill", Color.blue)
    }
    
    
    /**
     A view that provides a Space theme selection control.

     This computed property creates a view containing a button for selecting the Space theme. When tapped, it changes the color style and shuffles emoji symbols associated with Space.

     - Returns: A SwiftUI view for selecting the Space theme.
     */
    var spaceTheme: some View {
        themeButton(space, "Space", "sparkles", Color.purple)
    }
}


/**
 A SwiftUI view representing a card.

 This view displays a card with emoji content that can be toggled between face-up and face-down states when tapped.

 - Parameters:
   - content: The emoji content to display on the card.
   - isFaceUp: A boolean indicating whether the card is face-up or face-down.

 - Returns: A SwiftUI view representing a card with emoji content.
 */
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
