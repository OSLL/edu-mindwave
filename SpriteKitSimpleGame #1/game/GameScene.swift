//
//  GameScene.swift
//  game
//
//  Created by Yuriy Rebryk on 27/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = NSColor(red: 0.95, green: 0.95, blue: 1, alpha: 1.0)
        self.physicsWorld.gravity = CGVectorMake(0.0, -4.9)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)
        let sprite = SKSpriteNode(imageNamed:"Ball")
        sprite.position = location;
        sprite.setScale(0.2)
        sprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Ball"), size: sprite.size)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = true
            physics.allowsRotation = true
            physics.dynamic = true
            physics.mass = 1
            physics.restitution = 0.8
            physics.linearDamping = 0.8
            physics.angularDamping = 0.8
        }
        self.addChild(sprite)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
