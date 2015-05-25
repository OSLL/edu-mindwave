//
//  Reader.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Reader {
    private var data: Array<String>
    private var wordsCount = 0
    private var cursor = 0
    
    init(path: String) {
        data = Array<String>()
        let text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        if text != nil {
            let lines = text!.componentsSeparatedByString("\n")
            for line in lines {
                let words = line.componentsSeparatedByString(" ")
                for word in words {
                    if count(word) > 0 {
                        data += [word]
                    }
                }
            }
        }
        wordsCount = count(data)
    }
    
    private func toInt(value: String) -> Int {
        return (value as NSString).integerValue
    }
    
    private func toDouble(value: String) -> Double {
        return (value as NSString).doubleValue
    }
    
    func readWord() -> String? {
        if cursor == wordsCount {
            return nil
        }
        return data[cursor++]
    }
    
    func readMessage(gap: Bool = true) -> String {
        if gap {
            ++cursor
        }
        return data[cursor++]
    }
    
    func readInt(gap: Bool = true) -> Int {
        if gap {
            ++cursor
        }
        return toInt(data[cursor++])
    }
    
    func readDouble(gap: Bool = true) -> Double {
        if gap {
            ++cursor
        }
        return toDouble(data[cursor++])
    }
    
    func readBool(gap: Bool = true) -> Bool {
        if gap {
            ++cursor
        }
        return data[cursor++] == "true" ? true : false
    }
    
    func readSize(gap: Bool = true) -> CGSize {
        if gap {
            ++cursor
        }
        return CGSize(width: toInt(data[cursor++]), height: toInt(data[cursor++]))
    }
    
    func readPosition(gap: Bool = true) -> CGPoint {
        if gap {
            ++cursor
        }
        return CGPoint(x: toInt(data[cursor++]), y: toInt(data[cursor++]))
    }
    
    func readAction() -> SKAction? {
        ++cursor;
        if data[cursor] == "nil" {
            return nil
        }
        var action: SKAction? = nil
        var type = data[cursor++]
        switch type {
            // exmaple: action: path points: 3 0 0 200 200 0 0 asOffset: true orientToPath: true duration: 3 count: -1
            case "path":
                var path = CGPathCreateMutable()
                var pointsCount = readInt()

                var point = readPosition(gap: false)
                CGPathMoveToPoint(path, nil, point.x, point.y)
                for var i = 1; i < pointsCount; ++i {
                    point = readPosition(gap: false)
                    CGPathAddLineToPoint(path, nil, point.x, point.y)
                }
                action = SKAction.followPath(path, asOffset: readBool(), orientToPath: readBool(), duration: Double(readInt()))
                var actionsCount = readInt()
                if actionsCount == -1 {
                    action = SKAction.repeatActionForever(action!)
                } else {
                    action = SKAction.repeatAction(action!, count: actionsCount)
                }

            // example: action: circle radius: 300 asOffset: false orientToPath: true duration: 3 count: 1
            case "circle":
                var radius = readInt()
                var path = CGPathCreateWithEllipseInRect(CGRect(x: readInt(), y: readInt(), width: 2 * radius, height: 2 * radius), nil)
                action = SKAction.followPath(path, asOffset: readBool(), orientToPath: readBool(), duration: readDouble())
                var actionsCount = readInt()
                if actionsCount == -1 {
                    action = SKAction.repeatActionForever(action!)
                } else {
                    action = SKAction.repeatAction(action!, count: actionsCount)
                }
            
            // example: action: rotateByAngle radians: 1 duration: 2 count: 1
            case "rotateByAngle":
                action = SKAction.rotateByAngle(CGFloat(readDouble()), duration: readDouble())
                var actionsCount = readInt()
                if actionsCount == -1 {
                    action = SKAction.repeatActionForever(action!)
                } else {
                    action = SKAction.repeatAction(action!, count: actionsCount)
                }
            
            // example: action: rotateToAngle radians: 1 duration: 2
            case "rotateToAngle":
                action = SKAction.rotateToAngle(CGFloat(readDouble()), duration: readDouble())
            default:
                return nil
        }
        return action
    }
}