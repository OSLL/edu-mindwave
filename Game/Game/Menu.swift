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
    var focus: Focus?
    var startButton: Button?
    var exitButton: Button?
    
    func makeGradientBackground() {
        var background = SKSpriteNode(color: NSColor.whiteColor(), size: appDel!.skView!.frame.size)
        background.position = CGPoint(x: background.size.width / 2, y: background.size.height / 2)
        addChild(Graphics.makeGradient(background, shaderType: Shader.Sky))
    }
    
    override func keyDown(theEvent: NSEvent) {
        switch (theEvent.keyCode) {
            // arrow up
            case 126:
                focus?.moveUp()
            // arrow down
            case 125:
                focus?.moveDown()
            // enter
            case 36:
                focus?.activate()
            default:
                break
        }
    }
    
    func terminate() {
        self.appDel!.terminate()
    }
    
    func loadLevelLibrary() {
        self.appDel!.loadLevelLibrary()
    }
    
    // WARNING
    func addButtons() {
        // button "New Game"
        let x = (1440 -  280) / 2
        startButton = Button(text: "New Game", settings: Buttons.LargeWithShadow, buttonAction: loadLevelLibrary)
        startButton!.position = CGPoint(x: x, y: 600)
        addChild(startButton!)
        
        // button "Exit"
        exitButton = Button(text: "Exit", settings: Buttons.LargeWithShadow, buttonAction: terminate)
        exitButton!.position = CGPoint(x: x, y: 500)
        addChild(exitButton!)
    }
    
    override func didMoveToView(view: SKView) {
        makeGradientBackground()
        addButtons()
        focus = Focus(buttons: [[startButton!], [exitButton!]], row: 0, col: 0)
    }
};