//
//  Saw.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Saw: SKSpriteNode, Object {
    
    init(size: CGSize, position: CGPoint, action: SKAction? = nil) {
        let texture = SKTexture(imageNamed: "Saw")
        super.init(texture: texture, color: NSColor.clearColor(), size: texture.size())
        
        self.size = size
        self.position = position
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2.0 - 20.0, center: CGPoint(x: 10.0, y: 10.0))
        
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
            physics.usesPreciseCollisionDetection = true
            physics.categoryBitMask = CollisionCategoryBitmask.Saw
            physics.collisionBitMask = CollisionCategoryBitmask.Unit
            physics.contactTestBitMask = CollisionCategoryBitmask.Saw
        }
        
        var rotAction = SKAction.repeatActionForever(SKAction.rotateByAngle(0.04, duration: 0.005))
        self.runAction(rotAction)
        
        if action != nil {
            self.runAction(action!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func beginContact(CollisionObject : UInt32) {
    }
    
    func endContact(CollisionObject : UInt32) {
    }
}