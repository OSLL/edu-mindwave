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
    static let Challenge: UInt32 = 0x1 << 5
}

struct Colors {
    static let green = NSColor.greenColor()
    
    static let lightGreen = NSColor(red: 0.5, green: 1, blue: 0.5, alpha: 1)
    static let transparentLightGreen = NSColor(red: 0.5, green: 1, blue: 0.5, alpha: 0.1)
    static let darkGreen = NSColor(red: 0.3, green: 0.6, blue: 0.3, alpha: 1)
    
    static let yellow = NSColor(red: 244/255, green: 238/255, blue: 40/255, alpha: 1)
    static let transparentYellow = NSColor(red: 244/255, green: 238/255, blue: 40/255, alpha: 0.1)
    static let darkYellow = NSColor(red: 110/255, green: 110/255, blue: 10/255, alpha: 1)
    
    static let lightRed = NSColor(red: 240/255, green: 35/255, blue: 50/255, alpha: 1)
    static let transparentLightRed = NSColor(red: 240/255, green: 35/255, blue: 50/255, alpha: 0.1)
    static let darkRed = NSColor(red: 180/255, green: 25/255, blue: 40/255, alpha: 1)
    
    static let gray = NSColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
    
    static let lightGray = NSColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
    static let transparentLightGray = NSColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 0.1)
    static let darkGray = NSColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
    
    
    static let transparentBlack = NSColor(red: 0, green: 0, blue: 0.2, alpha: 0.3)
    static let white = NSColor.whiteColor()
    static let black = NSColor.blackColor()
    static let blue = NSColor.blueColor()
    static let red = NSColor.redColor()
    static let orange = NSColor.orangeColor()
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