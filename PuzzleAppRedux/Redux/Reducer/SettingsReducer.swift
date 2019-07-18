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
    return SettingState(mapWidth: 1, mapHeight: 2)
}
