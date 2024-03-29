//
//  Card.swift
//  Set
//
//  Created by Hayden Howell on 6/11/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import Foundation

struct Card: Equatable
{
    
    var shape: Shape
    var color: Color
    var shading: Shading
    var number: Int
    
    enum Shape: CaseIterable {
        case shape1
        case shape2
        case shape3
    }
    
    enum Shading: CaseIterable {
        case shading1
        case shading2
        case shading3
    }
    
    enum Color: CaseIterable {
        case color1
        case color2
        case color3
    }
}
