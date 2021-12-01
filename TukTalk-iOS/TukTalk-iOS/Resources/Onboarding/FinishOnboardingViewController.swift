//
//  FinishOnboardingViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import UIKit

class FinishOnboardingViewController: UIViewController {
    
    private let titleView = UIImageView().then {
        $0.image = UIImage(named: "finishTitle")
    }
    
    private let mainView = UIImageView().then {
        $0.image = UIImage(named: "finishView")
    }
    
    private let subTitleView = UIImageView().then {
        $0.image = UIImage(named: "finishSubTitle")
    }
    
    private let startBtn = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = UIColor.Primary.primary
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 26
        $0.addTarget(self, action: #selector(startBtnAction), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        setUI()
        setSwipe()
    }
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints {
            if UIScreen.main.bounds.height <= 667 {
                $0.top.equalToSuperview().offset(60)
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
        
        view.addSubview(startBtn)
        startBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(16)
            if UIScreen.main.bounds.height <= 667 {
                $0.bottom.equalToSuperview().offset(-10)
            } else {
                $0.bottom.equalToSuperview().offset(-42)
            }
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
            case UISwipeGestureRecognizer.Direction.right:
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    }
    
    @objc private func startBtnAction() {
        let startVC = UINavigationController(rootViewController: TabBarViewController())
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first!.replaceRootViewController(startVC, animated: true, completion: nil)
    }
}
