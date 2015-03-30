//
//  GameScene.swift
//  game
//
//  Created by Yuriy Rebryk on 27/03/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var unit: Unit?
    var left: Bool = false
    var right: Bool = false
    var force: Double = 70.0
    var enemyUnit: Unit?
    
    func createWall(corner : CGPoint, size : CGPoint) {
        for i in 1...Int(size.x) {
            for j in 1...Int(size.y) {
                let wall = Wall.createWall(CGPoint(x : (Int(corner.x) + (i - 1) * 40), y : (Int(corner.y) + (j - 1) * 40)))
                self.addChild(wall)
            }
        }
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.contactDelegate = self
        self.backgroundColor = NSColor(red: 0.95, green: 0.95, blue: 1, alpha: 1.0)
        self.physicsWorld.gravity = CGVectorMake(0.0, -4.9)
        unit = Unit.createUnit(CGPoint(x : 100, y : 100));
        self.addChild(unit!)
        enemyUnit = Unit.createUnit(CGPoint(x : 250, y : 500));
        self.addChild(enemyUnit!)
        self.createWall(CGPoint(x : 0, y : 10), size: CGPoint(x : 30, y : 2))
        self.createWall(CGPoint(x : 200, y : 190), size: CGPoint(x : 10, y : 1))
        self.createWall(CGPoint(x : 10, y : 0), size: CGPoint(x : 1, y : 20))
        self.createWall(CGPoint(x : 1000, y : 0), size: CGPoint(x : 1, y : 20))
        self.createWall(CGPoint(x : 400, y : 330), size: CGPoint(x : 10, y : 1))
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
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
        if unit?.position.x > enemyUnit?.position.x {
            enemyUnit?.physicsBody?.applyForce(CGVector(dx: force, dy: 0))
        }
        if unit?.position.x < enemyUnit?.position.x {
            enemyUnit?.physicsBody?.applyForce(CGVector(dx: -force, dy: 0))
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        self.backgroundColor = NSColor(red: CGFloat(rand() % 2), green: CGFloat(rand() % 2), blue: CGFloat(rand() % 2), alpha: 1.0)
    }
}
