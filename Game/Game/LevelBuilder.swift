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
    private static let wallThickness: CGFloat = 1
    
    static func buildWalls(world: SKNode, size: CGSize) {
        world.addChild(Wall(size: CGSize(width: size.width, height: wallThickness), position: CGPoint(x: 0, y: 0)))
        world.addChild(Wall(size: CGSize(width: size.width, height: wallThickness), position: CGPoint(x: 0, y: size.height - wallThickness)))
        world.addChild(Wall(size: CGSize(width: wallThickness, height: size.height), position: CGPoint(x: 0, y: 0)))
        world.addChild(Wall(size: CGSize(width: wallThickness, height: size.height), position: CGPoint(x: size.width - wallThickness, y: 0)))
    }
    
    static func loadObjects(path: String, level: GameScene) {
        var world = level.world
        var camera = level.camera
        var unit = level.unit
        
        let reader = Reader(path: path)
        
        while let type = reader.readWord() {
            switch type {
            case "World":
                let size = reader.readSize()
                camera?.worldSize = size
                LevelBuilder.buildWalls(world!, size: size)
            case "Fixed", "Dynamic":
                var shape = reader.readWord()!
                var block: Block? = nil
                switch shape {
                case "Block":
                    if type == "Fixed" {
                        block = Block(size: reader.readSize(), position: reader.readPosition(), colorIndex: reader.readInt())
                    } else {
                        block = ActiveBlock(size: reader.readSize(), position: reader.readPosition(), colorIndex: reader.readInt())
                    }
                case "Circle":
                    if type == "Fixed" {
                        block = Block(radius: CGFloat(reader.readDouble()), position: reader.readPosition(), colorIndex: reader.readInt())
                    } else {
                        block = ActiveBlock(radius: CGFloat(reader.readDouble()), position: reader.readPosition(), colorIndex: reader.readInt())
                    }
                default:
                    break
                }
                level.incColorCount(block!.colorIndex)
                while let action = reader.readAction() {
                    block!.runAction(action)
                }
                world?.addChild(block!)
            case "Challenge":
                var block = Block(size: reader.readSize(), position: reader.readPosition(), colorIndex: reader.readInt())
                var challenge = Challenge(size: reader.readSize(), position: reader.readPosition(), attention: reader.readInt(), message: reader.readMessage(), object: block as SKNode, action: reader.readAction()!)
                challenge.scen = level
                world!.addChild(block)
                world!.addChild(challenge)
            case "Camera":
                camera = Camera(position: reader.readPosition())
                world!.addChild(camera!)
            case "Unit":
                unit = Unit(position: reader.readPosition())
                world!.addChild(unit!)
            case "BlackHole":
                var blackHole = BlackHole(size: reader.readInt(), position: reader.readPosition())
                world!.addChild(blackHole)
            default :
                break
            }
        }

    }
}