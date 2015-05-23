//
//  ButtonViewSettings.swift
//  Game
//
//  Created by Yuriy Rebryk on 18/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class ButtonViewSettings {
    var size: CGSize
    var shapeSettings: ShadowShapeViewSettings
    var labelSettings: ShadowLabelViewSettings
    
    init(size: CGSize, shapeSettings: ShadowShapeViewSettings, labelSettings: ShadowLabelViewSettings) {
        self.size = size
        self.shapeSettings = shapeSettings
        self.labelSettings = labelSettings
    }
}

class ShadowShapeViewSettings {
    var offsetX: CGFloat
    var offsetY: CGFloat
    var fillFirstColor: NSColor
    var fillSecondColor: NSColor
    var strokeFirstColor: NSColor
    var strokeSecondColor: NSColor
    var shadowStrokeFirstColor: NSColor
    var shadowStrokeSecondColor: NSColor
    
    init(fillFirstColor: NSColor, fillSecondColor: NSColor, strokeFirstColor: NSColor, strokeSecondColor: NSColor,
        shadowStrokeFirstColor: NSColor, shadowStrokeSecondColor: NSColor, offsetX: CGFloat = 0.0, offsetY: CGFloat = 0.0) {
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.fillFirstColor = fillFirstColor
        self.fillSecondColor = fillSecondColor
        self.strokeFirstColor = strokeFirstColor
        self.strokeSecondColor = strokeSecondColor
        self.shadowStrokeFirstColor = shadowStrokeFirstColor
        self.shadowStrokeSecondColor = shadowStrokeSecondColor
    }
}

class ShadowLabelViewSettings {
    var offsetX: CGFloat
    var offsetY: CGFloat
    var fontName: String
    var fontSize: CGFloat
    var fontFirstColor: NSColor
    var fontSecondColor: NSColor
    var shadowFontFirstColor: NSColor
    var shadowFontSecondColor: NSColor
    
    init(fontName: String, fontSize: CGFloat, fontFirstColor: NSColor, fontSecondColor: NSColor,
        shadowFontFirstColor: NSColor, shadowFontSecondColor: NSColor, offsetX: CGFloat = 0.0, offsetY: CGFloat = 0.0) {
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.fontName = fontName
        self.fontSize = fontSize
        self.fontFirstColor = fontFirstColor
        self.fontSecondColor = fontSecondColor
        self.shadowFontFirstColor = shadowFontFirstColor
        self.shadowFontSecondColor = shadowFontSecondColor
    }
}

struct Labels {
    static let LargeWithShadow = ShadowLabelViewSettings(fontName: "Chalkboard", fontSize: 140.0, fontFirstColor: Colors.yellow, fontSecondColor: Colors.black,
        shadowFontFirstColor: Colors.black, shadowFontSecondColor: Colors.black, offsetX: 5, offsetY: -4)
    
    static let MenuLargeWithShadow = ShadowLabelViewSettings(fontName: "Chalkboard", fontSize: 65.0, fontFirstColor: Colors.yellow, fontSecondColor: Colors.black,
        shadowFontFirstColor: Colors.black, shadowFontSecondColor: Colors.darkYellow, offsetX: 5, offsetY: -4)
    
    static let SmallWithShadow = ShadowLabelViewSettings(fontName: "Chalkboard", fontSize: 45.0, fontFirstColor: Colors.yellow, fontSecondColor: Colors.black,
        shadowFontFirstColor: Colors.black, shadowFontSecondColor: Colors.darkYellow, offsetX: 3, offsetY: -2)
    
    static let SmallWitoutShadow = ShadowLabelViewSettings(fontName: "Chalkboard", fontSize: 30.0, fontFirstColor: Colors.black, fontSecondColor: Colors.black,
        shadowFontFirstColor: Colors.transparent, shadowFontSecondColor: Colors.transparent)
    
    static let CompletedLevel = ShadowLabelViewSettings(fontName: "Chalkboard", fontSize: 45.0, fontFirstColor: Colors.lightGreen, fontSecondColor: Colors.black,
        shadowFontFirstColor: Colors.black, shadowFontSecondColor: Colors.darkGreen, offsetX: 3, offsetY: -2)
    
