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
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        loadMenu()
    }
    
    func loadMenu() {
        if let menu = Menu.unarchiveFromFile("Menu") as? Menu {
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
    
    func loadLevel(path: NSString) {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = SKSceneScaleMode.ResizeFill
            scene.appDel = self
            self.skView!.presentScene(scene)
            scene.createLevel(path as String)
            
        
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = true
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
