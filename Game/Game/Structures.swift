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
    static let Unit: UInt32 = 0x1 << 1
    static let Block: UInt32 = 0x1 << 2
    static let Trap: UInt32 = 0x1 << 3
    static let Wall: UInt32 = 0x1 << 4
}

struct Colors {
    static let white = NSColor.whiteColor()
    static let gray = NSColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    static let lightGray = NSColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    static let black = NSColor.blackColor()
    static let lightGreen = NSColor(red: 0.5, green: 1, blue: 0.5, alpha: 1)
    static let green = NSColor.greenColor()
    static let blue = NSColor.blueColor()
    static let red = NSColor.redColor()
    static let orange = NSColor.orangeColor()
    static let darkYellow = NSColor(red: 110/255, green: 110/255, blue: 10/255, alpha: 1)
    static let yellow = NSColor(red: 244/255, green: 238/255, blue: 40/255, alpha: 1)
    static let transparent = NSColor(red: 0, green: 0, blue: 0, alpha: 0)
}

struct ColorData {
    static let colors = [Colors.red, Colors.green, Colors.blue]
    
    static func changeColor(inout color: Int, var scene: SKScene?) -> NSColor {
        (scene as! GameScene).decColorCount(color)
        color = (color + 1) % count(ColorData.colors)
        (scene as! GameScene).incColorCount(color)
        return ColorData.colors[color]
    }
}