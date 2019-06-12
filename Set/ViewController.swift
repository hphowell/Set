//
//  ViewController.swift
//  Set
//
//  Created by Hayden Howell on 6/11/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shapes = ["▲","●","■"]
    
    lazy var game = Set(shapes: shapes)

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Set(shapes: shapes)
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.selectCard(at: cardButtons.firstIndex(of: sender)!)
        updateViewFromModel()
    }
    
    @IBAction func touchDeal3MoreCards(_ sender: UIButton) {
        if game.cardsOnTheBoard.count < cardButtons.count-2 {
            game.deal3MoreCards()
            updateViewFromModel()
        }
        
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    func getCardLabel(for card: Card) -> NSAttributedString {
        var rawText = ""
        for _ in 0..<card.number {
            rawText += "\(card.shape) "
        }
        
        var strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        var foregroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        switch card.color {
        case .color1:
            strokeColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            foregroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case .color2:
            strokeColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            foregroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        case .color3:
            strokeColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            foregroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        }
        
        var strokeWidth = -1.0
        switch card.shading {
        case .shading1:
            strokeWidth = 5.0
        case .shading2:
            strokeWidth = -1.0
            foregroundColor = foregroundColor.withAlphaComponent(0.15)
        case .shading3:
            strokeWidth = -1.0
        }
        
        let attributes : [NSAttributedString.Key:Any] = [
            .strokeWidth : strokeWidth,
            .strokeColor : strokeColor,
            .foregroundColor : foregroundColor
        ]
        let cardLabel = NSAttributedString(string: rawText, attributes: attributes)
        
        return cardLabel
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cardsOnTheBoard.count {
                let card = game.cardsOnTheBoard[index]
                button.setAttributedTitle(getCardLabel(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                } else {
                    button.layer.borderWidth = 0.0
                }
            } else {
                button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.layer.borderWidth = 0.0
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
}

