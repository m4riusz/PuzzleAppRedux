//
//  PuzzleController.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 20/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit
import ReSwift

class PuzzleController: UIViewController {
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var shuffleButtonItem: UIBarButtonItem!
    fileprivate var sections: [[PuzzleItem]] = []
    
    override func viewDidLoad() {
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.subscribe(self) { appState  in
            return appState.select { $0.puzzleState }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
    
    fileprivate func initialize() {
        self.view.backgroundColor = .white
        self.initNavigationBarItems()
        self.initCollectionView()
    }
    
    fileprivate func initNavigationBarItems() {
        self.shuffleButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.onShuffleButton))
        self.navigationItem.rightBarButtonItem = self.shuffleButtonItem
    }
    
    fileprivate func initCollectionView() {
        self.collectionView = UICollectionView(UICollectionViewFlowLayout())
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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
}

extension PuzzleController: StoreSubscriber {
    func newState(state: PuzzleState) {
        let item = state.map
        var items: [[PuzzleItem]] = []
        for row in 0..<item.row {
            var puzzleItems: [PuzzleItem] = []
            for column in 0..<item.column {
                puzzleItems.append(PuzzleItem(number: item.itemAt(row: row, column: column)))
            }
            items.append(puzzleItems)
        }
        
        self.sections = items
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
