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
    private var timer: NSTimeInterval
    private var startTime: NSTimeInterval
    private var paused = false
    
    init(startTime: NSTimeInterval) {
        self.startTime = startTime
        timer = NSTimeInterval(0)
    }
    
    func pause() {
        paused = true
    }
    
    func start() {
        paused = false
    }
    
    func update(time: NSTimeInterval) {
        if paused == false {
            timer += time - startTime
        }
        startTime = time
    }
    
    var seconds: Double {
        return timer
    }
}

func toLen2(string: String) -> String {
    if count(string) < 2 {
        return "0" + string
    }
    return string
}

func timeToString(time: Double) -> String {
    var minutes = floor(time / 60)
    var seconds = floor(time % 60)
    var milliseconds = floor(100 * (time % 1))
    
    return toString(Int(minutes)) + ":" + toLen2(toString(Int(seconds))) + ":"
        + toLen2(toString(Int(milliseconds)))
}