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
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        // setup world
        world = SKNode()
        //world.physicsWorld = SKPhysicsWorld()
        if world != nil {
            world!.name = "world"
            // setup camera
            createLevel(world!, path: "/Users/rebryk/Google Drive/edu-mindwave/Game/level0.lv")
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
    private func createWall(size: CGPoint) -> SKNode {
        var wall = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.x, height: size.y))
        wall.fillColor = NSColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 255/255)
        wall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.x, height: size.y),
            center: CGPoint(x: size.x / 2, y: size.y / 2))
        
        if var physicsBody = wall.physicsBody {
            physicsBody.dynamic = false
            physicsBody.affectedByGravity = false
            physicsBody.allowsRotation = false
        }
        
        return wall
    }
    
    // create level
    private func createSpringBlock(size: CGPoint) -> SKNode {
        var block = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.x, height: size.y))
        block.fillColor = NSColor(red: 100/255, green: 100/255, blue: 200/255, alpha: 255/255)
        block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.x, height: size.y),
            center: CGPoint(x: size.x / 2, y: size.y / 2))
        
        if var physicsBody = block.physicsBody {
            physicsBody.dynamic = true
            physicsBody.affectedByGravity = false
            physicsBody.allowsRotation = false
        }
        
        return block
    }
  
    private func createLevel(world: SKNode, path : String) {
        let level = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        let lines = level!.componentsSeparatedByString("\n")
        
        for line in lines {
            let words = line.componentsSeparatedByString(" ")
            switch words[0] {
            case "size":
                camera?.worldSize = CGSize(width: (words[1] as NSString).integerValue, height: (words[2] as NSString).integerValue)
            case "wall":
                var block = createWall(CGPoint(x : (words[1] as NSString).integerValue, y : (words[2] as NSString).integerValue ))
                block.position.x = CGFloat((words[3] as NSString).integerValue)
                block.position.y = CGFloat((words[4] as NSString).integerValue)
                world.addChild(block)
            case "camera":
                camera = YGCamera()
                camera?.position = CGPoint(x : (words[1] as NSString).integerValue, y : (words[2] as NSString).integerValue)
                world.addChild(camera!)
            case "unit":
                unit = Unit()
                unit?.position = CGPoint(x : (words[1] as NSString).integerValue, y : (words[2] as NSString).integerValue)
                world.addChild(unit!)
            case "saw":
                var saw = Saw()
                saw.position = CGPoint(x : (words[1] as NSString).integerValue, y : (words[2] as NSString).integerValue)
                var rot = SKAction.rotateByAngle(0.04, duration: 0.005)
                var action = SKAction.repeatActionForever(rot)
                saw.runAction(action)
                world.addChild(saw)
            default :
                var nothing = 0
            }
        }
        
        /*
        self.position.x = 100
        var obj1 = createSpringBlock(CGPoint(x: 30.0, y: 30.0))
        obj1.position = CGPoint(x: 200, y: 200)
        self.addChild(obj1)
        var obj2 = createSpringBlock(CGPoint(x: 30.0, y: 30.0))
        obj2.position = CGPoint(x: 200, y: 300)
        self.addChild(obj2)
        var spring = SKPhysicsJointSpring.jointWithBodyA(obj1.physicsBody!, bodyB: obj2.physicsBody!, anchorA: obj1.position, anchorB: obj2.position)
        scene?.physicsWorld.addJoint(spring)
        */

        //world.physicsWorld.addJoint(spring)

    }
    func didBeginContact(contact: SKPhysicsContact) {
        self.backgroundColor = NSColor(red: CGFloat(rand() % 2), green: CGFloat(rand() % 2), blue: CGFloat(rand() % 2), alpha: 1.0)
    }
};