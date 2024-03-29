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
    var allCards: [Card]
    var deck: [Card]
    var cardsOnTheBoard: [Card]
    var selectedCards: [Card] = []
    var matchedCards: [Card] = []
    var isMatch: Bool {
        var matching = false
        if selectedCards.count == 3 {
            let firstCard = selectedCards[0]
            let secondCard = selectedCards[1]
            let thirdCard = selectedCards[2]
            if threeEqualOrNotEqual(firstCard.shape, secondCard.shape, thirdCard.shape) {
                if threeEqualOrNotEqual(firstCard.color, secondCard.color, thirdCard.color) {
                    if threeEqualOrNotEqual(firstCard.number, secondCard.number, thirdCard.number) {
                        if threeEqualOrNotEqual(firstCard.shading, secondCard.shading, thirdCard.shading) {
                            matching = true
                        }
                    }
                }
            }
        }
        return matching
    }
    
    func threeEqualOrNotEqual<T: Equatable>(_ first: T, _ second: T, _ third: T) -> Bool {
        return (first == second && first == third) || (first != second && first != third && second != third)
    }
    
    var score = 0
    
    func selectCard(at index: Int) {
        if index < cardsOnTheBoard.count, selectedCards.count < 3 {
            if selectedCards.contains(cardsOnTheBoard[index]) {
                deselectCard(at: index)
            } else {
                selectedCards.append(cardsOnTheBoard[index])
            }
        } else if selectedCards.count == 3 {
            selectedCards = []
            selectedCards.append(cardsOnTheBoard[index])
        } else {
            print("Selected card is not on the board.")
        }
    }
    
    func deselectCard(at index: Int) {
        if index < cardsOnTheBoard.count, selectedCards.count > 0, selectedCards.count < 3 {
            let card = cardsOnTheBoard[index]
            if let selectedIndex = selectedCards.firstIndex(of: card) {
                selectedCards.remove(at: selectedIndex)
                score -= 1
            }
        } else if selectedCards.count == 0 {
            print("Cannot deselect a card when none are selected")
        } else {
            print("Cannot deselect a card that is not selected.")
        }
    }
    
    func deal3MoreCards() {
        if isMatch {
            for selectedCardIndex in selectedCards.indices {
                let matchedCardIndex = cardsOnTheBoard.firstIndex(of: selectedCards[selectedCardIndex])
                if deck.isEmpty {
                    matchedCards.append(cardsOnTheBoard.remove(at: matchedCardIndex!))
                } else {
                    cardsOnTheBoard.insert(deck.remove(at: 0), at: matchedCardIndex!)
                    matchedCards.append(cardsOnTheBoard.remove(at: matchedCardIndex! + 1))
                }
            }
            selectedCards = []
            score += 3
        } else if !deck.isEmpty{
            selectedCards = []
            score -= 5
            for _ in 0..<3 {
                cardsOnTheBoard.append(deck.remove(at: 0))
            }
        }
    }
    
    init() {
        allCards = []
        for shape in Card.Shape.allCases {
            for number in 1...3 {
                for shading in Card.Shading.allCases {
                    for color in Card.Color.allCases {
                        let card = Card(shape: shape, color: color, shading: shading, number: number)
                        allCards.append(card)
                    }
                }
            }
        }
        deck = allCards
        deck.shuffle()
        cardsOnTheBoard = []
        for cardIndex in 0..<12 {
            cardsOnTheBoard.append(deck.remove(at: cardIndex))
        }
    }
}
