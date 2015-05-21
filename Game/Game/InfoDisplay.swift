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
    private let size: CGSize
    
    private var meditation: SKLabelNode?
    private var meditationValue: SKLabelNode?
    private var attention: SKLabelNode?
    private var attentionValue: SKLabelNode?
    private var time: SKLabelNode?
    private var timeValue: SKLabelNode?
    private var bestTime: SKLabelNode?
    private var bestTimeValue: SKLabelNode?
    private var textValue: ShadowLabelNode?
    
    private let meditationPosition: CGPoint
    private let meditationValuePosition: CGPoint
    private let attentionPosition: CGPoint
    private let attentionValuePosition: CGPoint
    private let timePosition: CGPoint
    private let timeValuePosition: CGPoint
    private let bestTimePosition: CGPoint
    private let bestTimeValuePosition: CGPoint
    
    private var restartButton: Button
    private var menuButton: Button
    private var nextLevelButton: Button
    
    private var shadow: SKShapeNode
    
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
        
        bestTime = SKLabelNode(text: "Best:")
        setStyle(bestTime)
        bestTime?.fontSize = 40
        setLabelPosition(bestTime, position: bestTimePosition)
        
        bestTimeValue = SKLabelNode()
        setStyle(bestTimeValue)
        bestTimeValue?.fontSize = 40
    }
    
    private func setupText() {
        textValue = ShadowLabelNode(settings: Labels.LargeWithShadow)
        textValue?.position = CGPoint(x: 0, y: -textValue!.frame.size.height / 2.0 + 30)
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
    
    func setBestTime(bestTime: Double?) {
        bestTimeValue?.text = (bestTime != nil ? timeToString(bestTime!) : "--:--:--")
        setLabelPosition(bestTimeValue, position: bestTimeValuePosition)
    }
    
    func showText(text: String, fontColor: NSColor = NSColor.whiteColor()) {
        textValue?.fontColor = fontColor
        textValue?.text = text
        textValue?.hidden = false
    }
    
    func hideText() {
        textValue?.hidden = true
    }
    
    func showButtons() {
        restartButton.hidden = false
        menuButton.hidden = false
        if (self.scene as! GameScene).isNextLevelEnable() {
            nextLevelButton.hidden = false
        }
        shadow.hidden = false
    }
    
    func hideButtons() {
        restartButton.hidden = true
        menuButton.hidden = true
        nextLevelButton.hidden = true
        shadow.hidden = true
    }
    
    func showYouWin() {
        showText("YOU WIN", fontColor: Colors.yellow)
        showButtons()
    }
    
    func showYouLose() {
        showText("YOU LOSE", fontColor: Colors.yellow)
        showButtons()
    }
    
    func showPauseFrame() {
        showText("PAUSE", fontColor: Colors.yellow)
        showButtons()
    }
    
    func hidePauseFrame() {
        hideText()
        hideButtons()
    }
    
    init(size: CGSize) {
        self.size = size
        
        // set cnostant positions
        attentionPosition = CGPoint(x: -size.width / 2 + 15, y: size.height / 2 - 40)
        attentionValuePosition = CGPoint(x: -size.width / 2 + 170, y: size.height / 2 - 40)
        meditationPosition = CGPoint(x: -size.width / 2 + 15, y: size.height / 2 - 75)
        meditationValuePosition = CGPoint(x: -size.width / 2 + 170, y: size.height / 2 - 75)
        timePosition = CGPoint(x: size.width / 2 - 325, y: size.height / 2 - 57)
        timeValuePosition = CGPoint(x: size.width / 2 - 190, y: size.height / 2 - 57)
        bestTimePosition = CGPoint(x: size.width / 2 - 320, y: size.height / 2 - 97)
        bestTimeValuePosition = CGPoint(x: size.width / 2 - 190, y: size.height / 2 - 97)
        
        // shadow
        shadow = SKShapeNode(rect: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        shadow.fillColor = Colors.transparentBlack
        shadow.strokeColor = Colors.transparentBlack
        shadow.zPosition = 0
        shadow.hidden = true
        
        // setup buttons
        restartButton = Button(text: "Restart", settings: Buttons.WithShadow) {}
        restartButton.hidden = true
        restartButton.position = CGPoint(x: -restartButton.size.width - 10, y: -restartButton.size.height - 10)
        restartButton.zPosition = 1
        
        menuButton = Button(text: "Menu", settings: Buttons.WithShadow) {}
        menuButton.hidden = true
        menuButton.position = CGPoint(x: 10, y: -menuButton.size.height - 10)
        menuButton.zPosition = 1
        
        nextLevelButton = Button(text: "Next Level", settings: Buttons.WideWithShadow) {}
        nextLevelButton.hidden = true
        nextLevelButton.position = CGPoint(x: -nextLevelButton.size.width / 2.0, y: -nextLevelButton.size.height - 100)
        nextLevelButton.zPosition = 1
        
        super.init()
        
        restartButton.action = { (self.scene as! GameScene).restart() }
        menuButton.action = { (self.scene as! GameScene).loadLevels() }
        nextLevelButton.action = { (self.scene as! GameScene).loadNextLevel() }
        
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
        addChild(bestTime!)
        addChild(bestTimeValue!)
        addChild(textValue!)
        addChild(restartButton)
        addChild(menuButton)
        addChild(nextLevelButton)
        addChild(shadow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
