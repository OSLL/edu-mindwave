//
//  Focus.swift
//  Game
//
//  Created by Yuriy Rebryk on 21/05/15.
//  Copyright (c) 2015 Yuriy Rebryk. All rights reserved.
//

import Foundation

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
    
    func moveUp() {
        buttons[row][col].unmark()
        let rowsCount = count(buttons)
        do {
            row = (row + rowsCount - 1) % rowsCount
        } while count(buttons[row]) <= col || buttons[row][col].hidden
        buttons[row][col].mark()
    }
    
    func moveDown() {
        buttons[row][col].unmark()
        let rowsCount = count(buttons)
        do {
            row = (row + 1) % rowsCount
        } while count(buttons[row]) <= col || buttons[row][col].hidden
        buttons[row][col].mark()
    }
    
    func moveLeft() {
        buttons[row][col].unmark()
        let colsCount = count(buttons[row])
        col = (col + colsCount - 1) % colsCount
        buttons[row][col].mark()
    }
    
    func moveRight() {
        buttons[row][col].unmark()
        let colsCount = count(buttons[row])
        col = (col + 1) % colsCount
        buttons[row][col].mark()
    }
    
    func reset() {
        buttons[row][col].unmark()
        row = 0
        col = 0
        buttons[row][col].mark()
    }
}