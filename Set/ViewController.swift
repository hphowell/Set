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
        game.deal3MoreCards()
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cardsOnTheBoard.count {
                let card = game.cardsOnTheBoard[index]
                button.setTitle(String(index), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                } else {
                    button.layer.borderWidth = 0.0
                }
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.layer.borderWidth = 0.0
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
}

