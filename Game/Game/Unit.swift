//
//  Unit.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Unit: SKSpriteNode, Object {
    var moveLeft = false
    var moveRight = false
    var jump = false
    var killed = false
    
    let force = 80.0
    
    init() {
        let texture = SKTexture(imageNamed: "Unit")
        super.init(texture: texture, color: NSColor.clearColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Unit"), size: texture.size())
        self.xScale = 0.3
        self.yScale = 0.3
        
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.allowsRotation = false
            physics.dynamic = true
            physics.mass = 0.1
            physics.linearDamping = 0
            physics.angularDamping = 0
            physics.friction = 0.5
            physics.usesPreciseCollisionDetection = true
            physics.categoryBitMask = CollisionCategoryBitmask.Unit
            physics.collisionBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Saw
            physics.contactTestBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Saw
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move() {
        if moveLeft == true {
            self.physicsBody?.applyForce(CGVector(dx: -force, dy: 0))
        }
        if moveRight == true {
            self.physicsBody?.applyForce(CGVector(dx: force, dy: 0))
        }
        if jump == true {
            if self.physicsBody?.velocity.dy < 5 && self.physicsBody?.velocity.dy > -5 {
                self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
            }
            jump = false
        }
    }
    
    func beginContact(CollisionObject : UInt32) {
        if (CollisionObject == CollisionCategoryBitmask.Saw) {
            self.killed = true
        }
    }
    
    func endContact(CollisionObject : UInt32) {
    }
}