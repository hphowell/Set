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
            if threeEqualOrNotEqual(first: firstCard.shape, second: secondCard.shape, third: thirdCard.shape) {
                if threeEqualOrNotEqual(first: firstCard.color, second: secondCard.color, third: thirdCard.color) {
                    if threeEqualOrNotEqual(first: firstCard.number, second: secondCard.number, third: thirdCard.number) {
                        if threeEqualOrNotEqual(first: firstCard.shading, second: secondCard.shading, third: thirdCard.shading) {
                            matching = true
                        }
                    }
                }
            }
        }
        return matching
    }
    
    func threeEqualOrNotEqual<T: Equatable>(first: T, second: T, third: T) -> Bool {
        return (first == second && first == third) || (first != second && first != third)
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
            print("Cannot select more than 3 cards or deselect once 3 are chosen.")
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
                matchedCards.append(cardsOnTheBoard.remove(at: matchedCardIndex!))
            }
            selectedCards = []
            score += 3
        } else {
            selectedCards = []
            score -= 5
        }
        if !deck.isEmpty {
            for _ in 0..<3 {
                cardsOnTheBoard.append(deck.remove(at: 0))
            }
        }
    }
    
    init(shapes: [String]) {
        allCards = []
        for shape in shapes {
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
