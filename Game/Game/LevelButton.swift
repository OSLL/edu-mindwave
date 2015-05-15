//
//  LevelButton.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class LevelButton: SKNode {
    static let size = CGSize(width: 100, height: 100)
    
    var background: SKShapeNode
    var label: SKLabelNode
    var action: () -> ()
    
    init(text: String, buttonAction: ()->()) {
        label = SKLabelNode(fontNamed: "Chalkboard")
        label.text = text
        label.fontSize = 60
        label.fontColor = NSColor.blackColor()
        label.position = CGPoint(x: LevelButton.size.width / 2, y: (LevelButton.size.height - label.frame.height) / 2 + 2)
        
        background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: LevelButton.size.width, height: LevelButton.size.height), cornerRadius: 5)
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
        background.fillColor = Colors.lightGreenColor
    }
    
    override func mouseUp(theEvent: NSEvent) {
        action()
        background.fillColor = Colors.white
    }
}