//
//  PuzzleController.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit
import ReSwift
import SnapKit

class PuzzleController: UIViewController {
    
    fileprivate var flowLayout: FlowLayout!
    fileprivate var collectionView: UICollectionView!
    fileprivate var sections: [[PuzzleItem]] = []
    
    override func viewDidLoad() {
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
    
    fileprivate func initialize() {
        self.view.backgroundColor = .white
        self.initNavigationBarItems()
        self.initFlowLayout()
        self.initCollectionView()
    }
    
    fileprivate func initNavigationBarItems() {
        let optionsButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.onOptionsButton))
        let shuffleButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.onShuffleButton))
        self.navigationItem.rightBarButtonItems = [optionsButtonItem, shuffleButtonItem]
    }
    
    fileprivate func initFlowLayout() {
        self.flowLayout = FlowLayout(numberOfRows: 2, numberOfColumns: 2, spacing: 4)
    }
    
    fileprivate func initCollectionView() {
        self.collectionView = UICollectionView(self.flowLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isScrollEnabled = false
        self.collectionView.backgroundColor = .clear
        self.collectionView.registerCell(PuzzleCell.self)
        self.view.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc fileprivate func onShuffleButton() {
        store.dispatch(PuzzleAction.Shuffle())
    }
    
    @objc fileprivate func onOptionsButton() {
        self.present(UINavigationController(rootViewController: SettingsController()), animated: true)
    }
}

extension PuzzleController: StoreSubscriber {
    func newState(state: AppState) {
        self.flowLayout.numberOfRows = state.currentNumberOfRows
        self.flowLayout.numberOfColumns = state.currentNumberOfColumns
        self.sections = state.map.toPuzzleItem()
        self.collectionView.reloadData()
    }
}

extension PuzzleController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(PuzzleCell.self, indexPath: indexPath)
        cell.updateForItem(self.sections[indexPath.section][indexPath.row])
        return cell
    }
}

extension PuzzleController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.sections[indexPath.section][indexPath.row].number
        store.dispatch(PuzzleAction.MoveItem(item: item))
    }
}
