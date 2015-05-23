//
//  Unit.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Unit: SKShapeNode, Object {
    var moveLeft = false
    var moveRight = false
    var jump = false
    var killed = false
    
    let force = 1.2
    let size = 60
    
    init(position: CGPoint) {
        super.init()
        self.position = position
        zPosition = -1
        path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: size, height: size), nil)
        fillColor = Colors.orange
        strokeColor = Colors.black
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size, height: size), center: CGPoint(x: size / 2, y: size / 2))
        if let physics = physicsBody {
            physics.mass = 0.1
            physics.friction = 0.15
            physics.restitution = 0.0
            physics.affectedByGravity = true
            physics.allowsRotation = false
            physics.dynamic = true
            physics.categoryBitMask = CollisionCategoryBitmask.Unit
            physics.collisionBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Block
            physics.contactTestBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Trap | CollisionCategoryBitmask.Block
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move() {
        if moveLeft == true {
            physicsBody?.applyImpulse(CGVector(dx: -force, dy: 0))
        }
        if moveRight == true {
            physicsBody?.applyImpulse(CGVector(dx: force, dy: 0))
        }
        if jump == true {
            if physicsBody?.velocity.dy < 5 && physicsBody?.velocity.dy > -5 {
                physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
                runAction(Player.jump())
            }
            jump = false
        }
    }
    
    func beginContact(CollisionObject : UInt32) {
        if CollisionObject == CollisionCategoryBitmask.Trap {
            killed = true
        }
    }
    
    func endContact(CollisionObject : UInt32) {
    }
}
