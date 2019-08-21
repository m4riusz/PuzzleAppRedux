//
//  PuzzleMap.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import UIKit

struct PuzzleMap {
    enum EmptySpace {
        case top
        case left
        case right
        case bottom
        case none
    }
    
    let numberOfRows: Int
    let numberOfColumns: Int
    private var map: [[Int]]
    private var images: [[UIImage]] = []
    
    init(numberOfRows: Int, numberOfColumns: Int) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        self.map = Array(0..<numberOfRows * numberOfColumns).chunks(numberOfColumns)
        self.setImage(.image(.demoImage))
    }
    
    func printMap() {
        self.map.forEach { row in
            print(row)
        }
    }
    
    func itemAt(row: Int, column: Int) -> Int {
        return self.map[row][column]
    }
    
    func imageAt(row: Int, column: Int) -> UIImage {
        let mapItemNumber = self.itemAt(row: row, column: column)
        guard mapItemNumber != 0 else {
            return UIImage()
        }
        return self.images.reduce([UIImage](), { $0 + $1 })[mapItemNumber]
    }
    
    mutating func setImage(_ image: UIImage) {
        let size = image.size
        let imageWidth = size.width / CGFloat(self.numberOfColumns)
        let imageHeight = size.height / CGFloat(self.numberOfRows)
        let scale = image.scale
        
        self.images = []
        for rowIndex in 0..<self.numberOfRows {
            var columnImages: [UIImage] = []
            for columnIndex in 0..<self.numberOfColumns {
                let rect = CGRect(x: imageWidth * CGFloat(columnIndex) * scale,
                                  y: imageHeight * CGFloat(rowIndex) * scale,
                                  width: imageWidth * scale,
                                  height: imageHeight * scale)
                columnImages.append(UIImage(cgImage: image.cgImage!.cropping(to: rect)!))
            }
            self.images.append(columnImages)
        }
    }
    
    mutating func shuffleMap() {
        self.map = self.map
            .reduce([Int](), { $0 + $1 })
            .shuffled()
            .chunks(self.numberOfColumns)
    }
    
    mutating func click(_ item: Int) {
        guard item > 0 && item < self.numberOfRows * self.numberOfColumns else {
            return
        }
        for rowIndex in 0..<self.numberOfRows {
            for columnIndex in 0..<self.numberOfColumns {
                if self.map[rowIndex][columnIndex] == item {
                    switch self.isNearEmptySpace(rowIndex: rowIndex, columnIndex: columnIndex) {
                    case .left:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex][columnIndex - 1] = item
                    case .right:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex][columnIndex + 1] = item
                    case .top:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex - 1][columnIndex] = item
                    case .bottom:
                        self.map[rowIndex][columnIndex] = 0
                        self.map[rowIndex + 1][columnIndex] = item
                    case .none:
                        return
                    }
                    guard self.isSolved() else {
                        return
                    }
                    print("You have won the game!")
                    return
                }
            }
        }
        
    }
    
    private func isNearEmptySpace(rowIndex: Int, columnIndex: Int) -> EmptySpace {
        guard rowIndex < self.numberOfRows && rowIndex >= 0 && columnIndex < self.numberOfColumns && columnIndex >= 0 else {
            return .none
        }
        if columnIndex + 1 < self.numberOfColumns && self.map[rowIndex][columnIndex + 1] == 0 {
            return .right
        }
        if columnIndex - 1 >= 0 && self.map[rowIndex][columnIndex - 1] == 0 {
            return .left
        }
        if rowIndex + 1 < self.numberOfRows && self.map[rowIndex + 1][columnIndex] == 0 {
            return .bottom
        }
        if rowIndex - 1 >= 0 && self.map[rowIndex - 1][columnIndex] == 0 {
            return .top
        }
        return .none
    }
    
    private func isSolved() -> Bool {
        return self.map.reduce([Int](), { $0 + $1 }) == (0..<self.numberOfRows * self.numberOfColumns).map { $0 }
    }
}
