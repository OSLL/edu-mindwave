//
//  LevelBuilder.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit
import Cocoa

class LevelBuilder {
    private static let wallThickness: CGFloat = 5
    
    static func buildWalls(world: SKNode, size: CGSize) {
        world.addChild(Wall(size: CGSize(width: size.width, height: wallThickness), position: CGPoint(x: 0, y: 0)))
        world.addChild(Wall(size: CGSize(width: size.width, height: wallThickness), position: CGPoint(x: 0, y: size.height - wallThickness)))
        world.addChild(Wall(size: CGSize(width: wallThickness, height: size.height), position: CGPoint(x: 0, y: 0)))
        world.addChild(Wall(size: CGSize(width: wallThickness, height: size.height), position: CGPoint(x: size.width - wallThickness, y: 0)))
    }
}