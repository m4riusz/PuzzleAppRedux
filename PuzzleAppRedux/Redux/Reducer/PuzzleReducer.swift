//
//  PuzzleReducer.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import ReSwift

func puzzleReducer(action: Action, state: PuzzleState?) -> PuzzleState {
    var state = state ?? PuzzleState(map: PuzzleMap(row: 3, column: 3))
    switch action {
    case let action as PuzzleAction.MoveItem:
        state.map.click(action.item)
    case let action as PuzzleAction.Shuffle:
        state.map.shuffleMap()
    default:
        break
    }
    return state
}
