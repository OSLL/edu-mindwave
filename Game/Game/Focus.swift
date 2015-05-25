//
//  Focus.swift
//  Game
//
//  Created by Yuriy Rebryk on 21/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation
import SpriteKit

class Focus {
    var row: Int
    var col: Int
    var buttons: Array<Array<Button>>
    
    init(buttons: Array<Array<Button>>, row: Int, col: Int) {
        self.row = row
        self.col = col
        self.buttons = buttons
        buttons[row][col].mark()
    }
    
    func activate() {
        buttons[row][col].activate()
    }
    
    func moveUp() -> Bool {
        let oldRow = row
        buttons[row][col].unmark()
        let rowsCount = count(buttons)
        do {
            row = (row + rowsCount - 1) % rowsCount
        } while count(buttons[row]) <= col || buttons[row][col].hidden
        buttons[row][col].mark()
        return row != oldRow
    }
    
    func moveDown() -> Bool {
        let oldRow = row
        buttons[row][col].unmark()
        let rowsCount = count(buttons)
        do {
            row = (row + 1) % rowsCount
        } while count(buttons[row]) <= col || buttons[row][col].hidden
        buttons[row][col].mark()
        return row != oldRow
    }
    
    func moveLeft() -> Bool {
        let oldCol = col
        buttons[row][col].unmark()
        let colsCount = count(buttons[row])
        col = (col + colsCount - 1) % colsCount
        buttons[row][col].mark()
        return col != oldCol
    }
    
    func moveRight() -> Bool {
        let oldCol = col
        buttons[row][col].unmark()
        let colsCount = count(buttons[row])
        col = (col + 1) % colsCount
        buttons[row][col].mark()
        return col != oldCol
    }
    
    func reset() {
        buttons[row][col].unmark()
        row = 0
        col = 0
        buttons[row][col].mark()
    }
}