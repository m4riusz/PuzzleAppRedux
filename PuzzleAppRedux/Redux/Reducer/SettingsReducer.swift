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
    var state = state ?? SettingState(minWidth: 2,
                                      currentWidth: 2,
                                      maxWidth: 5,
                                      minHeight: 2,
                                      currentHeight: 2,
                                      maxHeight: 5)
    switch action {
    case let action as SettingsAction.ChangeMapWidth:
        state.currentWidth = action.newMapWidth
    case let action as SettingsAction.ChangeMapHeight:
        state.currentHeight = action.newMapHeight
    default:
        break
    }
    return state
}
