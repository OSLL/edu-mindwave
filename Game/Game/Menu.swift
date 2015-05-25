
//
//  Menu.swift
//  Game
//
//  Created by Юрий Кравченко on 06/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit
import AVFoundation

class Menu: SKScene {
    var appDel: AppDelegate?
    var focus: Focus?
    var startButton: Button?
    var exitButton: Button?
    var nameLabel: ShadowLabelNode?
    
    var player: Player?
    
    func makeGradientBackground() {
        var background = SKSpriteNode(color: NSColor.whiteColor(), size: appDel!.skView!.frame.size)
        background.position = CGPoint(x: background.size.width / 2, y: background.size.height / 2)
        addChild(Graphics.makeGradient(background, shaderType: Shader.Sky))
    }
    
    override func keyDown(theEvent: NSEvent) {
        switch (theEvent.keyCode) {
            // arrow up
            case 126:
                if focus?.moveUp() == true {
                    player?.switchButton()
                }
            // arrow down
            case 125:
                if focus?.moveDown() == true {
                    player?.switchButton()
                }
            // enter
            case 36:
                Player.pushButton()
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
        // add player
        player = Player()
        addChild(player!)
        
        // button "New Game"
        startButton = Button(text: "New Game", settings: Buttons.LargeWithShadow, buttonAction: loadLevelLibrary)
        addChild(startButton!)
        
        // button "Exit"
        exitButton = Button(text: "Exit", settings: Buttons.LargeWithShadow, buttonAction: terminate)
        addChild(exitButton!)
        
        // label "MIT"
        nameLabel = ShadowLabelNode(settings: Labels.gameCaption)
        nameLabel?.position = CGPoint(x: self.scene!.frame.size.width / 2.0, y: 550)
        nameLabel?.text = "Blocky"
        addChild(nameLabel!)
        
        let x = (self.scene!.frame.size.width -  startButton!.size.width) / 2
        startButton!.position = CGPoint(x: x, y: 350)
        exitButton!.position = CGPoint(x: x, y: 230)
    }
    
    override func didMoveToView(view: SKView) {
        if appDel!.backgroundPlayer?.player?.playing == false {
           appDel!.backgroundPlayer?.player?.play()
        }
        makeGradientBackground()
        addButtons()
        focus = Focus(buttons: [[startButton!], [exitButton!]], row: 0, col: 0)
    }
};