//
//  GameScene.swift
//  Game
//
//  Created by Yuriy Rebryk on 06/04/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var world: SKNode?
    private var camera: YGCamera?
    private var unit: Unit?
    
    var thinkGear: ThinkGear?
    var labelMeditation: SKLabelNode?
    var labelAttention: SKLabelNode?
    var labelWin: SKLabelNode?
    
    private func setLabels() {
        labelWin = SKLabelNode()
        if let label = labelWin {
            label.text = "You win!"
            label.fontSize = 160
            label.fontColor = NSColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 255/255)
            label.position = CGPoint(x: CGRectGetMidX(self.view!.bounds) / 2, y: CGRectGetMidY(self.view!.bounds) / 2);
            //label.hidden = true
            label.zPosition = 1
            self.addChild(label)
        }
    }
    
    override func didMoveToView(view: SKView) {
        /*if thinkGear == nil {
            thinkGear = ThinkGear()
        }
        thinkGear?.Connect()
        */
        
        // set anchorPoint
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        scene?.backgroundColor = NSColor(calibratedRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        // setup world
        world = SKNode()
        if world != nil {
            world!.name = "world"
        
            // setup camera
            self.addChild(world!)
            camera?.apply()
        }
        
        setLabels()
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
        if let data = thinkGear {
            if let label = labelMeditation {
                label.text = toString(data.eSenseMeditation)
            }
            if let label = labelAttention {
                label.text = toString(data.eSenseAttention)
            }
        }
        
        if unit != nil {
            unit!.move()
            camera?.move(unit!.position)
        }
        camera?.apply()
    }

    private func getInt(value: String) -> Int {
        return (value as NSString).integerValue
    }
    
    func createLevel(path : String) {
        let level = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        let lines = level!.componentsSeparatedByString("\n")
        
        for line in lines {
            let words = line.componentsSeparatedByString(" ")
            switch words[0] {
            case "size":
                camera?.worldSize = CGSize(width: getInt(words[1]), height: getInt(words[2]))
            case "block":
                var block = Block(size: CGSize(width: getInt(words[1]), height: getInt(words[2])), position : CGPoint(x: getInt(words[3]), y : getInt(words[4])))
                world?.addChild(block)
            case "camera":
                camera = YGCamera()
                camera?.position = CGPoint(x: getInt(words[1]), y: getInt(words[2]))
                world!.addChild(camera!)
            case "unit":
                unit = Unit()
                unit?.position = CGPoint(x: getInt(words[1]), y: getInt(words[2]))
                world!.addChild(unit!)
            case "saw":
                var saw = Saw(size: CGSize(width: getInt(words[1]), height: getInt(words[2])), position: CGPoint(x: getInt(words[3]), y: getInt(words[4])))
                world!.addChild(saw)
            case "movingSaw":
                var action1 = SKAction.moveBy(CGVector(dx: 150, dy: 80), duration: 1)
                var action2 = SKAction.moveBy(CGVector(dx: -150, dy: -80), duration: 1)
                var actions = SKAction.sequence([action1, action2])
                var action = SKAction.repeatActionForever(actions)
                var saw = Saw(size: CGSize(width: getInt(words[1]), height: getInt(words[2])), position: CGPoint(x: getInt(words[3]), y: getInt(words[4])), action: action)
                world!.addChild(saw)
                
            default :
                var nothing = 0
            }
        }
        
        var door = Door(radius: 100, position: CGPoint(x: 100, y: 100), action: nil)
        world?.addChild(door)
        
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