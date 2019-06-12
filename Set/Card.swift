//
//  Card.swift
//  Set
//
//  Created by Hayden Howell on 6/11/19.
//  Copyright © 2019 Hayden Howell. All rights reserved.
//

import Foundation

struct Card
{
    
    var shape: String
    var color: Color
    var shading: Shading
    var number: Int
    
    enum Shading: CaseIterable {
        case empty
        case shaded
        case filled
    }
    
    enum Color: CaseIterable {
        case red
        case green
        case blue
    }
}
