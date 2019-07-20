//
//  AppState.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var minNumberOfColumns: Int
    var currentNumberOfColumns: Int
    var maxNumberOfColumns: Int
    var minNumberOfRows: Int
    var currentNumberOfRows: Int
    var maxNumberOfRows: Int
    
    var map: PuzzleMap
}
