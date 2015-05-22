//
//  Player.swift
//  Game
//
//  Created by Yuriy Rebryk on 21/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Player: SKNode {
    static let pushButtonUrl = NSBundle.mainBundle().URLForResource("pushButton", withExtension: "mp3")!
    static let pushButtonPlayer = AVAudioPlayer(contentsOfURL: pushButtonUrl, error: nil)
    
    static let switchButtonUrl = NSBundle.mainBundle().URLForResource("switchButton", withExtension: "mp3")!
    static let switchButtonPlayer = AVAudioPlayer(contentsOfURL: switchButtonUrl, error: nil)
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchButton() {
        runAction(SKAction.playSoundFileNamed("switchButton.mp3", waitForCompletion: false))
    }
    
    static func switchButton() {
        switchButtonPlayer.play()
    }
    
    static func pushButton() {
        pushButtonPlayer.play()
    }
}