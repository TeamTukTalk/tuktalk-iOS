//
//  MentorCertifyPopUp.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import UIKit

final class MentorCertifyPopUp: UIViewController {
    
    //MARK:- Properties
    
    private let popUpView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 8
    }
    
    private let popUpImg = UIImageView().then {
        $0.image = UIImage(named: "updateImg")
    }
    
    private let popUpTitleLabel = UILabel().then {
        $0.text = "프로필은 멘토 인증을 해주셔야 등록하실 수 있습니다!"
        $0.textColor = UIColor.GrayScale.sub3
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
    }
    
    private let acceptBtn = UIButton().then {
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
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
        popUpView.addSubview(popUpImg)
        popUpView.addSubview(acceptBtn)
        
        popUpView.snp.makeConstraints {
            $0.height.equalTo(171)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(33)
        }
        
        popUpImg.snp.makeConstraints {
            $0.width.equalTo(170)
            $0.height.equalTo(60)
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        popUpTitleLabel.snp.makeConstraints {
            $0.top.equalTo(popUpImg.snp.bottom).offset(12)
            $0.centerX.equalTo(popUpView)
        }
        
        acceptBtn.snp.makeConstraints {
            $0.height.equalTo(62)
            $0.width.equalTo(40)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
    }
    
    @objc func acceptBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
