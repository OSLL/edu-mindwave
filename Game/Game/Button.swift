//
//  Button.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Button: SKNode {
    static let width: CGFloat = 280
    static let height: CGFloat = 80
    
    // COLORS
    let whiteColor = NSColor(SRGBRed: 1, green: 1, blue: 1, alpha: 1)
    let lightGreenColor = NSColor(SRGBRed: 0.5, green: 1, blue: 0.5, alpha: 1)
    let greenColor = NSColor(SRGBRed: 0, green: 1, blue: 0, alpha: 1)
    
    var background: SKShapeNode
    var label: SKLabelNode
    var action: () -> ()
    
    init(text: String, buttonAction: ()->()) {
        label = SKLabelNode(fontNamed: "Chalkboard")
        label.text = text
        label.fontSize = 50
        label.fontColor = NSColor.blackColor()
        label.position = CGPoint(x: Button.width / 2, y: (Button.height - label.frame.height) / 2 + 2)
        
        background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: Button.width, height: Button.height), cornerRadius: 5)
        background.fillColor = SKColor.whiteColor()
        background.strokeColor = NSColor.blackColor()
        background.addChild(label)
        
        action = buttonAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(background)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        background.fillColor = lightGreenColor
    }

    override func mouseUp(theEvent: NSEvent) {
        action()
        background.fillColor = whiteColor
    }
}