    static let Level = ShadowLabelViewSettings(fontName: "Chalkboard", fontSize: 45.0, fontFirstColor: Colors.yellow, fontSecondColor: Colors.black,
        shadowFontFirstColor: Colors.black, shadowFontSecondColor: Colors.darkYellow, offsetX: 3, offsetY: -2)
    
    static let LockedLevel = ShadowLabelViewSettings(fontName: "Chalkboard", fontSize: 45.0, fontFirstColor: Colors.lightGray, fontSecondColor: Colors.black,
        shadowFontFirstColor: Colors.black, shadowFontSecondColor: Colors.darkGray, offsetX: 3, offsetY: -2)
}

struct Shapes {
    static let CompletedLevel = ShadowShapeViewSettings(fillFirstColor: Colors.transparentLightGreen, fillSecondColor: Colors.lightGreen,
        strokeFirstColor: Colors.lightGreen, strokeSecondColor: Colors.lightGreen, shadowStrokeFirstColor: Colors.black, shadowStrokeSecondColor: Colors.darkGreen, offsetX: 1, offsetY: -1)
    
    static let Level = ShadowShapeViewSettings(fillFirstColor: Colors.transparentYellow, fillSecondColor: Colors.yellow,
        strokeFirstColor: Colors.yellow, strokeSecondColor: Colors.yellow, shadowStrokeFirstColor: Colors.black, shadowStrokeSecondColor: Colors.darkYellow, offsetX: 1, offsetY: -1)
    
    static let LockedLevel = ShadowShapeViewSettings(fillFirstColor: Colors.transparentLightGray, fillSecondColor: Colors.lightGray,
        strokeFirstColor: Colors.lightGray, strokeSecondColor: Colors.lightGray, shadowStrokeFirstColor: Colors.black, shadowStrokeSecondColor: Colors.darkGray, offsetX: 1, offsetY: -1)
    
    static let WithShadow = ShadowShapeViewSettings(fillFirstColor: Colors.transparentYellow, fillSecondColor: Colors.yellow,
        strokeFirstColor: Colors.yellow, strokeSecondColor: Colors.yellow, shadowStrokeFirstColor: Colors.black, shadowStrokeSecondColor: Colors.black, offsetX: 1, offsetY: -1)
    
    static let WithoutShadow = ShadowShapeViewSettings(fillFirstColor: Colors.white, fillSecondColor: Colors.lightGreen,
        strokeFirstColor: Colors.black, strokeSecondColor: Colors.black, shadowStrokeFirstColor: Colors.transparent, shadowStrokeSecondColor: Colors.transparent)
}

struct Buttons {
    static let WithShadow = ButtonViewSettings(size: CGSize(width: 200, height: 70), shapeSettings: Shapes.WithShadow, labelSettings: Labels.SmallWithShadow)
    
    static let WideWithShadow = ButtonViewSettings(size: CGSize(width: 420, height: 70), shapeSettings: Shapes.WithShadow, labelSettings: Labels.SmallWithShadow)
    
    static let LargeWithShadow = ButtonViewSettings(size: CGSize(width: 360, height: 110), shapeSettings: Shapes.WithShadow, labelSettings: Labels.MenuLargeWithShadow)
    
    static let WithoutShadow = ButtonViewSettings(size: CGSize(width: 280, height: 80), shapeSettings: Shapes.WithoutShadow, labelSettings: Labels.SmallWitoutShadow)
    
    static let CompletedLevel = ButtonViewSettings(size: CGSize(width: 120, height: 120), shapeSettings: Shapes.CompletedLevel, labelSettings: Labels.CompletedLevel)
    
    static let Level = ButtonViewSettings(size: CGSize(width: 120, height: 120), shapeSettings: Shapes.Level, labelSettings: Labels.Level)
    
    static let LockedLevel = ButtonViewSettings(size: CGSize(width: 120, height: 120), shapeSettings: Shapes.LockedLevel, labelSettings: Labels.LockedLevel)
}