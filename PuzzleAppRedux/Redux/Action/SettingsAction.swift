//
//  SettingsAction.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import ReSwift

struct SettingsAction {
    
    struct ChangeMapWidth: Action {
        let newMapWidth: Int
    }
    
    struct ChangeMapHeight: Action {
        let newMapHeight: Int
    }
}
