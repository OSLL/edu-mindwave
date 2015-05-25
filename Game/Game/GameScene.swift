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
    var levelName: String?
    var info: InfoDisplay?
    
    var time: Timer?
    
    var colorsCount = Array<Int>(count: count(ColorData.colors), repeatedValue: 0)
    var ended = false
    
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
                Player.pushButton()
                pause()
            // arrow up
            case 126:
                if menu {
                    if info?.focus?.moveUp() == true {
                        Player.switchButton()
                    }
                } else {
                    unit?.jump = true
                }
            // arrow down
            case 125:
                if menu {
                    if info?.focus?.moveDown() == true {
                        Player.switchButton()
                    }
                }
            // arrow left
            case 123:
                if menu {
                    if info?.focus?.moveLeft() == true {
                        Player.switchButton()
                    }
                } else {
                    unit?.moveLeft = true
                }
            // arrow right
            case 124:
                if menu {
                    if info?.focus?.moveRight() == true {
                        Player.switchButton()
                    }
                } else {
                    unit?.moveRight = true
                }
            // enter
            case 36:
                if menu {
                    Player.pushButton()
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
            if meditation > 40 {
                physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8 +  (15.0 / 60.0) * (Double(meditation) - 40.0))
            }
            info?.setAttention(attention)
            info?.setMeditation(meditation)
            for challenge in challenges {
                challenge!.check(attention)
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
        LevelBuilder.loadLevel(self, levelName: levelName)
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
        if let a = contact.bodyA.node as? Unit {
            if let b = contact.bodyB.node as? Challenge {
                a.challengeContact(b)
            }
        }
        if let a = contact.bodyB.node as? Unit {
            if let b = contact.bodyA.node as? Challenge {
                a.challengeContact(b)
            }
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