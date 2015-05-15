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
    
    func loadLevels(view: SKView) {
        let fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager.enumeratorAtPath(fileManager.currentDirectoryPath + "/Levels/")
        
        files = Array<String>()
        while let fileName = enumerator?.nextObject() as? String {
            files!.append(fileName)
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
        
        let button = Button(text: "Back", size: CGSize(width: 150, height: 60), fontSize: 25) {
            self.appDel!.loadMenu()
        }
        button.position = CGPoint(x: offset, y: view.bounds.height - (40 + button.size.height))
        addChild(button)
    }
    
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = Colors.gray
        loadLevels(view)
    }
};