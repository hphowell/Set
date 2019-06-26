//
//  SetDeckView.swift
//  Set
//
//  Created by Hayden Howell on 6/26/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class SetDeckView: UIView {
    
    var text = "" {
        didSet {
            self.subviews.forEach({ $0.removeFromSuperview() })
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let deck = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        deck.fill()
        let label = UILabel(frame: bounds)
        label.text = text
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        self.addSubview(label)
    }
}

extension SetDeckView {
    private struct Ratio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * Ratio.cornerRadiusToBoundsHeight
    }
}
