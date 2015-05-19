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
    
    let columnsCount: Int = 9
    let offset: CGFloat = 70
    var files: Array<String>?
    
    func makeGradientBackground() {
        var background = SKSpriteNode(color: NSColor.whiteColor(), size: appDel!.skView!.frame.size)
        background.position = CGPoint(x: background.size.width / 2, y: background.size.height / 2)
        addChild(Graphics.makeGradient(background, shaderType: Shader.Sky))
    }

    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 53 {
            self.appDel!.loadMenu()
        }
    }
    
    func loadLevels(view: SKView) {
        let fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager.enumeratorAtPath(fileManager.currentDirectoryPath + "/Levels/")
        
        files = Array<String>()
        while let fileName = enumerator?.nextObject() as? String {
            if fileName.pathExtension == "level" {
                files!.append(fileName)
            }
        }
        files!.sort {($0.stringByDeletingPathExtension as NSString).integerValue < ($1.stringByDeletingPathExtension as NSString).integerValue}
        drawButtons(view, directoryPath: fileManager.currentDirectoryPath)
    }
    
    func drawButtons(view: SKView, directoryPath: String) {
        var i = 0, j = 0
        var delta = (view.bounds.width - 2 * offset - LevelButton.size.width * CGFloat(columnsCount)) / CGFloat(columnsCount - 1)
        
        for fileName in files! {
            let button = LevelButton(text: fileName.stringByDeletingPathExtension) {
                self.appDel!.loadLevel(directoryPath + "/Levels/" + fileName)
            }
            button.position = CGPoint(x: offset + (LevelButton.size.width + delta) * CGFloat(i), y: view.bounds.height - (250 + (100 + delta) * CGFloat(j)))
            addChild(button)
            if ++i == columnsCount {
                ++j
                i = 0
            }
        }
        
        let button = Button(text: "Back", settings: Buttons.Level) {
            self.appDel!.loadMenu()
        }
        button.position = CGPoint(x: offset, y: view.bounds.height - (40 + button.size.height))
        addChild(button)
    }
    
    override func didMoveToView(view: SKView) {
        makeGradientBackground()
        loadLevels(view)
    }
};