//
//  ViewController.swift
//  Set
//
//  Created by Hayden Howell on 6/11/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = Set()

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Set()
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
        
    }
}

