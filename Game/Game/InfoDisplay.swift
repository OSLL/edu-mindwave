//
//  InfoDisplay.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit



class InfoDisplay: SKNode {
    var appDel: AppDelegate?
    private let size: CGSize
    
    private var meditation: SKLabelNode?
    private var meditationValue: SKLabelNode?
    private var attention: SKLabelNode?
    private var attentionValue: SKLabelNode?
    private var time: SKLabelNode?
    private var timeValue: SKLabelNode?
    private var textValue: ShadowLabelNode?
    
    private let meditationPosition: CGPoint
    private let meditationValuePosition: CGPoint
    private let attentionPosition: CGPoint
    private let attentionValuePosition: CGPoint
    private let timePosition: CGPoint
    private let timeValuePosition: CGPoint
    
    private var restartButton: Button
    private var menuButton: Button
    
    private func timeToString(time: Double) -> String {
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
    
    private func setStyle(label: SKLabelNode?) {
        label?.fontSize = 28
        label?.fontName = "Chalkboard"
        label?.fontColor = NSColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 255/255)
        attention?.zPosition = 1
    }
    
    private func setupMeditation() {
        meditation = SKLabelNode(text: "Meditation:")
        setStyle(meditation)
        setLabelPosition(meditation, position: meditationPosition)
        
        meditationValue = SKLabelNode()
        setStyle(meditationValue)
        setMeditation(83)
    }
    
    private func setupAttention() {
        attention = SKLabelNode(text: "Attention:")
        setStyle(attention)
        setLabelPosition(attention, position: attentionPosition)
        
        attentionValue = SKLabelNode()
        setStyle(attentionValue)
        setAttention(100)
    }
    
    private func setupTime() {
        time = SKLabelNode(text: "Time:")
        setStyle(time)
        time?.fontSize = 50
        setLabelPosition(time, position: timePosition)
        
        
        timeValue = SKLabelNode()
        setStyle(timeValue)
        timeValue?.fontSize = 50
    }
    
    private func setupText() {
        textValue = ShadowLabelNode(settings: Labels.LargeWithShadow)
        textValue?.position = CGPoint(x: 0, y: -textValue!.frame.size.height / 2.0)
        textValue?.zPosition = 1
        textValue?.hidden = true
    }
    
    func setLabelPosition(labelNode: SKLabelNode?, position: CGPoint, left: Bool = true) {
        if let label = labelNode {
            if left == true {
                label.position = CGPoint(x: position.x + label.frame.width / 2, y: position.y)
            } else {
                label.position = CGPoint(x: 0, y: position.y)
            }
        }
    }
    
    func setMeditation(value: Int) {
        meditationValue?.text = toString(value)
        setLabelPosition(meditationValue, position: meditationValuePosition)
    }
    
    func setAttention(value: Int) {
        attentionValue?.text = toString(value)
        setLabelPosition(attentionValue, position: attentionValuePosition)
    }
    
    func setTime(time: Double) {
        timeValue?.text = timeToString(time)
        setLabelPosition(timeValue, position: timeValuePosition)
    }
    
    func showText(text: String, fontColor: NSColor = NSColor.whiteColor()) {
        textValue?.fontColor = fontColor
        textValue?.text = text
        textValue?.hidden = false
    }
    
    func hideText() {
        textValue?.hidden = true
    }
    
    func showPauseFrame() {
        showText("PAUSE", fontColor: Colors.yellow)
        restartButton.hidden = false
        menuButton.hidden = false
    }
    
    func hidePauseFrame() {
        hideText()
        restartButton.hidden = true
        menuButton.hidden = true
    }
    
    init(size: CGSize) {
        self.size = size
        
        // set cnostant positions
        attentionPosition = CGPoint(x: -size.width / 2 + 15, y: size.height / 2 - 40)
        attentionValuePosition = CGPoint(x: -size.width / 2 + 170, y: size.height / 2 - 40)
        meditationPosition = CGPoint(x: -size.width / 2 + 15, y: size.height / 2 - 75)
        meditationValuePosition = CGPoint(x: -size.width / 2 + 170, y: size.height / 2 - 75)
        timePosition = CGPoint(x: size.width / 2 - 285, y: size.height / 2 - 57)
        timeValuePosition = CGPoint(x: size.width / 2 - 150, y: size.height / 2 - 57)
        
        
        // setup buttons
        restartButton = Button(text: "Restart", settings: Buttons.WithShadow) {}
        restartButton.hidden = true
        restartButton.position = CGPoint(x: -restartButton.size.width - 10, y: -restartButton.size.height - 40)
        
        menuButton = Button(text: "Menu", settings: Buttons.WithShadow) {}
        menuButton.hidden = true
        menuButton.position = CGPoint(x: 10, y: -menuButton.size.height - 40)
        
        super.init()
        
        restartButton.action = { (self.scene as! GameScene).restart() }
        menuButton.action = { (self.scene as! GameScene).loadLevels() }
        
        // setup labels
        setupMeditation()
        setupAttention()
        setupTime()
        setupText()
        
        // add children
        addChild(meditation!)
        addChild(meditationValue!)
        addChild(attention!)
        addChild(attentionValue!)
        addChild(time!)
        addChild(timeValue!)
        addChild(textValue!)
        addChild(restartButton)
        addChild(menuButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
