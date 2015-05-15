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
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let startButton = Button(text: "New Game") {
            if let library = LevelLibrary.unarchiveFromFile("LevelLibrary") as? LevelLibrary {
                library.scaleMode = SKSceneScaleMode.ResizeFill
                library.appDel = self.appDel
                self.appDel!.skView!.presentScene(library)
                self.appDel!.skView!.ignoresSiblingOrder = true
            }
        }
        let x = (1440 - Button.width) / 2
        startButton.position = CGPoint(x: x, y: 600)
        addChild(startButton)
        let exitButton = Button(text: "Exit") {
            // Exit
        }
        exitButton.position = CGPoint(x: x, y: 500)
        addChild(exitButton)

    }
};