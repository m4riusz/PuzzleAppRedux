//
//  ArrayExtension.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation

extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
