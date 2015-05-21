//
//  ActiveBlock.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class ActiveBlock: Block {
    override init(size: CGSize, position: CGPoint, colorIndex: Int) {
        super.init(size: size, position: position, colorIndex: colorIndex)
    }
    
    override init(radius: CGFloat, position: CGPoint, colorIndex: Int) {
        super.init(radius: radius, position: position, colorIndex: colorIndex)
    }
    
    internal override func setPhyscicsBody() {
        if var physics = physicsBody {
            physics.mass = 0.02
            physics.linearDamping = 1.0
            physics.angularDamping = 1.0
            physics.friction = 0.6
            physics.restitution = 0.2
            physics.dynamic = true
            physics.affectedByGravity = true
            physics.allowsRotation = true
            physics.categoryBitMask = CollisionCategoryBitmask.Block
            physics.collisionBitMask = CollisionCategoryBitmask.Block | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Wall
            physics.contactTestBitMask = CollisionCategoryBitmask.Block | CollisionCategoryBitmask.Unit
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}