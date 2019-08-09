//
//  AppReducer.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState(minNumberOfColumns: 2,
                                  currentNumberOfColumns: 5,
                                  maxNumberOfColumns: 10,
                                  minNumberOfRows: 2,
                                  currentNumberOfRows: 5,
                                  maxNumberOfRows: 10,
                                  map: PuzzleMap(numberOfRows: 5, numberOfColumns: 5))
    
    switch action {
    case let action as SettingsAction.ChangeNumberOfColumns:
        state.currentNumberOfColumns = action.newNumberOfColumns
        state.map = PuzzleMap(numberOfRows: state.currentNumberOfRows,
                              numberOfColumns: state.currentNumberOfColumns)
    case let action as SettingsAction.ChangeNumberOfRows:
        state.currentNumberOfRows = action.newNumberOfRows
        state.map = PuzzleMap(numberOfRows: state.currentNumberOfRows,
                              numberOfColumns: state.currentNumberOfColumns)
    case let action as PuzzleAction.MoveItem:
        state.map.click(action.item)
    case _ as PuzzleAction.Shuffle:
        state.map.shuffleMap()
    default:
        break
    }
    return state
}
