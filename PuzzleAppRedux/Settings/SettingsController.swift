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
    fileprivate var widthSliderLabel: UILabel!
    fileprivate var widthSlider: UISlider!
    fileprivate var widthSliderValueLabel: UILabel!
    fileprivate var heightSliderLabel: UILabel!
    fileprivate var heightSlider: UISlider!
    fileprivate var heightSliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "Settings"
        self.view.backgroundColor = .white
        self.initContainerView()
        self.initWidthSliderLabel()
        self.initWidthSlider()
        self.initWidthSliderValueLabel()
        self.initHeightSliderLabel()
        self.initHeightSlider()
        self.initHeightSliderValueLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.subscribe(self) { appState  in
            return appState.select { $0.settingState }
        }
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
    
    fileprivate func initWidthSliderLabel() {
        self.widthSliderLabel = UILabel()
        self.widthSliderLabel.text = "Map width:"
        self.widthSliderLabel.textColor = .darkGray
        self.widthSliderLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        self.widthSliderLabel.textAlignment = .center
        self.containerView.addSubview(self.widthSliderLabel)
        
        self.widthSliderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    fileprivate func initWidthSlider() {
        self.widthSlider = UISlider()
        self.widthSlider.addTarget(self, action: #selector(self.widthChanged), for: .valueChanged)
        self.containerView.addSubview(self.widthSlider)
        
        self.widthSlider.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.widthSliderLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initWidthSliderValueLabel() {
        self.widthSliderValueLabel = UILabel()
        self.widthSliderValueLabel.textColor = .gray
        self.widthSliderValueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        self.widthSliderValueLabel.textAlignment = .center
        self.containerView.addSubview(self.widthSliderValueLabel)
        
        self.widthSliderValueLabel.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.widthSlider.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initHeightSliderLabel() {
        self.heightSliderLabel = UILabel()
        self.heightSliderLabel.text = "Map height:"
        self.heightSliderLabel.textColor = .darkGray
        self.heightSliderLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        self.heightSliderLabel.textAlignment = .center
        self.containerView.addSubview(self.heightSliderLabel)
        
        self.heightSliderLabel.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.widthSliderValueLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initHeightSlider() {
        self.heightSlider = UISlider()
        self.heightSlider.addTarget(self, action: #selector(self.heightChanged), for: .valueChanged)
        self.containerView.addSubview(self.heightSlider)
        
        self.heightSlider.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.heightSliderLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    fileprivate func initHeightSliderValueLabel() {
        self.heightSliderValueLabel = UILabel()
        self.heightSliderValueLabel.textColor = .gray
        self.heightSliderValueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        self.heightSliderValueLabel.textAlignment = .center
        self.containerView.addSubview(self.heightSliderValueLabel)
        
        self.heightSliderValueLabel.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.heightSlider.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc fileprivate func widthChanged() {
        store.dispatch(SettingsAction.ChangeMapWidth(newMapWidth: Int(self.widthSlider.value)))
    }
    
    @objc fileprivate func heightChanged() {
        store.dispatch(SettingsAction.ChangeMapHeight(newMapHeight: Int(self.heightSlider.value)))
    }
}

extension SettingsController: StoreSubscriber {
    
    func newState(state: SettingState) {
        self.widthSlider.minimumValue = Float(state.minWidth)
        self.widthSlider.maximumValue = Float(state.maxWidth)
        self.widthSliderValueLabel.text = "\(state.currentWidth)"
        
        self.heightSlider.minimumValue = Float(state.minHeight)
        self.heightSlider.maximumValue = Float(state.maxHeight)
        self.heightSliderValueLabel.text = "\(state.currentHeight)"
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.widthSlider.setValue(Float(state.currentWidth), animated: true)
            self?.heightSlider.setValue(Float(state.currentHeight), animated: true)
        }
        
    }
}
