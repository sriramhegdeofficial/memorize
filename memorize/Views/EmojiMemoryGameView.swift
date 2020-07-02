

import SwiftUI

struct EmojiMemoryGameView : View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    
    var body : some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // What to perform
                    withAnimation(.easeInOut(duration: 0.8)) {
                        self.viewModel.newGame()
                    }
                    
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
                        withAnimation(.linear(duration: 0.9)) {
                            self.viewModel.choose(card: card)
                            
                        }
                             DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                             self.viewModel.resetGame()
                                         }
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
                            .rotationEffect(Angle.degrees(self.card.isMatched ? 360 : 0))
                            .animation(self.card.isMatched ? Animation.linear(duration: 0.6).repeatForever(autoreverses: false) : .default)
                    
                }
                .cardify(isFaceUp: self.card.isFaceUp, theme: self.theme)
                .font(Font.system(size: min(geometry.size.width, geometry.size.height) * self.multiplier))
                .foregroundColor(self.theme.themeColor)
                .transition(AnyTransition.scale)
                
            }
        }
        
    }
}














struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
