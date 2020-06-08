

import SwiftUI

struct EmojiMemoryGameView : View {
    @ObservedObject var viewModel : EmojiMemoryGame
    var body : some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // What to perform
                    self.viewModel.newGame()
                }) {
                    // How the button looks like
                    Text("New Game")
                }
                Spacer()
                Text(self.viewModel.getTheme().themeName)
                Spacer()
            }
            .padding()
            
            Grid(viewModel.cards) {   card in
                      CardView(card: card, theme: self.viewModel.getTheme()).onTapGesture {
                                   self.viewModel.choose(card: card)
                               }
                  .padding(5)
                           }
            HStack {
                
                Text("Score : \(self.viewModel.score)")
            }
        }
       
        
        
    }
}


struct CardView : View {
    var card : MemorizeGame<String>.Card
    var theme : Themes.Theme
    private let multiplier: CGFloat = 0.6
    
    var body: some View {
        
        GeometryReader { geometry in
            if self.card.isFaceUp || !self.card.isMatched {
                ZStack {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(20), clockwise: true ).padding(5).opacity(0.4)
                        Text(self.card.content)
                }
                .cardify(theme: self.theme, isFaceUp: self.card.isFaceUp)
                .font(Font.system(size: min(geometry.size.width, geometry.size.height) * self.multiplier))
                .foregroundColor(self.theme.themeColor)
            }
        }
        
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
       return EmojiMemoryGameView(viewModel: game)
    }
}
