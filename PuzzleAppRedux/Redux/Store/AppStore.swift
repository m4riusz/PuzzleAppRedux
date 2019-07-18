//
//  AppStore.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import ReSwift

let store: Store<AppState> = Store<AppState>(
    reducer: appReducer,
    state: nil
)
