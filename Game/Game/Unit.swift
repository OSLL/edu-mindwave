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
    
    let force = 60.0
    let size = 60
    
    init(position: CGPoint) {
        super.init()
        self.position = position
        zPosition = -1
        path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: size, height: size), nil)
        fillColor = Colors.orange
        strokeColor = Colors.black
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size + 2, height: size + 2), center: CGPoint(x: size / 2, y: size / 2))
        if let physics = physicsBody {
            physics.affectedByGravity = true
            physics.allowsRotation = false
            physics.dynamic = true
            physics.mass = 0.1
            physics.linearDamping = 0
            physics.angularDamping = 0
            physics.friction = 0.5
            physics.categoryBitMask = CollisionCategoryBitmask.Unit
            physics.collisionBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
            physics.contactTestBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Trap
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move() {
        if moveLeft == true {
            physicsBody?.applyForce(CGVector(dx: -force, dy: 0))
        }
        if moveRight == true {
            physicsBody?.applyForce(CGVector(dx: force, dy: 0))
        }
        if jump == true {
            if physicsBody?.velocity.dy < 5 && physicsBody?.velocity.dy > -5 {
                physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
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
