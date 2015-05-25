//
//  Unit.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Challenge: SKShapeNode, Object {
    var object: SKNode?
    var action: SKAction?
    var moved: Bool = false
    var isActive: Bool = false
    var attention: Int = 0
    var label: SKLabelNode?
    var background: SKShapeNode?
    var scen: SKScene?
    var size: CGSize?
    
    init(size: CGSize, position: CGPoint, attention: Int, message: String, object: SKNode, action: SKAction) {
        super.init()
        self.size = size
        self.position = position
        var settings = Buttons.LockedLevel
        self.object = object
        self.action = action
        self.attention = attention
        label = SKLabelNode()
        label!.text = String(attention)
        label!.zPosition = 1
        label!.position = CGPoint(x: size.width / 2, y: (size.height - label!.frame.height) / 2 + 2)

        background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: CGFloat(5.0))
        background!.addChild(label!)
        
        userInteractionEnabled = true
        addChild(background!)
        self.unactive()
        path = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 3).path
        physicsBody = SKPhysicsBody(polygonFromPath: path)
        if let physics = physicsBody {
            physics.dynamic = false
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.categoryBitMask = CollisionCategoryBitmask.Challenge
            physics.collisionBitMask = CollisionCategoryBitmask.Null
            physics.contactTestBitMask = CollisionCategoryBitmask.Unit
        }
    }
    
    func unactive() {
        if !moved {
            isActive = false
            setSettings(Buttons.LockedLevel)
        }
    }
    
    func active() {
        isActive = true
        setSettings(Buttons.Level)
    }
    
    func setSettings(settings: ButtonViewSettings) {
        var labelSettings = settings.labelSettings
        label!.fontSize = labelSettings.fontSize
        label!.fontName = labelSettings.fontName
        label!.fontColor = labelSettings.shadowFontFirstColor
        label!.position = CGPoint(x: labelSettings.offsetX, y: labelSettings.offsetY)
        label!.zPosition = -1
        label!.fontSize = labelSettings.fontSize
        label!.fontName = labelSettings.fontName
        label!.fontColor = labelSettings.fontFirstColor
        label!.text = String(attention)
        label!.zPosition = 1
        label!.position = CGPoint(x: size!.width / 2, y: (size!.height - label!.frame.height) / 2 + 2)
        
        var shapeSettings = settings.shapeSettings
        
        background!.strokeColor = shapeSettings.shadowStrokeFirstColor
        background!.position = CGPoint(x: shapeSettings.offsetX, y: shapeSettings.offsetY)
        background!.zPosition = -1
        fillColor = shapeSettings.fillFirstColor
        strokeColor = shapeSettings.strokeFirstColor
    }
    
    func check(attention: Int) {
        if !moved && isActive && attention > self.attention {
            object!.runAction(action!)
            moved = true
            setSettings(Buttons.CompletedLevel)
        }
    }
    
    func beginContact(CollisionObject : UInt32) {
    }
    
    func endContact(CollisionObject : UInt32) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}