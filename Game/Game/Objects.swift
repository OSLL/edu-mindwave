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

protocol Object {
    func beginContact(UInt32)
    func endContact(UInt32)
}

class Unit: SKSpriteNode, Object {
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
            physics.collisionBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
            physics.contactTestBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
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
        NSLog("Unit contact")
    }
    func endContact(CollisionObject : UInt32) {
        
    }
}

class Wall: SKShapeNode, Object {
    init(size: CGPoint, position: CGPoint) {
        super.init()
        self.path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: size.x, height: size.y), nil)
        self.fillColor = NSColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 255/255)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.x, height: size.y),
            center: CGPoint(x: size.x / 2, y: size.y / 2))
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
    }
    func beginContact(CollisionObject : UInt32) {
        NSLog("Wall contact")
        self.fillColor = NSColor(red: CGFloat(rand() % 2), green: CGFloat(rand() % 2), blue: CGFloat(rand() % 2), alpha: 1.0)
    }
    func endContact(CollisionObject : UInt32) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}