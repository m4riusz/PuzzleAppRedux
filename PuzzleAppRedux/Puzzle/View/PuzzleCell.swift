//
//  PuzzleCell.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit

class PuzzleCell: UICollectionViewCell {
    
    fileprivate var titleLabel: UILabel!
    fileprivate var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    fileprivate func initialize() {
        self.addBorder(.smallRounded(color: .black))
        self.initTitleLabel()
        self.initImageView()
    }
    
    fileprivate func initTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        self.titleLabel.textColor = .darkGray
        self.titleLabel.textAlignment = .center
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func initImageView() {
        self.imageView = UIImageView()
        self.imageView.contentMode = .scaleToFill
        self.contentView.addSubview(self.imageView)
    
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateForItem(_ item: PuzzleItem) {
        self.titleLabel.text = "\(item.number)"
        self.imageView.image = item.image
    }
}
