//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by sriram on 04/06/20.
//  Copyright © 2020 iWeds. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
     @Published private  var model : MemorizeGame<String> = createMemorizeGame()
     static var theme : Themes.Theme = Themes(selectedThemeIndex: getRandomThemeIndex()).selectedTheme
    
    private static func createMemorizeGame() -> MemorizeGame<String> {
    
        let random = Int(arc4random_uniform(4) + 2)
        theme = Themes(selectedThemeIndex: getRandomThemeIndex()).selectedTheme
        return MemorizeGame<String>(numberOfPairsOfCards: random) {pairIndex in
            return EmojiMemoryGame.theme.themeContent[pairIndex]
        }
    }
    
    static func getRandomThemeIndex() -> Int {
        let randomIndex = arc4random_uniform(UInt32(Themes.allThemes.count))
        return Int(randomIndex)
        
    }
    
    var score : String {
        return String(model.score)
    }
    
    func newGame() {
        
        model = EmojiMemoryGame.createMemorizeGame()
    }
    
    func resetGame() {
        if model.isGameOver() == true {
            
            self.newGame()
        }
    }
    
    func getTheme() -> Themes.Theme {
        return EmojiMemoryGame.theme
    }
    
    var cards : Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    func choose(card: MemorizeGame<String>.Card) {
        model.choose(card: card)
    }
}
