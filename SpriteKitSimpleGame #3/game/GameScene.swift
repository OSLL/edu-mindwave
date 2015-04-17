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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.contactDelegate = self
        self.backgroundColor = NSColor(red: 0.95, green: 0.95, blue: 1, alpha: 1.0)
        self.physicsWorld.gravity = CGVectorMake(0.0, -4.9)
        //let text = "lol"
        //text.writeToFile("level1.lv", atomically: false, encoding: NSUTF8StringEncoding, error: nil)
        let message = String(contentsOfFile: "/Users/urijkravcenko/edu-mindwave/SpriteKitSimpleGame #3/level.lv", encoding: NSUTF8StringEncoding, error: nil)
        let arr = message!.componentsSeparatedByString("\n")
        for next in arr {
            let newType = next.componentsSeparatedByString(" ")
            if newType[0] == "wall" {
                let wall = Wall.createWall(CGPoint(x : newType[1].toInt()!, y : newType[2].toInt()!), size : CGPoint(x : (newType[3] as NSString).doubleValue, y : (newType[4] as NSString).doubleValue))
                self.addChild(wall)
            }
            else if newType[0] == "unit" {
                unit = Unit.createUnit(CGPoint(x : newType[1].toInt()!, y : newType[2].toInt()!));
                self.addChild(unit!)
            }
            else if newType[0] == "enemyUnit" {
                enemyUnit = Unit.createUnit(CGPoint(x : newType[1].toInt()!, y : newType[2].toInt()!));
                self.addChild(enemyUnit!)
            }
        }
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
