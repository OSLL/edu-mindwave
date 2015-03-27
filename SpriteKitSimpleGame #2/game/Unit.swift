//
//  File.swift
//  game
//
//  Created by Yuriy Rebryk on 27/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Unit: SKSpriteNode {
    static func createUnit(location: CGPoint) -> Unit {
        let sprite = Unit(imageNamed: "Unit")
        sprite.position = location;
        sprite.xScale = 0.3
        sprite.yScale = 0.3
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
        return sprite
    }
}