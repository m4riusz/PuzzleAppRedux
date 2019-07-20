//
//  UIViewExtension.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit

enum BorderStyle {
    case smallRounded(color: UIColor)
}

extension UIView {
    
    func addBorder(_ borderStyle: BorderStyle) {
        switch borderStyle {
        case .smallRounded(let color):
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 10
            self.layer.borderColor = color.cgColor
        }
    }
}
