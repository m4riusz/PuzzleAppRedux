//
//  UICollectionViewCellExtension.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    class func reusableIdentifier() -> String {
        return String(describing: self)
    }
}
