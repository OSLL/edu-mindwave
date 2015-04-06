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
    static let Null : UInt32 = 0
    static let Collision : UInt32 = 3
    static let Wall: UInt32 = 2
    static let Unit: UInt32 = 1
}

class Unit: SKSpriteNode {
    static func createUnit(location: CGPoint) -> Unit {
        let sprite = Unit(imageNamed: "Unit")
        sprite.position = location;
        sprite.xScale = 0.4
        sprite.yScale = 0.4
        sprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Unit"), size: sprite.size)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = true
            physics.allowsRotation = false
            physics.dynamic = true
            physics.mass = 0.1
            physics.linearDamping = 0
            physics.angularDamping = 0
            physics.friction = 0.5
        }
        sprite.physicsBody?.usesPreciseCollisionDetection = true
        sprite.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Unit
        sprite.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Collision
        sprite.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Unit
        return sprite
    }
}

class Wall: SKSpriteNode {
    static func createWall(mid: CGPoint, size: CGPoint) -> Wall {
        let sprite = Wall(imageNamed: "Wall")
        sprite.position = mid;
        sprite.xScale = size.x
        sprite.yScale = size.y
        sprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Wall"), size: sprite.size)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
        }
        sprite.physicsBody?.usesPreciseCollisionDetection = true
        sprite.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Wall
        sprite.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Collision
        sprite.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Null
        return sprite
    }
}