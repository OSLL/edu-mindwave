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
        let fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager.enumeratorAtPath(fileManager.currentDirectoryPath + "/Levels/")
        
        var i = 0, j = 0
        while let fileName = enumerator?.nextObject() as? String {
            let button = Button(text: fileName) {
                self.appDel!.loadLevel(fileManager.currentDirectoryPath + "/Levels/" + fileName)
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