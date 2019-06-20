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
    
    @objc func touchCard(_ sender: UITapGestureRecognizer) {
        if let selectedCardIndex = board?.cards.firstIndex(of: sender.view as! SetCardView) {
            game.selectCard(at: selectedCardIndex)
            board.cards[selectedCardIndex].cardIsSelected = game.selectedCards.contains(game.cardsOnTheBoard[selectedCardIndex])
            updateViewFromModel()
        }
    }
    @IBAction func touchDeal3MoreCards(_ sender: UIButton) {
        game.deal3MoreCards()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        board.numberOfCards = game.cardsOnTheBoard.count
        for cardIndex in board.cards.indices {
            let boardCard = board.cards[cardIndex]
            let modelCard = game.cardsOnTheBoard[cardIndex]
            
            switch modelCard.color {
            case .color1 : boardCard.color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            case .color2 : boardCard.color = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            case .color3 : boardCard.color = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
            }
            
            switch modelCard.shape {
            case .shape1 : boardCard.shape = "oval"
            case .shape2 : boardCard.shape = "squiggle"
            case .shape3 : boardCard.shape = "diamond"
            }
            
            switch modelCard.shading {
            case .shading1 : boardCard.shading = "empty"
            case .shading2 : boardCard.shading = "striped"
            case .shading3 : boardCard.shading = "filled"
            }
            
            boardCard.number = modelCard.number
            boardCard.cardIsSelected = game.selectedCards.contains(modelCard)
        }
        addCardSelector()
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func addCardSelector() {
        for card in board.cards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(touchCard(_:)))
            card.addGestureRecognizer(tap)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board.createCardsView()
        updateViewFromModel()
    }
}
