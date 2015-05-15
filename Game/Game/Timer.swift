//
//  Timer.swift
//  Game
//
//  Created by Yuriy Rebryk on 15/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit
import Cocoa

class Timer {
    private var startTime: NSTimeInterval
    private var lastTime: NSTimeInterval
    
    init(startTime: NSTimeInterval) {
        self.startTime = startTime
        lastTime = startTime
    }
    
    func update(time: NSTimeInterval) {
        lastTime = time
    }
    
    var seconds: Double {
        return lastTime - startTime
    }
}