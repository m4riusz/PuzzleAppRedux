//
//  UIImageExtension.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 09/08/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit

extension UIImage {
    static func image(_ image: Images) -> UIImage {
        return UIImage.init(named: image.rawValue)!
    }
}
