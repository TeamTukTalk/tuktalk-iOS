//
//  FirstOnboardingViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import UIKit

class FirstOnboardingViewController: UIViewController {
    
    private let titleView = UIImageView().then {
        $0.image = UIImage(named: "firstTitle")
    }
    
    private let mainView = UIImageView().then {
        $0.image = UIImage(named: "firstView")
    }
    
    private let subTitleView = UIImageView().then {
        $0.image = UIImage(named: "firstSubTitle")
    }
    
    override func viewDidLoad() {
        setUI()
        setSwipe()
    }
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = .white
        UserDefaults.standard.set(true, forKey: "first")
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints {
            if UIScreen.main.bounds.height <= 667 {
                $0.top.equalToSuperview().offset(84)
            } else {
                $0.top.equalToSuperview().offset(124)
            }
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(subTitleView)
        subTitleView.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                self.navigationController?.pushViewController(SecondOnboardingViewController(), animated: true)
            default:
                break
            }
        }
    }
}
