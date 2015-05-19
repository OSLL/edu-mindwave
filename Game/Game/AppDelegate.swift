//
//  AppDelegate.swift
//  Game
//
//  Created by Yuriy Rebryk on 06/04/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//


import Cocoa
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as? SKNode
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    var thinkGear: ThinkGear?
    
    let useMindWave = false
    let useScreen = false
    
    var files: Array<String>?
    var highScores: Dictionary<String, Double>?
    var fileManager: NSFileManager?
    
    func loadLevels() {
        fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager!.enumeratorAtPath(fileManager!.currentDirectoryPath + "/Levels/")
        
        files = Array<String>()
        while let fileName = enumerator?.nextObject() as? String {
            if fileName.pathExtension == "level" {
                files!.append(fileName)
            }
        }
        files!.sort {($0.stringByDeletingPathExtension as NSString).integerValue < ($1.stringByDeletingPathExtension as NSString).integerValue}
    }
    
    func loadHightScores() {
        highScores = Dictionary<String, Double>()
        
        let reader = Reader(path: fileManager!.currentDirectoryPath + "/Levels/high.scores")
        
        while let name = reader.readWord() {
            highScores![name] = reader.readDouble(gap: false)
        }
        
    }
    
    func disconnectMindWave() {
        thinkGear?.Disconnect()
    }
    
    func tryToConnectMindWave() {
        if useMindWave == true {
            if thinkGear == nil {
                thinkGear = ThinkGear()
            }
            thinkGear?.Connect()
        }
    }
    
    func enableFullScreen() {
        self.skView.enterFullScreenMode(NSScreen.mainScreen()!, withOptions: nil)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        tryToConnectMindWave()
        //enableFullScreen()
        self.skView!.ignoresSiblingOrder = true
        loadLevels()
        loadHightScores()
        if useScreen {
            showScreen()
        } else {
            loadMenu()
        }
    }
    
    func loadMenu() {
        if let menu = Menu.unarchiveFromFile("Menu") as? Menu {
            menu.size = CGSize(width: 1440.0, height: 900.0)
            menu.scaleMode = SKSceneScaleMode.ResizeFill
            menu.appDel = self
            self.skView!.presentScene(menu)
            self.skView!.ignoresSiblingOrder = true
        }
    }
    
    func loadLevelLibrary() {
        if let library = LevelLibrary.unarchiveFromFile("LevelLibrary") as? LevelLibrary {
            library.scaleMode = SKSceneScaleMode.ResizeFill
            library.appDel = self
            self.skView!.presentScene(library)
            self.skView!.ignoresSiblingOrder = true
        }
    }
    
    func showScreen() {
        if let screen = Screen.unarchiveFromFile("Screen") as? Screen {
            screen.scaleMode = SKSceneScaleMode.ResizeFill
            screen.appDel = self
            self.skView!.presentScene(screen)
            self.skView!.ignoresSiblingOrder = true
        }
    }
    
    func loadLevel(fileName: NSString) {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            /* Set the scale mode to scale to fit the window */
            self.skView.showsFPS = true
            scene.scaleMode = SKSceneScaleMode.ResizeFill
            scene.appDel = self
            scene.thinkGear = thinkGear
            self.skView!.presentScene(scene)
            scene.createLevel(fileName as String)
        }
    }
    
    func terminate() {
        self.disconnectMindWave()
        var outFile = ""
        for (name, score) in highScores! {
            outFile = outFile + name + " " + toString(score) + "\n"
        }
        outFile.writeToFile(fileManager!.currentDirectoryPath + "/Levels/high.scores", atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        NSApplication.sharedApplication().terminate(self)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
