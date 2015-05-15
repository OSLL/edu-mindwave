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
    var background: SKShapeNode
    var label: SKLabelNode
    var action: () -> ()
    var size: CGSize
    
    init(text: String, size: CGSize, fontSize: CGFloat, buttonAction: ()->()) {
        self.size = size
        
        label = SKLabelNode(fontNamed: "Chalkboard")
        label.text = text
        label.fontSize = fontSize
        label.fontColor = Colors.black
        label.position = CGPoint(x: size.width / 2, y: (size.height - label.frame.height) / 2 + 2)
        
        background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 5)
        background.fillColor = Colors.white
        background.strokeColor = Colors.black
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
        background.fillColor = Colors.lightGreen
    }

    override func mouseUp(theEvent: NSEvent) {
        action()
        background.fillColor = Colors.white
    }
}