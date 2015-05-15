//
//  Camera.swift
//  Game
//
//  Created by Yuriy Rebryk on 06/04/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Camera: SKNode {
    private let FocusRadius: CGFloat = 300.0
    var worldSize: CGSize?
    
    init(position: CGPoint) {
        super.init()
        name = "camera"
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func apply() {
        if scene != nil || parent != nil {
            let cameraPositionInScene = scene!.convertPoint(position, fromNode: parent!)
            parent!.position.x -= cameraPositionInScene.x
            parent!.position.y -= cameraPositionInScene.y
        }
    }
    
    func move(position: CGPoint) {
        if worldSize == nil || scene == nil {
            return
        }
        //self.position = position
        
        let sceneSize = scene!.size
        if position.y < self.position.y {
            self.position.y = position.y
        }
        var dx = position.x - self.position.x
        var dy = position.y - self.position.y
        var distance = sqrt(dx * dx + dy * dy)
        if distance > FocusRadius {
            distance -= FocusRadius
            var angle = atan2(dy, dx)
            self.position.x += cos(angle) * distance
            self.position.y += sin(angle) * distance
        }
        self.position.x = min(max(self.position.x, sceneSize.width / 2), worldSize!.width - sceneSize.width / 2)
        self.position.y = min(max(self.position.y, sceneSize.height / 2), worldSize!.height - sceneSize.height / 2)
    }
}