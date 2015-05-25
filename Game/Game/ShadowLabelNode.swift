//
//  ShadowLabel.swift
//  Game
//
//  Created by Yuriy Rebryk on 18/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class ShadowLabelNode: SKLabelNode {
    private var shadowLabel: SKLabelNode
    private var settings: ShadowLabelViewSettings
    
    var offsetX: CGFloat = 0 {
        willSet(newOffsetX) {
            shadowLabel.position.x = newOffsetX
        }
    }
    var offsetY: CGFloat = 0 {
        willSet(newOffsetY) {
            shadowLabel.position.y = newOffsetY
        }
    }
    
    init(settings: ShadowLabelViewSettings) {
        self.settings = settings
        offsetX = settings.offsetX
        offsetY = settings.offsetY
        
        shadowLabel = SKLabelNode()
        shadowLabel.fontSize = settings.fontSize
        shadowLabel.fontName = settings.fontName
        shadowLabel.fontColor = settings.shadowFontFirstColor
        shadowLabel.position = CGPoint(x: offsetX, y: offsetY)
        shadowLabel.zPosition = -2
        
        super.init()
        fontSize = settings.fontSize
        fontName = settings.fontName
        fontColor = settings.fontFirstColor
        addChild(shadowLabel)
    }
    
    func setFirstView() {
        fontColor = settings.fontFirstColor
        shadowLabel.fontColor = settings.shadowFontFirstColor
    }
    
    func setSecondView() {
        fontColor = settings.fontSecondColor
        shadowLabel.fontColor = settings.shadowFontSecondColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var text: String {
        willSet(newText) {
            shadowLabel.text = newText
        }
    }
    
    override var fontSize: CGFloat {
        willSet(newFontSize) {
            shadowLabel.fontSize = newFontSize
        }
    }
    
    override var fontName: String! {
        willSet(newFontName) {
            shadowLabel.fontName = newFontName
        }
    }
}
