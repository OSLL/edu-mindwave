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
    var defaultButton: SKShapeNode
    var activeButton: SKShapeNode
    var action: () -> ()
    
    init(buttonAction: ()->()) {
        defaultButton = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 250, height: 70), cornerRadius: 5)
        defaultButton.fillColor = SKColor.grayColor()
        
        activeButton = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 250, height: 70), cornerRadius: 5)
        activeButton.fillColor = SKColor.greenColor()
        activeButton.hidden = true
        action = buttonAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultButton)
        
        
        addChild(activeButton)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        activeButton.hidden = false
        defaultButton.hidden = true
    }
    
    override func mouseUp(theEvent: NSEvent) {
        action()
        activeButton.hidden = true
        defaultButton.hidden = false
    }
}