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
        
        path = SKShapeNode(rect: CGRect(origin: CGPoint(x: -size / 2, y: -size / 2), size: CGSize(width: size, height: size)), cornerRadius: 0).path
        fillColor = Colors.black
        strokeColor = Colors.black
        
        self.position = position
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size / 4))
    
        if let physics = self.physicsBody {
            physics.linearDamping = 1.0
            physics.angularDamping = 1.0
            physics.restitution = 1.0
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
            physics.categoryBitMask = CollisionCategoryBitmask.Trap
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
    let holesCount = 3
    let minInterval = 4000
    let maxInterval = 6000
    
    init(size: Int, position: CGPoint, action: SKAction? = nil) {
        super.init()
        
        self.position = position
        zPosition = -1
        for var i = 0; i < holesCount; ++i {
            var radius = size / 4
            var time = minInterval + 250 * i
            var track = CGPathCreateWithEllipseInRect(CGRect(x: -radius + 10 * i, y: -radius + 15 * (i % 2), width: 2 * radius, height: 2 * radius), nil)
            var action = SKAction.followPath(track, asOffset: false, orientToPath: false, duration: Double(time) / 1000.0)
            action = SKAction.repeatActionForever(action)
            var square = BlackSquare(size: size, position: CGPoint(x: 0, y: 0), action: action)
            addChild(square)
        }
        
        var gravityNode = SKFieldNode.radialGravityField()
        gravityNode.falloff = 3.0
        self.addChild(gravityNode)
        
        if action != nil {
            self.runAction(action!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
