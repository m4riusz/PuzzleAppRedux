//
//  SettingsReducer.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import ReSwift

func settingsReducer(action: Action, state: SettingState?) -> SettingState {
    var state = state ?? SettingState(mapWidth: 1, mapHeight: 1)
    switch action {
    case let action as SettingsAction.ChangeMapWidth:
        state.mapWidth = action.newMapWidth
    case let action as SettingsAction.ChangeMapHeight:
        state.mapHeight = action.newMapHeight
    default:
        break
    }
    return state
}
