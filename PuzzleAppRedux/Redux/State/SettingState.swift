//
//  SettingState.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import ReSwift

struct SettingState: StateType {
    var minWidth: Int
    var currentWidth: Int
    var maxWidth: Int
    var minHeight: Int
    var currentHeight: Int
    var maxHeight: Int
}
