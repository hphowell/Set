//
//  ViewController.swift
//  Set
//
//  Created by Hayden Howell on 6/11/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    lazy var game = Set()
    
    @IBOutlet weak var board: SetBoardView!
    
    @IBOutlet weak var deck: SetDeckView!
    
    @IBOutlet weak var discardPile: SetDeckView!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Set()
        board.createCardsView()
        updateViewFromModel()
    }
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var collisionBehavior : UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(behavior)
        return behavior
    }()
    lazy var itemBehavior : UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.elasticity = 1.0
        behavior.resistance = 0
        animator.addBehavior(behavior)
        return behavior
    }()
    
    lazy var flyawayCards: [SetCardView] = []
    
    func moveFlyawayCardsToDiscard() {
        for card in flyawayCards {
            itemBehavior.removeItem(card)
            collisionBehavior.removeItem(card)
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: AnimationTimes.deal, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in card.frame = self.discardPile.frame})
            _ = Timer.scheduledTimer(withTimeInterval: AnimationTimes.fade, repeats: false, block: { _ in card.removeFromSuperview() })
        }
        flyawayCards = []
    }
    
    @objc func touchCard(_ sender: UITapGestureRecognizer) {
        if let selectedCardIndex = board?.cards.firstIndex(of: sender.view as! SetCardView) {
            game.selectCard(at: selectedCardIndex)
            board.cards[selectedCardIndex].cardIsSelected = game.selectedCards.contains(game.cardsOnTheBoard[selectedCardIndex])
            updateViewFromModel()
            if game.isMatch {
                for card in game.selectedCards {
                    if let cardIndex = game.cardsOnTheBoard.firstIndex(of: card) {
                        let boardCard = board.cards[cardIndex]
                        let flyawayCard = SetCardView()
                        flyawayCard.frame = boardCard.frame
                        flyawayCard.isFaceUp = boardCard.isFaceUp
                        flyawayCard.color = boardCard.color
                        flyawayCard.number = boardCard.number
                        flyawayCard.shape = boardCard.shape
                        flyawayCard.shading = boardCard.shading
                        flyawayCard.isOpaque = false
                        flyawayCards.append(flyawayCard)
                        board.addSubview(flyawayCard)
                        collisionBehavior.addItem(flyawayCard)
                        itemBehavior.addItem(flyawayCard)
                        let push = UIPushBehavior(items: [flyawayCard], mode: .instantaneous)
                        push.angle = CGFloat(arc4random()) * CGFloat.pi * 2
                        push.magnitude = CGFloat(Magnitudes.flyaway)
                        push.action = { [unowned push] in push.dynamicAnimator?.removeBehavior(push) }
                        animator.addBehavior(push)
                    }
                }
                _ = Timer.scheduledTimer(withTimeInterval: AnimationTimes.flyaway, repeats: false, block: { _ in self.moveFlyawayCardsToDiscard()})
                hideSelectedCards()
                _ = Timer.scheduledTimer(withTimeInterval: AnimationTimes.fade, repeats: false, block: { _ in self.updateViewFromModel()})
                game.deal3MoreCards()
            }
        }
    }
    @objc func touchDeal(_ sender: UITapGestureRecognizer) {
        game.deal3MoreCards()
        board.add3Cards()
        updateViewFromModel()
    }
    func updateViewFromModel() {
        var cardsToDeal: [SetCardView] = []
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
                cardsToDeal.append(boardCard)
            }
        }
        var multiplier = 0.0
        for card in cardsToDeal {
            let oldFrame = card.frame
            card.frame = deck.frame
            card.alpha = 1
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: AnimationTimes.deal, delay: multiplier * AnimationTimes.deal, options: .curveEaseInOut, animations: { card.frame = oldFrame})
            _ = Timer.scheduledTimer(withTimeInterval: AnimationTimes.deal * (multiplier + 1), repeats: false) { _ in
                UIView.transition(with: card, duration: AnimationTimes.flip, options: .transitionFlipFromLeft, animations: {card.isFaceUp = true})
            }
            multiplier += 1
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
    private func hideSelectedCards() {
        for card in game.selectedCards {
            if let cardIndex = game.cardsOnTheBoard.firstIndex(of: card) {
                board.cards[cardIndex].alpha = 0
                board.cards[cardIndex].isFaceUp = false
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

extension SetViewController {
    private struct AnimationTimes {
        static let fade = 0.6
        static let deal = 0.3
        static let flyaway = 0.6
        static let flip = 0.3
    }
    private struct Magnitudes {
        static let flyaway = 10.0
    }
}
