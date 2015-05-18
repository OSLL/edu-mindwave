//
//  Wall.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKShapeNode, Object {
    init(size: CGSize, position: CGPoint) {
        super.init()
        path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), nil)
        fillColor = Colors.black
        strokeColor = Colors.black
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width, height: size.height),
            center: CGPoint(x: size.width / 2, y: size.height / 2))
        self.position = position
        if var physics = self.physicsBody {
            physics.dynamic = false
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.categoryBitMask = CollisionCategoryBitmask.Wall
            physics.collisionBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Block
            physics.contactTestBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
        }
    }
    
    func beginContact(CollisionObject : UInt32) {
    }
    
    func endContact(CollisionObject : UInt32) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}