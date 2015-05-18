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
        var background = SKSpriteNode(color: Colors.blue, size: appDel!.skView!.frame.size)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(Graphics.makeGradient(background, shaderType: Shader.Blue))
    }
    
    func loadLevelLibrary() {
        self.appDel!.loadLevelLibrary()
    }
    
    func addButtons() {
        // button "New Game"
        let x = (1440 -  280) / 2
        
        let startButton = Button(text: "New Game", size: CGSize(width: 280, height: 80), fontSize: 50, buttonAction: loadLevelLibrary)
        startButton.position = CGPoint(x: x, y: 600)
        addChild(startButton)
        
        // button "Exit"
        let exitButton = Button(text: "Exit", size: CGSize(width: 280, height: 80), fontSize: 50, buttonAction: appDel!.terminate)
        exitButton.position = CGPoint(x: x, y: 500)
        addChild(exitButton)
    }
    
    override func didMoveToView(view: SKView) {
        makeGradientBackground()
        addButtons()
    }
};