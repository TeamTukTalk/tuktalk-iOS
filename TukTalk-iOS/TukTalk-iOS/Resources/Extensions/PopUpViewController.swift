//
//  PopUpViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/17.
//

import UIKit
import SnapKit
import Then

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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setUI()
    }
    
    //MARK:- Functions
    
    private func setUI() {
        view.addSubview(popUpView)
        popUpView.addSubview(popUpTitleLabel)
        popUpView.addSubview(dismissBtn)
        popUpView.addSubview(acceptBtn)
        popUpView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(33)
            make.top.equalToSuperview().offset(321)
            make.height.equalTo(171)
        }
        popUpTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(popUpView).offset(57)
            make.centerX.equalTo(popUpView)
        }
        dismissBtn.snp.makeConstraints { make in
            make.leading.bottom.equalTo(popUpView)
            make.height.equalTo(62)
            make.width.equalTo(154)
        }
        acceptBtn.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(popUpView)
            make.height.equalTo(62)
            make.width.equalTo(154)
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
