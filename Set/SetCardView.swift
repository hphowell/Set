//
//  SetCardView.swift
//  Set
//
//  Created by Hayden Howell on 6/16/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    var shape = "oval"
    var number = 2
    var shading = "filled"
    var color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)



    override func draw(_ rect: CGRect) {
        let card = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        card.addClip()
        UIColor.white.setFill()
        card.fill()
        let context = UIGraphicsGetCurrentContext()
        let stripes = UIBezierPath()
        stripes.move(to: bounds.origin)
        stripes.addLine(to: CGPoint(x: 0, y: bounds.maxY))
        var switchingMultiplier = CGFloat(integerLiteral: -1)
        for _ in 1...Int(numberOfStripes) {
            stripes.move(to: stripes.currentPoint.offsetBy(dx: CGFloat(integerLiteral: 1)/numberOfStripes * bounds.maxX, dy: 0))
            stripes.addLine(to: stripes.currentPoint.offsetBy(dx: 0, dy: switchingMultiplier * bounds.maxY))
            switchingMultiplier *= -1
        }
        stripes.lineWidth = lineWidth
        
        func drawShape(path: UIBezierPath) {
            if number == 1 {
                if shading == "empty" {
                    path.stroke()
                } else if shading == "striped" {
                    path.addClip()
                    path.stroke()
                    stripes.stroke()
                } else if shading == "filled"{
                    path.stroke()
                    path.fill()
                }
            } else if number == 2 {
                var translation = CGAffineTransform(translationX: 0, y: -1/2*spacingBetweenShapes)
                let path1 = UIBezierPath(cgPath: path.cgPath)
                path1.lineWidth = lineWidth
                path1.apply(translation)
                translation = CGAffineTransform(translationX: 0, y: 1/2*spacingBetweenShapes)
                path.apply(translation)
                if shading == "empty" {
                    path1.stroke()
                    path.stroke()
                } else if shading == "striped" {
                    path.addClip()
                    stripes.stroke()
                    path.stroke()
                    context?.resetClip()
                    path1.addClip()
                    stripes.stroke()
                    path1.stroke()
                    context?.resetClip()
                } else if shading == "filled"{
                    path.stroke()
                    path.fill()
                    path1.stroke()
                    path1.fill()
                }
            } else if number == 3 {
                var translation = CGAffineTransform(translationX: 0, y: -spacingBetweenShapes)
                let path1 = UIBezierPath(cgPath: path.cgPath)
                path1.lineWidth = lineWidth
                path1.apply(translation)
                let path2 = UIBezierPath(cgPath: path.cgPath)
                translation = CGAffineTransform(translationX: 0, y: spacingBetweenShapes)
                path2.lineWidth = lineWidth
                path2.apply(translation)
                if shading == "empty" {
                    path.stroke()
                    path1.stroke()
                    path2.stroke()
                } else if shading == "striped" {
                    path.addClip()
                    stripes.stroke()
                    path.stroke()
                    context?.resetClip()
                    path1.addClip()
                    stripes.stroke()
                    path1.stroke()
                    context?.resetClip()
                    path2.addClip()
                    stripes.stroke()
                    path2.stroke()
                    context?.resetClip()
                    
                } else if shading == "filled"{
                    path.stroke()
                    path.fill()
                    path1.stroke()
                    path1.fill()
                    path2.stroke()
                    path2.fill()
                }
            }
        }
        
        func drawOvals(numberOfOvals: Int, color: UIColor, shading: String) {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.midX - 1/2*ovalLineLength, y: bounds.midY - 1/2*ovalHeight))
            path.addLine(to: path.currentPoint.offsetBy(dx: ovalLineLength, dy: 0))
            path.addArc(withCenter: path.currentPoint.offsetBy(dx: 0, dy: 1/2*ovalHeight), radius: -1/2*ovalHeight, startAngle: .pi/2, endAngle: 3 * .pi/2, clockwise: true)
            path.addLine(to: path.currentPoint.offsetBy(dx: -ovalLineLength, dy: 0))
            path.addArc(withCenter: path.currentPoint.offsetBy(dx: 0, dy: -1/2*ovalHeight), radius: -1/2*ovalHeight, startAngle: -.pi/2, endAngle: .pi/2, clockwise: true)
            color.setStroke()
            color.setFill()
            path.lineWidth = lineWidth
            drawShape(path: path)
            
        }
        func drawSquiggles(numberOfSquiggles: Int, color: UIColor, shading: String) {
            let path = UIBezierPath()
        }
        func drawDiamonds(numberOfDiamonds: Int, color: UIColor, shading: String) {
            let path = UIBezierPath()
        }
        if shape == "oval" {
            drawOvals(numberOfOvals: number, color: color, shading: shading)
        } else if shape == "squiggle" {
            drawSquiggles(numberOfSquiggles: number, color: color, shading: shading)
        } else if shape == "diamond" {
            drawDiamonds(numberOfDiamonds: number, color: color, shading: shading)
        } else {
            print("Number is invalid. Must be 1, 2, or 3.")
        }
    }
}

extension SetCardView {
    private struct Ratio {
        static let cardAspectRatio: CGFloat = 5.0/7.0
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let distanceFromCardSidesToDrawingToBoundsWidth: CGFloat = 0.05
        static let ovalLineLengthToBoundsWidth: CGFloat = 0.6
        static let ovalHeightToBoundsHeight: CGFloat = 0.15
        static let spacingBetweenShapesToBoundsHeight: CGFloat = 0.3
        static let lineWidth: CGFloat = 5.0
        static let numberOfStripes: CGFloat = 10.0
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * Ratio.cornerRadiusToBoundsHeight
    }
    
    private var distanceFromCardSidesToDrawing: CGFloat {
        return bounds.size.width * Ratio.distanceFromCardSidesToDrawingToBoundsWidth
    }
    
    private var ovalLineLength: CGFloat {
        return bounds.size.width * Ratio.ovalLineLengthToBoundsWidth
    }
    
    private var ovalHeight: CGFloat {
        return bounds.size.height * Ratio.ovalHeightToBoundsHeight
    }
    
    private var spacingBetweenShapes: CGFloat {
        return bounds.size.height * Ratio.spacingBetweenShapesToBoundsHeight
    }
    private var lineWidth: CGFloat {
        return Ratio.lineWidth
    }
    private var numberOfStripes: CGFloat {
        return Ratio.numberOfStripes
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}