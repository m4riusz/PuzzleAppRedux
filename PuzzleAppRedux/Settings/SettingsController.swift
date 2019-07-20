//
//  SettingsController.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit
import ReSwift

class SettingsController: UIViewController {
    
    fileprivate var containerView: UIView!
    fileprivate var numberOfColumnsLabel: UILabel!
    fileprivate var numberOfColumnsSlider: UISlider!
    fileprivate var numberOfColumnsValueLabel: UILabel!
    fileprivate var numberOfRowsLabel: UILabel!
    fileprivate var nubmerOfRowsSlider: UISlider!
    fileprivate var numberOfRowsValueLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "Settings"
        self.view.backgroundColor = .white
        self.initContainerView()
        self.initNumberOfColumnsLabel()
        self.initNumberOfColumnsSlider()
        self.initNumberOfColumnsValueLabel()
        self.initNumberOfRowsLabel()
        self.initNumberOfRowsSlider()
        self.initNumberOfRowsValueLabel()
        self.initNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
    
    fileprivate func initContainerView() {
        self.containerView = UIView()
        self.view.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
            make.width.greaterThanOrEqualTo(300)
        }
    }
    
    fileprivate func initNumberOfColumnsLabel() {
        self.numberOfColumnsLabel = UILabel()
        self.numberOfColumnsLabel.text = "Number of columns:"
        self.numberOfColumnsLabel.textColor = .darkGray
        self.numberOfColumnsLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        self.numberOfColumnsLabel.textAlignment = .center
        self.containerView.addSubview(self.numberOfColumnsLabel)
        
        self.numberOfColumnsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    fileprivate func initNumberOfColumnsSlider() {
        self.numberOfColumnsSlider = UISlider()
        self.numberOfColumnsSlider.addTarget(self, action: #selector(self.onNumberOfColumnsChanged), for: .valueChanged)
        self.containerView.addSubview(self.numberOfColumnsSlider)
        
        self.numberOfColumnsSlider.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.numberOfColumnsLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initNumberOfColumnsValueLabel() {
        self.numberOfColumnsValueLabel = UILabel()
        self.numberOfColumnsValueLabel.textColor = .gray
        self.numberOfColumnsValueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        self.numberOfColumnsValueLabel.textAlignment = .center
        self.containerView.addSubview(self.numberOfColumnsValueLabel)
        
        self.numberOfColumnsValueLabel.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.numberOfColumnsSlider.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initNumberOfRowsLabel() {
        self.numberOfRowsLabel = UILabel()
        self.numberOfRowsLabel.text = "Number of rows:"
        self.numberOfRowsLabel.textColor = .darkGray
        self.numberOfRowsLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        self.numberOfRowsLabel.textAlignment = .center
        self.containerView.addSubview(self.numberOfRowsLabel)
        
        self.numberOfRowsLabel.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.numberOfColumnsValueLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initNumberOfRowsSlider() {
        self.nubmerOfRowsSlider = UISlider()
        self.nubmerOfRowsSlider.addTarget(self, action: #selector(self.onNumberOfRowsChanged), for: .valueChanged)
        self.containerView.addSubview(self.nubmerOfRowsSlider)
        
        self.nubmerOfRowsSlider.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.numberOfRowsLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initNumberOfRowsValueLabel() {
        self.numberOfRowsValueLabel = UILabel()
        self.numberOfRowsValueLabel.textColor = .gray
        self.numberOfRowsValueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        self.numberOfRowsValueLabel.textAlignment = .center
        self.containerView.addSubview(self.numberOfRowsValueLabel)
        
        self.numberOfRowsValueLabel.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.nubmerOfRowsSlider.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    fileprivate func initNavigationBarItems() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onDoneButton))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc fileprivate func onNumberOfColumnsChanged() {
        store.dispatch(SettingsAction.ChangeNumberOfColumns(newNumberOfColumns: Int(self.numberOfColumnsSlider.value)))
    }
    
    @objc fileprivate func onNumberOfRowsChanged() {
        store.dispatch(SettingsAction.ChangeNumberOfRows(newNumberOfRows: Int(self.nubmerOfRowsSlider.value)))
    }
    
    @objc fileprivate func onDoneButton() {
        self.dismiss(animated: true)
    }
}

extension SettingsController: StoreSubscriber {
    
    func newState(state: AppState) {
        self.numberOfColumnsSlider.minimumValue = Float(state.minNumberOfColumns)
        self.numberOfColumnsSlider.maximumValue = Float(state.maxNumberOfColumns)
        self.numberOfColumnsValueLabel.text = "\(state.currentNumberOfColumns)"
        
        self.nubmerOfRowsSlider.minimumValue = Float(state.minNumberOfRows)
        self.nubmerOfRowsSlider.maximumValue = Float(state.maxNumberOfRows)
        self.numberOfRowsValueLabel.text = "\(state.currentNumberOfRows)"
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.numberOfColumnsSlider.setValue(Float(state.currentNumberOfColumns), animated: true)
            self?.nubmerOfRowsSlider.setValue(Float(state.currentNumberOfRows), animated: true)
        }
    }
}
