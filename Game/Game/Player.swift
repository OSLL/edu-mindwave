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

class BackgroundPlayer: SKNode {
    let backgroundUrl = NSBundle.mainBundle().URLForResource("PurpleGamecube", withExtension: "mp3")!
    var player: AVAudioPlayer?
    
    override init() {
        super.init()
        player = AVAudioPlayer(contentsOfURL: backgroundUrl, error: nil)
        player?.numberOfLoops = -1
        player?.volume = 0.5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Player: SKNode {
    static let pushButtonUrl = NSBundle.mainBundle().URLForResource("PushButton", withExtension: "mp3")!
    static let pushButtonPlayer = AVAudioPlayer(contentsOfURL: pushButtonUrl, error: nil)
    
    static let switchButtonUrl = NSBundle.mainBundle().URLForResource("SwitchButton", withExtension: "mp3")!
    static let switchButtonPlayer = AVAudioPlayer(contentsOfURL: switchButtonUrl, error: nil)
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func jump() -> SKAction {
        return SKAction.playSoundFileNamed("Jump.mp3", waitForCompletion: false)
    }
    
    func switchButton() {
        runAction(SKAction.playSoundFileNamed("SwitchButton.mp3", waitForCompletion: false))
    }
    
    static func switchButton() {
        switchButtonPlayer.play()
    }
    
    static func pushButton() {
        pushButtonPlayer.play()
    }
}