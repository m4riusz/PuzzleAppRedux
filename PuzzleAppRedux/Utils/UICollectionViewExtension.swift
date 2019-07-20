//
//  UICollectionViewExtension.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    convenience init(_ flowLayout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: flowLayout)
    }
    
    func registerCell(_ cell: UICollectionViewCell.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.reusableIdentifier())
    }
    
    func registerHeader(_ header: UICollectionReusableView.Type) {
        self.register(header,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: String(describing: header))
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cell.reusableIdentifier(), for: indexPath) as! T
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_ header: UICollectionReusableView.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                     withReuseIdentifier: String(describing: header),
                                                     for: indexPath) as! T
    }
}
