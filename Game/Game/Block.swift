//
//  Block.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Block: SKShapeNode, Object, ColorObject {
    var colorIndex = 0
    
    init(size: CGSize, position: CGPoint, action: SKAction? = nil) {
        super.init()
        self.path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), nil)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width, height: size.height),
            center: CGPoint(x: size.width / 2, y: size.height / 2))
        self.position = position
        if var physics = self.physicsBody {
            physics.dynamic = false
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.usesPreciseCollisionDetection = true
            physics.categoryBitMask = CollisionCategoryBitmask.Wall
            physics.collisionBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
            physics.contactTestBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
        }
        if action != nil {
            self.runAction(action!)
        }
    }
    
    func setColor() {
        self.fillColor = ColorData.setColor(&self.colorIndex, scene: self.scene)
    }
    
    func beginContact(CollisionObject : UInt32) {
        if (self.scene as! GameScene).ended == false {
            self.fillColor = ColorData.changeColor(&self.colorIndex, scene: self.scene)
        }
    }
    
    func endContact(CollisionObject : UInt32) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}