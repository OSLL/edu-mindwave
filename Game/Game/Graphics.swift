//
//  Graphics.swift
//  Game
//
//  Created by Yuriy Rebryk on 18/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

enum Shader: String {
    case Blue = "Blue"
    case Sky = "Sky"
}

class Graphics {
    static func makeGradient(node: SKNode, shaderType: Shader) -> SKNode {
        let shader = SKShader(fileNamed: shaderType.rawValue)
        let effectNode = SKEffectNode()
        effectNode.zPosition = -3
        effectNode.shader = shader
        effectNode.shouldEnableEffects = true
        effectNode.addChild(node)
        return effectNode
    }
}