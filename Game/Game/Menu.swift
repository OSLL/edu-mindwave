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
        var background = SKSpriteNode(color: NSColor.whiteColor(), size: appDel!.skView!.frame.size)
        background.position = CGPoint(x: background.size.width / 2, y: background.size.height / 2)
        addChild(Graphics.makeGradient(background, shaderType: Shader.Sky))
    }
    
    func loadLevelLibrary() {
        self.appDel!.loadLevelLibrary()
    }
    
    func terminate() {
        self.appDel!.disconnectMindWave()
        NSApplication.sharedApplication().terminate(self)
    }
    
    func addButtons() {
        // button "New Game"
        let x = (1440 -  280) / 2
        let startButton = Button(text: "New Game", settings: Buttons.LargeWithShadow, buttonAction: loadLevelLibrary)
        startButton.position = CGPoint(x: x, y: 600)
        addChild(startButton)
        
        // button "Exit"
        let exitButton = Button(text: "Exit", settings: Buttons.LargeWithShadow, buttonAction: terminate)
        exitButton.position = CGPoint(x: x, y: 500)
        addChild(exitButton)
    }
    
    override func didMoveToView(view: SKView) {
        makeGradientBackground()
        addButtons()
    }
};