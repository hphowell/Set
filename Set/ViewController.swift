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
    
    @IBOutlet weak var deck: SetDeckView!
    
    @IBOutlet weak var discardPile: SetDeckView!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Set()
        board.createCardsView()
        updateViewFromModel()
    }
    
    @objc func touchCard(_ sender: UITapGestureRecognizer) {
        if let selectedCardIndex = board?.cards.firstIndex(of: sender.view as! SetCardView) {
            game.selectCard(at: selectedCardIndex)
            board.cards[selectedCardIndex].cardIsSelected = game.selectedCards.contains(game.cardsOnTheBoard[selectedCardIndex])
            updateViewFromModel()
            if game.isMatch {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: AnimationTimes.fade, delay: 0, options: .curveLinear, animations: fadeSelectedCards)
                _ = Timer.scheduledTimer(withTimeInterval: AnimationTimes.fade, repeats: false, block: { weak in self.updateViewFromModel()})
                game.deal3MoreCards()
            }
        }
    }
    @IBAction func shuffleBoard(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.cardsOnTheBoard.shuffle()
            updateViewFromModel()
        default:
            break
        }
    }
    @objc func touchDeal(_ sender: UITapGestureRecognizer) {
        game.deal3MoreCards()
        board.add3Cards()
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
            
            if boardCard.alpha == 0 {
                //set frame to deck, change alpha to 1, animate move back to old frame
            }
        }
        addCardSelector()
        discardPile.text = "\(String(game.matchedCards.count/3)) Sets"
    }
    
    func addCardSelector() {
        for card in board.cards {
            if card.gestureRecognizers == nil {
                let tap = UITapGestureRecognizer(target: self, action: #selector(touchCard(_:)))
                card.addGestureRecognizer(tap)
            }
        }
    }
    private func fadeSelectedCards() {
        for card in game.selectedCards {
            if let cardIndex = game.cardsOnTheBoard.firstIndex(of: card) {
                board.cards[cardIndex].alpha = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board.createCardsView()
        deck.text = "Draw"
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchDeal(_:)))
        deck.addGestureRecognizer(tap)
        discardPile.text = "0 Sets"
        updateViewFromModel()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.updateViewFromModel()
            
        }
    }
}

extension ViewController {
    private struct AnimationTimes {
        static let fade = 0.6
        static let deal = 0.3
    }
}
