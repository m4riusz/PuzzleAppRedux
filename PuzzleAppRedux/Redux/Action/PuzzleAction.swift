//
//  PuzzleAction.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import ReSwift

struct PuzzleAction {
    
    struct MoveItem: Action {
        let item: Int
    }
    
    struct Shuffle: Action {
        
    }
}
