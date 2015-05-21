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
    var background: ShadowShapeNode
    var label: ShadowLabelNode
    var action: () -> ()
    var size: CGSize
    
    init(text: String, settings: ButtonViewSettings, buttonAction: ()->()){
        self.size = settings.size
        
        label = ShadowLabelNode(settings: settings.labelSettings)
        label.text = text
        label.zPosition = 1
        label.position = CGPoint(x: size.width / 2, y: (size.height - label.frame.height) / 2 + 2)
        
        action = buttonAction
        background = ShadowShapeNode(settings: settings.shapeSettings, rect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: CGFloat(5.0))
        background.addChild(label)
        
        super.init()
        
        userInteractionEnabled = true
        addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activate() {
        action()
    }
    
    func mark() {
        background.setSecondView()
        label.setSecondView()
    }
    
    func unmark() {
        background.setFirstView()
        label.setFirstView()
    }
}