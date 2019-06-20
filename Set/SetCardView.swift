//
//  SetCardView.swift
//  Set
//
//  Created by Hayden Howell on 6/16/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    var shape = "oval" {
        didSet {
            setNeedsDisplay()
        }
    }
    var number = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    var shading = "empty" {
        didSet {
            setNeedsDisplay()
        }
    }
    var color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    var cardIsSelected = false {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let card = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        card.addClip()
        UIColor.white.setFill()
        card.fill()
        if cardIsSelected {
            card.lineWidth = lineWidth
            UIColor.blue.setStroke()
            card.stroke()
        }
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
            color.setStroke()
            color.setFill()
            path.lineWidth = lineWidth
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
        
        func drawOvals() {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.midX - 1/2*(shapeWidth-shapeHeight), y: bounds.midY - 1/2*shapeHeight))
            path.addLine(to: path.currentPoint.offsetBy(dx: shapeWidth-shapeHeight, dy: 0))
            path.addArc(withCenter: path.currentPoint.offsetBy(dx: 0, dy: 1/2*shapeHeight), radius: -1/2*shapeHeight, startAngle: .pi/2, endAngle: 3 * .pi/2, clockwise: true)
            path.addLine(to: path.currentPoint.offsetBy(dx: -shapeWidth+shapeHeight, dy: 0))
            path.addArc(withCenter: path.currentPoint.offsetBy(dx: 0, dy: -1/2*shapeHeight), radius: -1/2*shapeHeight, startAngle: -.pi/2, endAngle: .pi/2, clockwise: true)
            drawShape(path: path)
            
        }
        func drawSquiggles() {
            let path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY).offsetBy(dx: 1/4*shapeWidth, dy: -1/6*shapeHeight), radius: 1/4*shapeWidth, startAngle: 0, endAngle: .pi, clockwise: false)
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY).offsetBy(dx: -1/4*shapeWidth, dy: -1/6*shapeHeight), radius: 1/4*shapeWidth, startAngle: 0, endAngle: .pi, clockwise: true)
            path.addLine(to: path.currentPoint.offsetBy(dx: 0, dy: 1/3*shapeHeight))
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY).offsetBy(dx: -1/4*shapeWidth, dy: 1/6*shapeHeight), radius: 1/4*shapeWidth, startAngle: .pi, endAngle: 0, clockwise: false)
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY).offsetBy(dx: 1/4*shapeWidth, dy: 1/6*shapeHeight), radius: 1/4*shapeWidth, startAngle: .pi, endAngle: 0, clockwise: true)
            path.addLine(to: path.currentPoint.offsetBy(dx: 0, dy: -1/3*shapeHeight))
            drawShape(path: path)
        }
        func drawDiamonds() {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.midX, y: bounds.midY - 1/2*shapeHeight))
            path.addLine(to: path.currentPoint.offsetBy(dx: 1/2*shapeWidth, dy: 1/2*shapeHeight))
            path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + 1/2*shapeHeight))
            path.addLine(to: path.currentPoint.offsetBy(dx: -1/2*shapeWidth, dy: -1/2*shapeHeight))
            path.close()
            drawShape(path: path)
        }
        if shape == "oval" {
            drawOvals()
        } else if shape == "squiggle" {
            drawSquiggles()
        } else if shape == "diamond" {
            drawDiamonds()
        } else {
            print("Shape is invalid. Must be oval, squiggle, or diamond.")
        }
    }
}

extension SetCardView {
    private struct Ratio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let distanceFromCardSidesToDrawingToBoundsWidth: CGFloat = 0.05
        static let shapeWidthToBoundsWidth: CGFloat = 0.6
        static let shapeHeightToBoundsHeight: CGFloat = 0.15
        static let spacingBetweenShapesToBoundsHeight: CGFloat = 0.3
        static let lineWidth: CGFloat = 0.0125
        static let numberOfStripes: CGFloat = 10.0
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * Ratio.cornerRadiusToBoundsHeight
    }
    
    private var distanceFromCardSidesToDrawing: CGFloat {
        return bounds.size.width * Ratio.distanceFromCardSidesToDrawingToBoundsWidth
    }
    
    private var shapeWidth: CGFloat {
        return bounds.size.width * Ratio.shapeWidthToBoundsWidth
    }
    
    private var shapeHeight: CGFloat {
        return bounds.size.height * Ratio.shapeHeightToBoundsHeight
    }
    
    private var spacingBetweenShapes: CGFloat {
        return bounds.size.height * Ratio.spacingBetweenShapesToBoundsHeight
    }
    private var lineWidth: CGFloat {
        return Ratio.lineWidth*bounds.size.width
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
