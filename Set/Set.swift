//
//  File.swift
//  Set
//
//  Created by Hayden Howell on 6/11/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import Foundation

class Set
{
    var deck: [Card]
    var cardsOnTheBoard: [Card]
    var selectedCards: [Card] = []
    var matchedCards: [Card] = []
    var isMatch: Bool {
        get {
            var matching = false
            if selectedCards.count == 3 {
                matching = true
            }
            return matching
        }
    }
    
    var score = 0
    
    func selectCard(at index: Int) {
        selectedCards.append(cardsOnTheBoard[index])
    }
    
    func deal3MoreCards() {
        if isMatch {
            for cardIndex in selectedCards.indices {
                matchedCards.append(selectedCards.remove(at: cardIndex))
            selectedCards = []
            }
        }
        if !deck.isEmpty {
            for cardIndex in 0..<3 {
                cardsOnTheBoard.append(deck.remove(at: cardIndex))
            }
        }
    }
    
    var availableShapes = ["▲","●","■"]
    
    init() {
        deck = []
        for shape in availableShapes {
            for number in 1...3 {
                for shading in Card.Shading.allCases {
                    for color in Card.Color.allCases {
                        let card = Card(shape: shape, color: color, shading: shading, number: number)
                        deck.append(card)
                    }
                }
            }
        }
        deck.shuffle()
        cardsOnTheBoard = []
        for cardIndex in 0..<12 {
            cardsOnTheBoard.append(deck.remove(at: cardIndex))
        }
    }
}
