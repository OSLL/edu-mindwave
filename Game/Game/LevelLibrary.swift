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
    
    func drawButtons(view: SKView, directoryPath: String) {
        var i = 0, j = 0
        var delta = (view.bounds.width - 2 * offset - LevelButton.size.width * CGFloat(columnsCount)) / CGFloat(columnsCount - 1)
        var aval = true
        for fileName in appDel!.files! {
            var score: String
            if (appDel!.highScores![fileName]) != nil {
                score = doubleToTime(appDel!.highScores![fileName]!)
            }
            else {
                score = "--:--:--"
            }
            let button = LevelButton(text: fileName.stringByDeletingPathExtension, score: score, aval: aval) {
                self.appDel!.loadLevel(fileName)
            }
            if (appDel!.highScores![fileName]) == nil {
                aval = false
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
    
    func doubleToTime(val: Double) -> String {
        var minutes = floor(val / 60)
        var seconds = floor(val - minutes * 60)
        var milisec = floor((val - seconds - minutes * 60) * 100)
        var sMinutes = String()
        var sSeconds = String()
        var sMilisec = String()
        if (minutes < 10) {
            sMinutes = "0" + toString(Int(minutes))
        }
        else {
            sMinutes = toString(Int(minutes))
        }
        if (seconds < 10) {
            sSeconds = "0" + toString(Int(seconds))
        }
        else {
            sSeconds = toString(Int(seconds))
        }
        if (milisec < 10) {
            sMilisec = "0" + toString(Int(milisec))
        }
        else {
            sMilisec =  toString(Int(milisec))
        }
        return (sMinutes + ":" + sSeconds + ":" + sMilisec)
    }
    
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = Colors.gray
        drawButtons(view, directoryPath: appDel!.fileManager!.currentDirectoryPath)
    }
};