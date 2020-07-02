//
//  MemorizeGame.swift
//  memorize
//
//  Created by sriram on 04/06/20.
//  Copyright © 2020 iWeds. All rights reserved.
//

import Foundation


struct MemorizeGame<CardContent> where CardContent : Equatable {
    
    private(set) var cards : Array<Card>
    var score : Int = 0
    private var indexOfOneAndOnlyFaceUpCard : Int?  {
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            }else {
                return nil
            }
        }
        
        set {
            for index in self.cards.indices {
                if index == newValue {
                    self.cards[index].isFaceUp = true
                }else {
                    self.cards[index].isFaceUp = false
                }
            }
        }
    }
    
    func isGameOver() -> Bool {
        
        for index in cards.indices {
            if cards[index].isMatched == false {
                return false
            }
            
        }
        return true
    }
    
    mutating func choose(card: Card) {
        
        
        if let chosenIndex = self.cards.firstIndex(of: card), !self.cards[chosenIndex].isFaceUp , !self.cards[chosenIndex].isMatched{
            
            self.cards[chosenIndex].isChosenBeforeCount += 1
            if self.cards[chosenIndex].isChosenBeforeCount > 1 {
                self.score -= 1
            }
            if let potentialMatchingIndex =  indexOfOneAndOnlyFaceUpCard {
                if self.cards[potentialMatchingIndex].content == card.content {
                    self.cards[chosenIndex].isMatched = true
                    self.cards[potentialMatchingIndex].isMatched = true
                    
                        self.score += 2
                    
                    
                }
                
                
            }else {
               
                indexOfOneAndOnlyFaceUpCard = chosenIndex
                
                
            }
            
            self.cards[chosenIndex].isFaceUp = true
            
            
        }
        
        print("score: \(score)")
        
    }
    
    mutating func newGame(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
               for pairIndex in 0..<numberOfPairsOfCards {
                   let content = cardContentFactory(pairIndex)
                   cards.append(Card(content: content, id: pairIndex * 2))
                   cards.append(Card(content: content, id: pairIndex * 2 + 1))
               }
        cards.shuffle()
    }
    
   
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card : Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id : Int
        var isChosenBeforeCount : Int = 0
        
    }
}
