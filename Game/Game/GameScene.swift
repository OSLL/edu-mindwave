//
//  GameScene.swift
//  Game
//
//  Created by Yuriy Rebryk on 06/04/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit
import Cocoa

class GameScene: SKScene, SKPhysicsContactDelegate {
    var appDel: AppDelegate?
    
    var world: SKNode?
    
    private var thinkGear: ThinkGear?
    var camera: Camera?
    var unit: Unit?
    private var info: InfoDisplay?
    
    private let useMindWave = false
    private var time: Timer?
    private var waitTimer: Timer?
    private let waitingTime = 2.0
    
    private var colorsCount = Array<Int>(count: count(ColorData.colors), repeatedValue: 0)
    private var ended = false
    
    func toGLKVector4(color: NSColor) -> GLKVector4 {
        //return GLKVector4Make(Float(color.redComponent), Float(color.greenComponent), Float(color.blueComponent), Float(color.alphaComponent))
        return GLKVector4Make(0.5, 0.5, 0.5, 1.0)
    }
    
    func makeGradientBackground(topColor: NSColor, bottomColor: NSColor) {
        var size = appDel!.skView!.frame.size
        
        let myShader = SKShader(fileNamed: "TheShader")
        
        let color1 = toGLKVector4(NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        //let color2 =  toGLKVector4(NSColor(red: 0, green: 0, blue: 0, alpha: 1))
        var topColorUniform = SKUniform(name: "topColor", floatVector4: color1)
        //let bottomColorUniform = SKUniform(name: "bottomColor", floatVector4: color2)
        myShader.addUniform(topColorUniform)
        //myShader.addUniform(bottomColorUniform)
        
        let effectNode = SKEffectNode()
        effectNode.shader = myShader
        effectNode.shouldEnableEffects = true
        effectNode.zPosition = -3
        addChild(effectNode)
        
        var background = SKSpriteNode(color: Colors.blue, size: CGSize(width: size.width, height: size.height))
        
        effectNode.addChild(background)
    }
    
    override func didMoveToView(view: SKView) {
        if useMindWave == true {
            if thinkGear == nil {
                thinkGear = ThinkGear()
            }
            thinkGear?.Connect()
        }
    
        // set anchorPoint
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        //scene?.backgroundColor = Colors.white
        let topColor = Colors.blue
        let bottomColor = Colors.green
        makeGradientBackground(topColor, bottomColor: bottomColor)
        
        // setup world
        world = SKNode()
        if world != nil {
            world!.name = "world"
            // setup camera
            addChild(world!)
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
        // move camera
        camera?.apply()
        
        // check win/lose
        if checkColors() && ended == false {
            info?.setText("YOU WIN")
            ended = true
        } else if unit?.killed == true {
            if ended == false {
                info?.setText("YOU LOSE")
                ended = true
            }
            unit?.hidden = true
            unit?.physicsBody?.dynamic = false
        }
        
        if ended == true {
            if waitTimer == nil {
                waitTimer = Timer(startTime: NSTimeInterval(currentTime))
            }
            waitTimer?.update(NSTimeInterval(currentTime))
            if waitTimer!.seconds > waitingTime {
                thinkGear?.Disconnect()
                appDel!.loadLevelLibrary()
            }
            return;
        }
        
        // update timer
        if time == nil {
            time = Timer(startTime: NSTimeInterval(currentTime))
        }
        time?.update(NSTimeInterval(currentTime))
        info?.setTime(time!.seconds)
        
        // update data
        if let data = thinkGear {
            info?.setMeditation(Int(data.eSenseMeditation))
            info?.setAttention(Int(data.eSenseAttention))
        }
        
        if unit != nil {
            unit!.move()
            camera?.move(unit!.position)
            camera?.apply()
        }
    }

    func checkColors() -> Bool {
        var zeroCount = 0
        for x in colorsCount {
            if x == 0 {
                ++zeroCount
            }
        }
        return zeroCount == count(colorsCount) - 1 ? true : false
    }
    
    func createLevel(path: String) {
        ended = false
        info = InfoDisplay(size: CGSize(width: 1440, height: 900))
        addChild(info!)
        
        let reader = Reader(path: path)
    
        while let type = reader.readWord() {
            switch type {
            case "World":
                let size = reader.readSize()
                camera?.worldSize = size
                LevelBuilder.buildWalls(world!, size: size)
            case "Fixed", "Dynamic":
                var shape = reader.readWord()!
                var block: Block? = nil
                switch shape {
                    case "Block":
                        if type == "Fixed" {
                            block = Block(size: reader.readSize(), position: reader.readPosition(), colorIndex: reader.readInt())
                        } else {
                            block = ActiveBlock(size: reader.readSize(), position: reader.readPosition(), colorIndex: reader.readInt())
                        }
                    case "Circle":
                        if type == "Fixed" {
                            block = Block(radius: CGFloat(reader.readDouble()), position: reader.readPosition(), colorIndex: reader.readInt())
                        } else {
                            block = ActiveBlock(radius: CGFloat(reader.readDouble()), position: reader.readPosition(), colorIndex: reader.readInt())
                        }
                    default:
                        break
                }
                ++colorsCount[block!.colorIndex]
                while let action = reader.readAction() {
                    block!.runAction(action)
                }
                world?.addChild(block!)
            case "Camera":
                camera = Camera(position: reader.readPosition())
                world!.addChild(camera!)
            case "Unit":
                unit = Unit(position: reader.readPosition())
                world!.addChild(unit!)
            case "BlackHole":
                var blackHole = BlackHole(size: reader.readInt(), position: reader.readPosition())
                world!.addChild(blackHole)
            default :
                break
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
    
        world.physicsWorld.addJoint(spring)
        */
    }
    
    func incColorCount(index: Int) {
        ++colorsCount[index]
    }
    
    func decColorCount(index: Int) {
        --colorsCount[index]
    }
    
    func isEnded() -> Bool {
        return ended
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