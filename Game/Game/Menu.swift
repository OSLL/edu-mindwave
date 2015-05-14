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
        let winner = SKLabelNode(text: "Push mouse down to start")
        winner.fontSize = 65
        winner.fontColor = NSColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 255/255)
        winner.position = CGPoint(x: 500, y: 500)
        self.addChild(winner)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        self.appDel!.loadLevel("/Users/rebryk/Google Drive/edu-mindwave/Game/level0.lv")
    }
};