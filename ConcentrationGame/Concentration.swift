//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Couragyn Chretien on 04/06/2020.
//  Copyright © 2020 Couragyn Chretien. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var chosenCards = [Int]()
    var scoreChange = 0
    var flipChange = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func calculateScore(by index: Int) {
        if chosenCards.contains(index) {
            
            scoreChange += -1
        } else {
            chosenCards.append(index)
        }
    }
    
    func chooseCard(at index: Int) {
        scoreChange = 0
        flipChange = 0
        if !cards[index].isMatched, index != indexOfOneAndOnlyFaceUpCard {
            flipChange = 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreChange = 2
                } else {
                    calculateScore(by: index)
                    calculateScore(by: matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        Card.resetIdentifier()
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
