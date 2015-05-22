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
    var unitIn: Bool = false
    var attention: Int = 0
    var label: SKLabelNode?
    var scen: SKScene?
    init(size: CGSize, position: CGPoint, attention: Int, message: String, object: SKNode, action: SKAction) {
        super.init()
        self.object = object
        self.action = action
        self.position = position
        self.attention = attention

        path = SKShapeNode(rect: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height), cornerRadius: 3).path
        physicsBody = SKPhysicsBody(polygonFromPath: path)
        if let physics = physicsBody {
            physics.dynamic = false
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.categoryBitMask = CollisionCategoryBitmask.Null
            physics.collisionBitMask = CollisionCategoryBitmask.Null
            physics.contactTestBitMask = CollisionCategoryBitmask.Unit
        }
    }
    
    func check(attention: Int) {
        if !moved && unitIn && attention > self.attention {
            object!.runAction(action!)
            moved = true
        }
    }
    
    func beginContact(CollisionObject : UInt32) {
        unitIn = true
    }
    
    func endContact(CollisionObject : UInt32) {
        unitIn = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}