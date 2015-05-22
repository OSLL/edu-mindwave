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
    var thinkGear: ThinkGear?
    
    var world: SKNode?
    
    var camera: Camera?
    var unit: Unit?
    private var levelName: String?
    private var info: InfoDisplay?
    
    private var time: Timer?
    
    private var colorsCount = Array<Int>(count: count(ColorData.colors), repeatedValue: 0)
    private var ended = false
    
    var challenges = Array<Challenge?>()
    
    func restart() {
        self.appDel!.loadLevel(levelName!)
    }
    
    func loadLevels() {
        self.appDel!.loadLevelLibrary()
    }
    
    func makeGradientBackground() {
        var background = SKSpriteNode(color: NSColor.whiteColor(), size: appDel!.skView!.frame.size)
        self.addChild(Graphics.makeGradient(background, shaderType: Shader.Sky))
    }
    
    override func didMoveToView(view: SKView) {
        // set anchorPoint
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -10)
        makeGradientBackground()
        
        // setup world
        world = SKNode()
        if world != nil {
            world!.name = "world"
            // setup camera
            addChild(world!)
            camera?.apply()
        }
        
    }
    
    func isNextLevelEnable() -> Bool {
        return appDel!.isNextLevelEnable(levelName!)
    }
    
    func loadNextLevel() {
        appDel!.loadNextLevel(levelName!)
    }
    
    func pause() {
        if ended == true {
            return
        }
        if paused == false {
            paused = true
            info?.showPauseFrame()
            time?.pause()
        } else {
            paused = false
            info?.hidePauseFrame()
            time?.start()
        }
    }
    
    override func keyDown(theEvent: NSEvent) {
        var menu = (ended || paused ? true : false)
        switch (theEvent.keyCode) {
            // Esc
            case 53:
                pause()
            // arrow up
            case 126:
                if menu {
                    info?.focus?.moveUp()
                } else {
                    unit?.jump = true
                }
            // arrow down
            case 125:
                if menu {
                    info?.focus?.moveDown()
                }
            // arrow left
            case 123:
                if menu {
                    info?.focus?.moveLeft()
                } else {
                    unit?.moveLeft = true
                }
            // arrow right
            case 124:
                if menu {
                    info?.focus?.moveRight()
                } else {
                    unit?.moveRight = true
                }
            // enter
            case 36:
                if menu {
                    info?.focus?.activate()
                }
            default:
                break
        }
    }
    
    override func keyUp(theEvent: NSEvent) {
        switch (theEvent.keyCode) {
            // arrow left
            case 123:
                unit?.moveLeft = false
            // arrow right
            case 124:
                unit?.moveRight = false
            default:
                break
        }
    }
    
    func updateResult() {
        if (appDel!.highScores![levelName!] == nil || appDel!.highScores![levelName!] > time!.seconds) {
            appDel!.highScores![levelName!] = time!.seconds
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        // move camera
        camera?.apply()
        
        // check win/lose
        if checkColors() && ended == false {
            updateResult()
            info?.showYouWin()
            ended = true
        } else if unit?.killed == true {
            if ended == false {
                info?.showYouLose()
                ended = true
            }
            unit?.hidden = true
            unit?.physicsBody?.dynamic = false
        }
        
        info?.setBestTime(self.appDel!.highScores![levelName!])
        if ended {
            return
        }
        
        // update timer
        if time == nil {
            time = Timer(startTime: NSTimeInterval(currentTime))
        }
        time?.update(NSTimeInterval(currentTime))
        info?.setTime(time!.seconds)
        
        // update meditation and attention
        if thinkGear != nil {
            var meditation = thinkGear!.eSenseMeditation
            var attention = thinkGear!.eSenseAttention
            physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
            if meditation > 50 {
                physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8 +  (12.0 / 50.0) * (Double(meditation) - 50.0))
            }
            info?.setAttention(attention)
            info?.setMeditation(meditation)
            for challenge in challenges {
                challenge!.check(attention)
            }
        }
        else {
            for challenge in challenges {
                challenge!.check(50)
            }
        }
        for challenge in challenges {
            challenge!.check(0)
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
   
    
    func createLevel(levelName: String) {
        self.levelName = levelName
        ended = false
        info = InfoDisplay(size: CGSize(width: 1440, height: 900))
        addChild(info!)
        
        let reader = Reader(path: appDel!.fileManager!.currentDirectoryPath + "/Levels/" + levelName)
    
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
            case "Challenge":
                var block = Block(size: reader.readSize(), position: reader.readPosition(), colorIndex: reader.readInt())
                var challenge = Challenge(size: reader.readSize(), position: reader.readPosition(), attention: reader.readInt(), message: reader.readMessage(), object: block as SKNode, action: reader.readAction()!)
                challenge.scen = self
                world!.addChild(block)
                world!.addChild(challenge)
                challenges.append(challenge)
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