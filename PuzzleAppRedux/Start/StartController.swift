//
//  StartController.swift
//  PuzzleAppRedux
//
//  Created by Mariusz Sut on 18/07/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit
import SnapKit

class StartController: UIViewController {
    
    fileprivate var containerView: UIView!
    fileprivate var titleLabel: UILabel!
    fileprivate var startNewGameButton: UIButton!
    fileprivate var resumeGameButton: UIButton!
    fileprivate var settingsButton: UIButton!
    
    override func viewDidLoad() {
        self.intialize()
    }
    
    fileprivate func intialize() {
        self.title = "Menu"
        self.view.backgroundColor = .white
        self.initContainerView()
        self.initTitleLabel()
        self.initStartNewGameButton()
        self.initResumeGameButton()
        self.initSettingsButton()
    }
    
    fileprivate func initContainerView() {
        self.containerView = UIView()
        self.view.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints { make in
            make.left.greaterThanOrEqualToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    fileprivate func initTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Puzzle Game"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        self.titleLabel.textColor = .darkGray
        self.containerView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
    }
    
    fileprivate func initStartNewGameButton() {
        self.startNewGameButton = UIButton()
        self.startNewGameButton.setTitle("New game", for: .normal)
        self.startNewGameButton.setTitleColor(self.view.tintColor, for: .normal)
        self.startNewGameButton.addTarget(self, action: #selector(self.onStartButton), for: .touchUpInside)
        self.containerView.addSubview(self.startNewGameButton)
        
        self.startNewGameButton.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    fileprivate func initResumeGameButton() {
        self.resumeGameButton = UIButton()
        self.resumeGameButton.setTitle("Resume game", for: .normal)
        self.resumeGameButton.setTitleColor(self.view.tintColor, for: .normal)
        self.containerView.addSubview(self.resumeGameButton)
        
        self.resumeGameButton.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.startNewGameButton.snp.bottom).offset(8)
            make.left.greaterThanOrEqualToSuperview().offset(8)
            make.right.lessThanOrEqualToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }
    }
    
    fileprivate func initSettingsButton() {
        self.settingsButton = UIButton()
        self.settingsButton.setTitle("Settings", for: .normal)
        self.settingsButton.setTitleColor(self.view.tintColor, for: .normal)
        self.settingsButton.addTarget(self, action: #selector(onSettingsButton), for: .touchUpInside)
        self.containerView.addSubview(self.settingsButton)
        
        self.settingsButton.snp.makeConstraints { [unowned self] make in
            make.top.equalTo(self.resumeGameButton.snp.bottom).offset(8)
            make.left.greaterThanOrEqualToSuperview().offset(8)
            make.right.lessThanOrEqualToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc fileprivate func onStartButton() {
        self.navigationController?.pushViewController(PuzzleController(), animated: true)
    }
    
    @objc fileprivate func onSettingsButton() {
        self.navigationController?.pushViewController(SettingsController(), animated: true)
    }
}
