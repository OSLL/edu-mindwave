//
//  Block.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Block: SKShapeNode, Object, ColorObject {
    var colorIndex = 0
    
    init(size: CGSize, position: CGPoint, colorIndex: Int) {
        super.init()
        path = SKShapeNode(rect: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height), cornerRadius: 5).path
        self.colorIndex = colorIndex
        fillColor = ColorData.colors[colorIndex]
        strokeColor = Colors.black
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width, height: size.height), center: CGPoint(x: 0, y: 0))
        
        self.position = position
        if var physics = physicsBody {
            physics.dynamic = false
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.categoryBitMask = CollisionCategoryBitmask.Wall
            physics.collisionBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
            physics.contactTestBitMask = CollisionCategoryBitmask.Wall | CollisionCategoryBitmask.Unit
        }
    }
    
    func beginContact(CollisionObject : UInt32) {
        if (scene as! GameScene).isEnded() == false {
            var color = ColorData.changeColor(&colorIndex, scene: scene)
            fillColor = color
        }
    }
    
    func endContact(CollisionObject : UInt32) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}