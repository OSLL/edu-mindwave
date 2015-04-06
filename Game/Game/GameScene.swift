//
//  GameScene.swift
//  Game
//
//  Created by Yuriy Rebryk on 06/04/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var world: SKNode?
    private var camera: YGCamera?
    private var unit: YGUnit?

    override func didMoveToView(view: SKView) {
        // set anchorPoint
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // setup world
        world = SKNode()
        if world != nil {
            world!.name = "world"
            // setup camera
            camera = YGCamera()
            if camera != nil {
                world!.addChild(camera!)
            }
            
            unit = YGUnit()
            if unit != nil {
                world!.addChild(unit!)
            }
        
            unit?.position = CGPoint(x: 720, y: 100)
            camera?.position = CGPoint(x: 720, y: 450)
            
            createLevel(world!)
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
    private func createWall(width: CGFloat, height: CGFloat) -> SKNode {
        var wall = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: height))
        wall.fillColor = NSColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 255/255)
        wall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: width, height: height),
            center: CGPoint(x: width / 2, y: height / 2))
        
        if var physicsBody = wall.physicsBody {
            physicsBody.dynamic = false
            physicsBody.affectedByGravity = false
            physicsBody.allowsRotation = false
        }
        
        return wall
    }
    
    private func createLevel(world: SKNode) {
        camera?.worldSize = CGSize(width: 3000, height: 3000)
        
        var leftWall = createWall(10, height: 3000)
        
        var rightWall = createWall(10, height: 3000)
        rightWall.position.x = 3000 - 10
        
        var bottomWall = createWall(3000, height: 10)
        
        var ceilingWall = createWall(3000, height: 10)
        ceilingWall.position.y = 3000 - 10

        world.addChild(leftWall)
        world.addChild(rightWall)
        world.addChild(bottomWall)
        world.addChild(ceilingWall)
        
        for var i = 1; i <= 12; ++i {
            var block = createWall(150, height: 20)
            block.position.x = 80 * CGFloat(i) + 150 * CGFloat(i - 1)
            block.position.y = 120 * CGFloat(i)
            world.addChild(block)
        }
        
        for var i = 1; i <= 12; ++i {
            var block = createWall(150, height: 20)
            block.position.x = 3000 - (80 * CGFloat(i) + 150 * CGFloat(i + 1))
            block.position.y = 120 * CGFloat(i + 12)
            world.addChild(block)
        }
        
    }
    
}
