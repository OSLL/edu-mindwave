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
    static let size = CGSize(width: 120, height: 120)
    
    var background: SKShapeNode
    var numLabel: SKLabelNode
    var scoreLabel: SKLabelNode
    var isAvailable: Bool
    var action: () -> ()
    
    init(text: String, score: String, available: Bool, buttonAction: ()->()) {
        isAvailable = available
        numLabel = SKLabelNode(fontNamed: "Chalkboard")
        numLabel.text = text
        numLabel.fontSize = 60
        numLabel.fontColor = NSColor.blackColor()
        numLabel.position = CGPoint(x: LevelButton.size.width / 2, y: (LevelButton.size.height + 30 - numLabel.frame.height) / 2 + 2)
        scoreLabel = SKLabelNode(fontNamed: "Chalkboard")
        scoreLabel.text = score
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = NSColor.blackColor()
        scoreLabel.position = CGPoint(x: LevelButton.size.width / 2, y: (LevelButton.size.height - 70 - scoreLabel.frame.height) / 2 + 2)
        background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: LevelButton.size.width, height: LevelButton.size.height), cornerRadius: 5)

        if (isAvailable) {
            background.fillColor = SKColor.whiteColor()
        }
        else {
            background.fillColor = SKColor.grayColor()
        }
        
        background.strokeColor = NSColor.blackColor()
        background.addChild(numLabel)
        background.addChild(scoreLabel)
        
        action = buttonAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        if isAvailable {
            background.fillColor = Colors.lightGreen
        }
    }
    
    override func mouseUp(theEvent: NSEvent) {
        if isAvailable {
            action()
            background.fillColor = Colors.white
        }
    }
}