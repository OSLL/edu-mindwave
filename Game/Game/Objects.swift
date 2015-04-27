//
//  File.swift
//  game
//
//  Created by Yuriy Rebryk on 27/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit


struct CollisionCategoryBitmask {
    static let Null : UInt32 = 0x0
    static let Collision : UInt32 = (0x1 << 6) - 1
    static let Wall: UInt32 = 0x1 << 2
    static let Unit: UInt32 = 0x1 << 1
    static let GravityBall: UInt32 = 0x1 << 4
    static let Saw: UInt32 = 0x1 << 5
}

class Saw: SKSpriteNode {
    override init() {
        let texture = SKTexture(imageNamed: "Saw")
        super.init(texture: texture, color: NSColor.clearColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Saw"), size: texture.size())
        self.xScale = 0.3
        self.yScale = 0.3
        
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
            physics.usesPreciseCollisionDetection = true
            physics.categoryBitMask = CollisionCategoryBitmask.Saw
            physics.collisionBitMask = CollisionCategoryBitmask.Unit
            physics.contactTestBitMask = CollisionCategoryBitmask.Saw
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Unit: SKSpriteNode {
    var moveLeft = false
    var moveRight = false
    var jump = false
    
    let force = 80.0
    
    override init() {
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
            physics.collisionBitMask = CollisionCategoryBitmask.Collision
            physics.fieldBitMask = CollisionCategoryBitmask.GravityBall
            physics.contactTestBitMask = CollisionCategoryBitmask.Unit
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
}


class Wall: SKShapeNode {
    init(size: CGPoint) {
        super.init()
        self.path = CGPathCreateWithRect(CGRect(x: 0.0, y: 0, width: size.x, height: size.y), nil)
        self.fillColor = NSColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 255/255)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.x, height: size.y),
            center: CGPoint(x: size.x / 2, y: size.y / 2))
        
        if var physicsBody = self.physicsBody {
            physicsBody.dynamic = false
            physicsBody.affectedByGravity = false
            physicsBody.allowsRotation = false
            physicsBody.usesPreciseCollisionDetection = true
            physicsBody.categoryBitMask = CollisionCategoryBitmask.Wall
            physicsBody.collisionBitMask = CollisionCategoryBitmask.Collision
            physicsBody.contactTestBitMask = CollisionCategoryBitmask.Null
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}