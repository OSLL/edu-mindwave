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
        let button = Button {
            self.appDel!.loadLevel("/Users/rebryk/Google Drive/edu-mindwave/Game/level0.lv")
        }
        button.position = CGPoint(x: 300, y: 300)
        addChild(button)
    }
};