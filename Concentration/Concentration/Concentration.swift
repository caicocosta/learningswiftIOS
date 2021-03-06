//
//  Concentration.swift
//  Concentration
//
//  Created by Caico Saler Oliveira Costa on 13/09/21.
//

import Foundation

struct Concentration {
    
    private(set) var cards = Array<Card>()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        
        get {
            
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
/*            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                   if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex*/
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
        
    }
    
    mutating func chooseCard(at index: Int){
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the card")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init(numberOfPairsOfCards: Int) {
      
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of the card")
        for _ in 00..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
