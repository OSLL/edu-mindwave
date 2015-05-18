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
    /*
    init(colorIndex: Int) {
        super.init()
        self.colorIndex = colorIndex
        fillColor = ColorData.colors[colorIndex]
        strokeColor = Colors.black
    }
    */
    
    init(size: CGSize, position: CGPoint, colorIndex: Int) {
        super.init()
        self.colorIndex = colorIndex
        fillColor = ColorData.colors[colorIndex]
        strokeColor = Colors.black
        
        //self.init(colorIndex: colorIndex)
        self.position = position
        path = SKShapeNode(rect: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height), cornerRadius: 3).path
        physicsBody = SKPhysicsBody(polygonFromPath: path)
        setPhyscicsBody()
    }
    
    init(radius: CGFloat, position: CGPoint, colorIndex: Int) {
        super.init()
        self.colorIndex = colorIndex
        fillColor = ColorData.colors[colorIndex]
        strokeColor = Colors.black
        
        //self.init(colorIndex: colorIndex)
        self.position = position
        path = SKShapeNode(ellipseInRect: CGRect(x: -radius, y: -radius, width: 2 * radius, height: 2 * radius)).path
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        setPhyscicsBody()
    }
    
     func setPhyscicsBody() {
        if var physics = physicsBody {
            physics.dynamic = false
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.categoryBitMask = CollisionCategoryBitmask.Block
            physics.collisionBitMask = CollisionCategoryBitmask.Block | CollisionCategoryBitmask.Unit | CollisionCategoryBitmask.Wall
            physics.contactTestBitMask = CollisionCategoryBitmask.Block | CollisionCategoryBitmask.Unit
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