//
//  GameScene.swift
//  Game
//
//  Created by Yuriy Rebryk on 06/04/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var world: SKNode?
    private var camera: YGCamera?
    private var unit: Unit?

    override func didMoveToView(view: SKView) {
        // set anchorPoint
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        // setup world
        world = SKNode()
        if world != nil {
            world!.name = "world"
            // setup camera
            createLevel(world!, path: "/Users/urijkravcenko/edu-mindwave/Game/level0.lv")
            self.addChild(world!)
            camera?.apply()
        }
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 126 {
            unit?.jump = true
        }
        
        if theEvent.keyCode == 123 {
            unit?.moveLeft = true
        }
        
        if theEvent.keyCode == 124 {
            unit?.moveRight = true
        }
    }
    
    override func keyUp(theEvent: NSEvent) {
        if theEvent.keyCode == 123 {
            unit?.moveLeft = false
        }
        
        if theEvent.keyCode == 124 {
            unit?.moveRight = false
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if unit != nil {
            unit!.move()
            camera?.move(unit!.position)
        }
        camera?.apply()
    }
    
    // create level

    private func createLevel(world: SKNode, path : String) {
        let level = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        let lines = level!.componentsSeparatedByString("\n")
        for line in lines {
            let words = line.componentsSeparatedByString(" ")
            switch words[0] {
            case "size":
                camera?.worldSize = CGSize(width: (words[1] as NSString).integerValue, height: (words[2] as NSString).integerValue)
            case "wall":
                var block = Wall(size: CGPoint(x : (words[1] as NSString).integerValue, y : (words[2] as NSString).integerValue), position : CGPoint(x : (words[3] as NSString).integerValue, y : (words[4] as NSString).integerValue))
                world.addChild(block)
            case "camera":
                camera = YGCamera()
                camera?.position = CGPoint(x : (words[1] as NSString).integerValue, y : (words[2] as NSString).integerValue)
                world.addChild(camera!)
            case "unit":
                unit = Unit()
                unit?.position = CGPoint(x : (words[1] as NSString).integerValue, y : (words[2] as NSString).integerValue)
                world.addChild(unit!)
            default :
                var nothing = 0
            }
        }
    }
    func didBeginContact(contact: SKPhysicsContact) {
        if let a = (((contact.bodyA.node) as? Object)) {
            a.beginContact(contact.bodyB.node!.physicsBody!.categoryBitMask)
        }
        if let b = (((contact.bodyB.node) as? Object)) {
            b.beginContact(contact.bodyA.node!.physicsBody!.categoryBitMask)
        }
    }
    func didEndContact(contact: SKPhysicsContact) {
        if let a = (((contact.bodyA.node) as? Object)) {
            a.endContact(contact.bodyB.node!.physicsBody!.categoryBitMask)
        }
        if let b = (((contact.bodyB.node) as? Object)) {
            b.endContact(contact.bodyA.node!.physicsBody!.categoryBitMask)
        }
    }
};