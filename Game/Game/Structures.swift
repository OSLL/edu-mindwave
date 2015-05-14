//
//  File.swift
//  game
//
//  Created by Yuriy Rebryk on 27/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

struct CollisionCategoryBitmask {
    static let Null : UInt32 = 0x0
    static let Collision : UInt32 = (0x1 << 7) - 1
    static let Wall: UInt32 = 0x1 << 2
    static let Unit: UInt32 = 0x1 << 1
    static let GravityBall: UInt32 = 0x1 << 4
    static let Saw: UInt32 = 0x1 << 5
    static let Door: UInt32 = 0x1 << 6
}

struct ColorData {
    static let colors = [NSColor.redColor(), NSColor.greenColor(), NSColor.blueColor()]
    
    static func changeColor(inout color: Int, var scene: SKScene?) -> NSColor {
        --(scene as! GameScene).colorsCount[color]
        color = (color + 1) % count(ColorData.colors)
        ++(scene as! GameScene).colorsCount[color]
        return ColorData.colors[color]
    }
    static func setColor(inout color: Int, var scene: SKScene?) -> NSColor {
        color = Int(rand()) % Int(count(ColorData.colors))
        ++(scene as! GameScene).colorsCount[color]
        return ColorData.colors[color]
    }
}