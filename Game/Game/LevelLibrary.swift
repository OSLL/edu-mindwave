//
//  LevelLibrary.swift
//  Game
//
//  Created by Юрий Кравченко on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class LevelLibrary: SKScene {
    var appDel: AppDelegate?
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let levels = (String(contentsOfFile: "/Users/urijkravcenko/edu-mindwave/Game/Level.info", encoding: NSUTF8StringEncoding, error: nil))!.componentsSeparatedByString("\n")
        var i = 0, j = 0
        for level in levels {
            let button = Button {
                self.appDel!.loadLevel("/Users/urijkravcenko/edu-mindwave/Game/" + level)
            }
            button.position = CGPoint(x: 100 + 300 * i, y: 600 - 100 * j)
            addChild(button)
            i += 1
            if i == 4 {
                i = 0
                j += 1
            }
        }
    }
};