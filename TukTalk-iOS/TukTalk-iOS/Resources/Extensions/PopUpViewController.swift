//
//  PopUpViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/17.
//

import UIKit

final class PopUpViewController: UIViewController {
    
    //MARK:- Properties
    
    private let popUpView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 8
    }
    
    let popUpTitleLabel = UILabel().then {
        $0.text = "회원가입을 중단하시겠습니까?"
        $0.textColor = UIColor.GrayScale.normal
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let dismissBtn = UIButton().then {
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.setTitle("나가기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.addTarget(self, action: #selector(dismissBtnAction), for: .touchUpInside)
    }
    
    private let acceptBtn = UIButton().then {
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
        $0.setTitle("계속 작성", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.addTarget(self, action: #selector(acceptBtnAction), for: .touchUpInside)
        
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //MARK:- Functions
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        view.addSubview(popUpView)
        popUpView.addSubview(popUpTitleLabel)
        popUpView.addSubview(dismissBtn)
        popUpView.addSubview(acceptBtn)
        
        popUpView.snp.makeConstraints {
            $0.height.equalTo(171)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(33)
        }
        
        popUpTitleLabel.snp.makeConstraints {
            $0.top.equalTo(popUpView).offset(57)
            $0.centerX.equalTo(popUpView)
        }
        
        dismissBtn.snp.makeConstraints {
            $0.leading.bottom.equalTo(popUpView)
            $0.height.equalTo(62)
            $0.width.equalTo(154)
        }
        
        acceptBtn.snp.makeConstraints {
            $0.trailing.bottom.equalTo(popUpView)
            $0.height.equalTo(62)
            $0.width.equalTo(154)
        }
        
    }
    
    @objc func dismissBtnAction() {
        guard let navi = presentingViewController as? UINavigationController else { return }
        self.dismiss(animated: true) {
            navi.popToRootViewController(animated: true)
        }
    }
    
    @objc func acceptBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
