//
//  ViewController.swift
//  Set
//
//  Created by Hayden Howell on 6/11/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Set()
    
    @IBOutlet weak var board: SetBoardView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Set()
        updateViewFromModel()
    }
    
    func touchCard() {
        if let selectedCardIndex = board?.selectedCardIndex {
            game.selectCard(at: selectedCardIndex)
            updateViewFromModel()
        }
    }
    @IBAction func touchDeal3MoreCards(_ sender: UIButton) {
            game.deal3MoreCards()
            updateViewFromModel()
    }
    
    func updateViewFromModel() {
        board.numberOfCards = game.cardsOnTheBoard.count
        scoreLabel.text = "Score: \(game.score)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        board.createCardsView()

    }
}
