//
//  Screen.swift
//  Game
//
//  Created by Yuriy Rebryk on 19/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import SpriteKit

class Screen: SKScene {
    var appDel: AppDelegate?
    
    let slideAU = 4.0
    let slideJetBrains = 4.0
    let slideYuriys = 4.0
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        var shadow1 = SKSpriteNode(color: Colors.black, size: self.appDel!.skView!.frame.size)
        shadow1.zPosition = 1
        addChild(shadow1)
        
        var shadow2 = SKSpriteNode(color: Colors.black, size: CGSize(width: self.appDel!.skView!.frame.size.width, height: 260))
        shadow2.position.y = (shadow2.size.height - self.appDel!.skView!.frame.size.height) / 2.0
        shadow2.zPosition = 1
        shadow2.hidden = true
        addChild(shadow2)
        
        var background = SKSpriteNode()
        addChild(background)
        
        
        shadow1.runAction(SKAction.fadeAlphaTo(0.0, duration: 2.5))
        background.runAction(SKAction.sequence([
            SKAction.setTexture(SKTexture(imageNamed: "AcademicUniversity"), resize: true),
            SKAction.waitForDuration(slideAU),
            SKAction.runBlock {
                shadow2.hidden = false
                shadow2.runAction(SKAction.sequence([
                    SKAction.waitForDuration(1),
                    SKAction.fadeAlphaTo(0.0, duration: 2)
                    ]))
            },
            SKAction.setTexture(SKTexture(imageNamed: "JetBrains"), resize: true),
            SKAction.waitForDuration(slideJetBrains),
            SKAction.setTexture(SKTexture(imageNamed: "Yuriys"), resize: true),
            SKAction.waitForDuration(slideYuriys),
            SKAction.runBlock() { self.appDel!.loadMenu() }
            ]))
        
        appDel!.tryToConnectMindWave()
    }
};