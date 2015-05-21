//
//  LevelButton.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class LevelButton: Button {
    var scoreLabel: SKLabelNode
    var isAvailable: Bool
    
    init(text: String, score: String, available: Bool, buttonAction: ()->()) {
        isAvailable = available
        
        var settings = Buttons.CompletedLevel
        if available == false {
            settings = Buttons.LockedLevel
        } else if score == "--:--:--" {
            settings = Buttons.Level
        }
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkboard")
        scoreLabel.text = score
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = NSColor.blackColor()
        scoreLabel.position = CGPoint(x: settings.size.width / 2, y: (settings.size.height - 70 - scoreLabel.frame.height) / 2 + 2)
        
        super.init(text: text, settings: settings, buttonAction: buttonAction)
        label.position = CGPoint(x: size.width / 2, y: (size.height - label.frame.height) / 2 + 15)
        addChild(scoreLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activate() {
        if isAvailable {
            action()
        }
    }
}