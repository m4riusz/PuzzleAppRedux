//
//  PuzzleMap.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation

struct PuzzleMap {
    enum EmptySpace {
        case top
        case left
        case right
        case bottom
        case none
    }
    
    let row: Int
    let column: Int
    fileprivate var map: [[Int]]
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        self.map = Array(0..<row * column).chunks(column)
    }
    
    func printMap() {
        self.map.forEach { row in
            print(row)
        }
    }
    
    fileprivate mutating func shuffleMap() {
        self.map = self.map
            .reduce([Int](), { $0 + $1})
            .shuffled()
            .chunks(self.column)
    }
    
    mutating func click(_ item: Int) {
        guard item > 0 && item < self.row * self.column else {
            return
        }
        for rowIndex in 0..<self.row {
            
            for columnIndex in 0..<self.column {
                if self.map[rowIndex][columnIndex] == item {
                    switch self.isNearEmptySpace(rowIndex: rowIndex, columnIndex: columnIndex) {
                    case .left:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex][columnIndex - 1] = item
                        return
                    case .right:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex][columnIndex + 1] = item
                        return
                    case .top:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex - 1][columnIndex] = item
                        return
                    case .bottom:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex + 1][columnIndex] = item
                        return
                    case .none:
                        return
                    }
                }
            }
        }
    }
    
    fileprivate func isNearEmptySpace(rowIndex: Int, columnIndex: Int) -> EmptySpace {
        guard rowIndex < self.row && rowIndex >= 0 && columnIndex < self.column && columnIndex >= 0 else {
            return .none
        }
        if columnIndex + 1 < self.column && self.map[rowIndex][columnIndex + 1] == 0 {
            return .right
        }
        if columnIndex - 1 >= 0 && self.map[rowIndex][columnIndex - 1] == 0 {
            return .left
        }
        if rowIndex + 1 < self.row && self.map[rowIndex + 1][columnIndex] == 0 {
            return .bottom
        }
        if rowIndex - 1 >= 0 && self.map[rowIndex - 1][columnIndex] == 0 {
            return .top
        }
        return .none
    }
}
