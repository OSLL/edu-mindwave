//
//  ShadowShapeNode.swift
//  Game
//
//  Created by Yuriy Rebryk on 18/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class ShadowShapeNode: SKShapeNode {
    private var shadowShape: SKShapeNode
    private var settings: ShadowShapeViewSettings
    
    var offsetX: CGFloat = 0 {
        willSet(newOffsetX) {
            shadowShape.position.x = newOffsetX
        }
    }
    var offsetY: CGFloat = 0 {
        willSet(newOffsetY) {
            shadowShape.position.y = newOffsetY
        }
    }
    
    init(settings: ShadowShapeViewSettings, rect: CGRect, cornerRadius: CGFloat) {
        self.settings = settings
        offsetX = settings.offsetX
        offsetY = settings.offsetY
        
        shadowShape = SKShapeNode(rect: rect, cornerRadius: cornerRadius)
        shadowShape.strokeColor = settings.shadowStrokeFirstColor
        shadowShape.position = CGPoint(x: offsetX, y: offsetY)
        shadowShape.zPosition = -2

        super.init()
        self.path = CGPathCreateWithRoundedRect(rect, cornerRadius, cornerRadius, nil)!
        fillColor = settings.fillFirstColor
        strokeColor = settings.strokeFirstColor
        addChild(shadowShape)
    }
    
    func setFirstView() {
        fillColor = settings.fillFirstColor
        strokeColor = settings.strokeFirstColor
        shadowShape.strokeColor = settings.shadowStrokeFirstColor
    }
    
    func setSecondView() {
        fillColor = settings.fillSecondColor
        strokeColor = settings.strokeSecondColor
        shadowShape.strokeColor = settings.shadowStrokeSecondColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
