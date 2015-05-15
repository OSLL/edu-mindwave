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
        scene?.backgroundColor = Colors.gray
        /* Setup your scene here */
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