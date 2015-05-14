//
//  InfoDisplay.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class InfoDisplay {
    private var meditation: SKLabelNode?
    private var meditationValue: SKLabelNode?
    
    private var attention: SKLabelNode?
    private var attentionValue: SKLabelNode?
    
    private var time: SKLabelNode?
    private var timeValue: SKLabelNode?
    
    private var textValue: SKLabelNode?
    
    private func timeToString(var time: Double) -> String {
        var minutes = floor(time / 60)
        var seconds = round(time - 60 * minutes)
        
        var minutesStr = toString(Int(minutes))
        if count(minutesStr) < 2 {
            minutesStr = "0" + minutesStr;
        }
        
        var secondsStr = toString(Int(seconds))
        if count(secondsStr) < 2 {
            secondsStr = "0" + secondsStr;
        }
        
        return minutesStr + ":" + secondsStr
    }
    
    private func setStyle(var label: SKLabelNode) {
        label.fontSize = 30
        label.fontColor = NSColor(red: 250/255, green: 30/255, blue: 30/255, alpha: 255/255)
    }
    
    private func setupMeditation() {
        meditation = SKLabelNode(text: "Meditation:")
        setStyle(meditation!)
        meditation!.position = CGPoint(x: -640, y: 380)
        meditation!.zPosition = 1
        
        meditationValue = SKLabelNode(text: "100")
        setStyle(meditationValue!)
        meditationValue!.position = CGPoint(x: -540, y: 380)
        meditationValue!.zPosition = 1
    }
    
    private func setupAttention() {
        attention = SKLabelNode(text: "Attention:")
        setStyle(attention!)
        attention!.position = CGPoint(x: -650, y: 410)
        attention!.zPosition = 1
        
        attentionValue = SKLabelNode(text: "100")
        setStyle(attentionValue!)
        attentionValue!.position = CGPoint(x: -540, y: 410)
        attentionValue!.zPosition = 1
    }
    
    private func setupTime() {
        time = SKLabelNode(text: "Time:")
        setStyle(time!)
        time!.position = CGPoint(x: 465, y: 400)
        time!.zPosition = 1
        time!.fontSize = 50
        
        timeValue = SKLabelNode()
        setStyle(timeValue!)
        timeValue!.position = CGPoint(x: 620, y: 400)
        timeValue!.zPosition = 1
        timeValue!.fontSize = 50
    }
    
    private func setupText() {
        textValue = SKLabelNode()
        setStyle(textValue!)
        textValue!.position = CGPoint(x: 0, y: 0)
        textValue!.zPosition = 1
        textValue!.fontSize = 130
    }
    
    func setMeditation(var value: Int) {
        meditationValue?.text = toString(value)
    }
    
    func setAttention(var value: Int) {
        attentionValue?.text = toString(value)
    }
    
    func setTime(var time: Double) {
        timeValue?.text = timeToString(time)
    }
    
    func setText(var text: String) {
        textValue?.text = text
    }
    
    init(var world: SKNode) {
        setupMeditation()
        setupAttention()
        setupTime()
        setupText()
        
        world.addChild(meditation!)
        world.addChild(meditationValue!)
        world.addChild(attention!)
        world.addChild(attentionValue!)
        world.addChild(time!)
        world.addChild(timeValue!)
        world.addChild(textValue!)
    }
}
