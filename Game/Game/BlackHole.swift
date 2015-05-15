//
//  Saw.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit
import Cocoa

class BlackSquare: SKShapeNode, Object {
    let offset = 40
    
    init(size: Int, position: CGPoint, action: SKAction? = nil) {
        super.init()
        
        path = SKShapeNode(rect: CGRect(origin: CGPoint(x: -size / 2, y: -size / 2), size: CGSize(width: size, height: size)), cornerRadius: 3).path
        fillColor = NSColor.blackColor()
        strokeColor = NSColor.darkGrayColor()
        
        self.position = position
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size - offset, height: size - offset), center: CGPoint(x: 0, y: 0))
        
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
            physics.categoryBitMask = CollisionCategoryBitmask.Trap
            physics.collisionBitMask = CollisionCategoryBitmask.Unit
            physics.contactTestBitMask = CollisionCategoryBitmask.Trap
        }
        
        if action != nil {
            self.runAction(action!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func beginContact(CollisionObject : UInt32) {
    }
    
    func endContact(CollisionObject : UInt32) {
    }
}

class BlackHole: SKShapeNode {
    let minCount = 2
    let maxCount = 3
    let minInterval = 4000
    let maxInterval = 6000
    
    init(size: Int, position: CGPoint, action: SKAction? = nil) {
        super.init()
        
        self.position = position
        zPosition = -1
        
        var count = Int(minCount + rand() % (maxCount - minCount + 1))
        for var i = 0; i < count; ++i {
            var x = CGFloat(rand() % Int32(size) - size / 2)
            var y = CGFloat(rand() % Int32(size) - size / 2)
            
            var radius = CGFloat(rand() % Int32(size / 2))
            var interval = minInterval + rand() % (maxInterval - minInterval + 1)
            
            var circle = CGPathCreateWithEllipseInRect(CGRect(x: -radius, y: -radius, width: 2 * radius, height: 2 * radius), nil)
            
            var action = SKAction.repeatActionForever(SKAction.followPath(circle, asOffset: false, orientToPath: false, duration: Double(interval) / 1000.0))
            var square = BlackSquare(size: size, position: CGPoint(x: x, y: y), action: action)
            addChild(square)
        }
        
        if action != nil {
            self.runAction(action!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
