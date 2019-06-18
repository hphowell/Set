//
//  setBoardView.swift
//  Set
//
//  Created by Hayden Howell on 6/16/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class SetBoardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var numberOfCards = 12
    private func createCardsView () {
        var grid = Grid(layout: .aspectRatio(Ratios.cardAspectRatio), frame: bounds)
        grid.cellCount = numberOfCards
    }

}

extension SetBoardView {
    private struct Ratios {
        static let cardAspectRatio = CGFloat(floatLiteral: 5.0/7.0)
    }
}
