//
//  Menu.swift
//  Game
//
//  Created by Юрий Кравченко on 06/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class Menu: SKScene {
    var appDel: AppDelegate?
    
    func makeGradientBackground() {
        var size = appDel!.skView!.frame.size
        
        let myShader = SKShader(fileNamed: "TheShader")
        
        let effectNode = SKEffectNode()
        effectNode.shader = myShader
        effectNode.shouldEnableEffects = true
        effectNode.zPosition = -1
        addChild(effectNode)
        
        var background = SKSpriteNode(color: Colors.blue, size: CGSize(width: size.width + 100, height: size.height + 100))
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        effectNode.addChild(background)
    }
    
    override func didMoveToView(view: SKView) {
        //scene?.backgroundColor = Colors.gray
        
        // draw gradient
        //makeGradientBackground()
        //makeGradientLabel("318 nodes 60.0 fps", labelPosition: CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame)))
        
        /*
        let topColor = NSColor(red: 0, green: 168/255, blue: 221/255, alpha: 1)
        let bottomColor = NSColor(red: 40/255, green: 225/255, blue: 244/255, alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
       
        var background = SKSpriteNode(color: Colors.orange, size: CGSize(width: 100, height: 100))
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        
        var gradient = NSGradient(startingColor: topColor, endingColor: bottomColor)
        gradient.drawInRect(background.frame, angle: 270)
        
        //gradient.drawInRect(background.frame, angle: 90)
        
        
        let gradient = CAGradientLayer()
        gradient.colors = gradientColors
        gradient.locations = gradientLocations
        gradient.renderInContext(context)
        */
        
        let startButton = Button(text: "New Game", size: CGSize(width: 280, height: 80), fontSize: 50) {
            self.appDel!.loadLevelLibrary()
        }
        let x = (1440 -  startButton.size.width) / 2
        startButton.position = CGPoint(x: x, y: 600)
        addChild(startButton)
        let exitButton = Button(text: "Exit", size: CGSize(width: 280, height: 80), fontSize: 50) {
            // Exit
        }
        exitButton.position = CGPoint(x: x, y: 500)
        addChild(exitButton)
    }
};