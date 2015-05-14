//
//  Protocols.swift
//  Game
//
//  Created by Yuriy Rebryk on 14/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

protocol Object {
    func beginContact(UInt32)
    func endContact(UInt32)
}

protocol ColorObject {
    var colorIndex: Int {get set}
}
