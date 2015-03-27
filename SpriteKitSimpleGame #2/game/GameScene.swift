//
//  GameScene.swift
//  game
//
//  Created by Yuriy Rebryk on 27/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var unit: Unit?
    var left: Bool = false
    var right: Bool = false
    var force: Double = 70.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = NSColor(red: 0.95, green: 0.95, blue: 1, alpha: 1.0)
        self.physicsWorld.gravity = CGVectorMake(0.0, -4.9)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        let location = theEvent.locationInNode(self)
        unit = Unit.createUnit(location);
        self.addChild(unit!)
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 126 {
            if unit?.physicsBody?.velocity.dy < 5 && unit?.physicsBody?.velocity.dy > -5 {
                unit?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
            }
        }
        if theEvent.keyCode == 123 {
            left = true
        }
        if theEvent.keyCode == 124 {
            right = true
        }
    }
    
    override func keyUp(theEvent: NSEvent) {
        if theEvent.keyCode == 123 {
            left = false
        }
        if theEvent.keyCode == 124 {
            right = false
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if left {
            unit?.physicsBody?.applyForce(CGVector(dx: -force, dy: 0))
        }
        if right {
            unit?.physicsBody?.applyForce(CGVector(dx: force, dy: 0))
        }
    }
}
