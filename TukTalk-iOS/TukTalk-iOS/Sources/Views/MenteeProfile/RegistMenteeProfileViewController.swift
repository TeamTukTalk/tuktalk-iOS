//
//  RegistMenteeProfileViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import RxSwift

class RegistMenteeProfileViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.setTitle("프로필 등록/수정", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.setTitleColor(UIColor.GrayScale.normal, for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: -15)
    }
    
//    private let profileImg = UIImageView().then {
//        $0.backgroundColor = UIColor.GrayScale.gray4
//        $0.layer.masksToBounds = true
//        $0.layer.cornerRadius = 35
//        $0.contentMode = .scaleAspectFill
//        $0.isHidden = true
//    }
    private let profileBackground = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 35
    }
    private let profileLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
    }
    private let nameLabel = UILabel().then {
        $0.text = "이름(닉네임)*"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let nameTextField = UITextField().then {
        $0.text = "애니" /// 서버 연동 후 변경 예정
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.setLeftPaddingPoints(16)
    }
    
}
