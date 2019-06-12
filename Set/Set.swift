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
    var cards: [Card]
    var selectedCards: [Card]? = nil
    var matchedCards: [Card]? = nil
    
    var score = 0
    
    func selectCard(at index: Int) {
        
    }
    
    var availableShapes = ["▲","●","■"]
    
    init() {
        cards = []
        for shape in availableShapes {
            for number in 1...3 {
                for shading in Card.Shading.allCases {
                    for color in Card.Color.allCases {
                        let card = Card(shape: shape, color: color, shading: shading, number: number)
                        cards.append(card)
                    }
                }
            }
        }
    }
}
