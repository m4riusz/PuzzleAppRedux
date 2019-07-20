//
//  FlowLayout.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    var numberOfRows: Int
    var numberOfColumns: Int
    let spacing: CGFloat
    
    init(numberOfRows: Int, numberOfColumns: Int, spacing: CGFloat) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        self.spacing = spacing
        super.init()
        
        self.minimumInteritemSpacing = spacing
        self.minimumLineSpacing = spacing
        self.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else {
            return
        }
        let size = collectionView.bounds
        let marginsAndInsetsColumns = self.sectionInset.left + self.sectionInset.right + self.minimumInteritemSpacing * CGFloat(self.numberOfColumns - 1)
        let marginsAndInsetsRows = self.sectionInset.top + self.sectionInset.bottom + self.minimumLineSpacing * CGFloat(self.numberOfRows - 1)
        let itemWidth = (size.width - marginsAndInsetsColumns) / CGFloat(self.numberOfColumns)
        let itemHeight = (size.height - marginsAndInsetsRows) / CGFloat(self.numberOfRows)
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
}
