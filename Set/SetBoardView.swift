//
//  setBoardView.swift
//  Set
//
//  Created by Hayden Howell on 6/16/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class SetBoardView: UIView {

    override func draw(_ rect: CGRect) {
        grid = Grid(layout: .aspectRatio(Ratios.cardAspectRatio), frame: bounds)
    }
    var cards: [SetCardView] = []
    var numberOfCards = 12 {
        didSet {
            grid.cellCount = numberOfCards
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: AnimationTimes.resizeTime, delay: 0, options: .curveEaseInOut, animations: resizeGrid)
            if numberOfCards > 12 {
                for cardIndex in numberOfCards-3..<numberOfCards {
                    if let cell = grid[cardIndex] {
                        let card = SetCardView(frame: cell)
                        cards.append(card)
                        card.shape = "oval"
                        card.number = 2
                        card.shading = "empty"
                        card.color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                        card.isOpaque = false
                        addSubview(card)
                    }
                }
            }
        }
    }
        
    lazy var grid = Grid(layout: .aspectRatio(Ratios.cardAspectRatio), frame: bounds)
    
    func createCardsView () {
        numberOfCards = 12
        if subviews.count > 0 {
            self.subviews.forEach({ $0.removeFromSuperview()})
        }
        cards = []
        for cardIndex in 0..<numberOfCards {
            if let cell = grid[cardIndex] {
                let card = SetCardView(frame: cell)
                card.isOpaque = false
                addSubview(card)
                cards.append(card)
            }
        }
    }
    
    private func resizeGrid() {
        for cardIndex in 0..<subviews.count {
            if let cell = grid[cardIndex] {
                cards[cardIndex].frame = cell
            }
        }
    }

}

extension SetBoardView {
    private struct Ratios {
        static let cardAspectRatio = CGFloat(floatLiteral: 5.0/7.0)
    }
    private struct AnimationTimes {
        static let resizeTime = 0.6
    }
}
