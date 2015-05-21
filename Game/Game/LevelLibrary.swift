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
    var buttons: Array<Array<Button>>?
    
    var focus: Focus?
    
    func makeGradientBackground() {
        var background = SKSpriteNode(color: NSColor.whiteColor(), size: appDel!.skView!.frame.size)
        background.position = CGPoint(x: background.size.width / 2, y: background.size.height / 2)
        addChild(Graphics.makeGradient(background, shaderType: Shader.Sky))
    }

    override func keyDown(theEvent: NSEvent) {
        switch (theEvent.keyCode) {
            // Esc
            case 53:
                self.appDel!.loadMenu()
            // arrow up
            case 126:
                focus?.moveUp()
            // arrow down
            case 125:
                focus?.moveDown()
            // arrow left
            case 123:
                focus?.moveLeft()
            // arrow right
            case 124:
                focus?.moveRight()
            // enter
            case 36:
                focus?.activate()
            default:
                break
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
        buttons = Array<Array<Button>>()
        
        let button = Button(text: "Back", settings: Buttons.WithShadow) {
            self.appDel!.loadMenu()
        }
        button.position = CGPoint(x: offset, y: view.bounds.height - (40 + button.size.height))
        addChild(button)
        buttons!.append([button])
        
        var col = 0, row = 0
        var delta = (view.bounds.width - 2 * offset - Buttons.Level.size.width * CGFloat(columnsCount)) / CGFloat(columnsCount - 1)
        var available = true
        for fileName in appDel!.files! {
            var score: String
            if (appDel!.highScores![fileName]) != nil {
                score = timeToString(appDel!.highScores![fileName]!)
            }
            else {
                score = "--:--:--"
            }
            let button = LevelButton(text: fileName.stringByDeletingPathExtension, score: score, available: available) {
                self.appDel!.loadLevel(fileName)
            }
            if (appDel!.highScores![fileName]) == nil {
                available = false
            }
            button.position = CGPoint(x: offset + (Buttons.Level.size.width + delta) * CGFloat(col),
                y: view.bounds.height - 260 - (Buttons.Level.size.height + delta) * CGFloat(row))
            addChild(button)
            
            if count(buttons!) <= row + 1 {
                buttons!.append(Array<Button>())
            }
            buttons![row + 1].append(button)
            if ++col == columnsCount {
                ++row
                col = 0
            }
        }
    }
    
    override func didMoveToView(view: SKView) {
        makeGradientBackground()
        loadLevels(view)
        drawButtons(view, directoryPath: appDel!.fileManager!.currentDirectoryPath)
        focus = Focus(buttons: buttons!, row: 1, col: 0)
    }
};