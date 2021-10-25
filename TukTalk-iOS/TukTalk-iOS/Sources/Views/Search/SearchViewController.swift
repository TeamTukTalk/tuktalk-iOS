//
//  SearchViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/25.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {

    //MARK:- UI Components
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "멘토, 직무 검색"
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let searchImg = UIImageView().then {
        $0.image = UIImage(named: "searchImg")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "관심 분야의 멘토와 포트폴리오를 찾아보세요."
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let designBtn = UIButton().then {
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: .blue, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
    }
    
    private let designLabel = UILabel().then {
        $0.text = "디자인"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let designImg = UIImageView().then {
        $0.image = UIImage(named: "designBtnImg")
    }
    
    private let itDevBtn = UIButton().then {
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: .blue, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
    }
    
    private let itDevLabel = UILabel().then {
        $0.text = "IT/개발"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let itDevImg = UIImageView().then {
        $0.image = UIImage(named: "itDevBtnImg")
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    //MARK:- Function
    
    private func setUI() {
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        searchTextField.addSubview(searchImg)
        searchImg.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(designBtn)
        designBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(144)
            make.width.equalTo(164)
        }
        
        designBtn.addSubview(designLabel)
        designLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        designBtn.addSubview(designImg)
        designImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(itDevBtn)
        itDevBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(144)
            make.width.equalTo(164)
        }
        
        itDevBtn.addSubview(itDevLabel)
        itDevLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        itDevBtn.addSubview(itDevImg)
        itDevImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
//        view.addSubview(signUpMenteeBtn)
//        signUpMenteeBtn.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(56)
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(90)
//        }
//
//        signUpMenteeBtn.addSubview(signUpMenteeTitleLabel)
//        signUpMenteeBtn.addSubview(signUpMenteeImg)
//        signUpMenteeBtn.addSubview(signUpMenteeLabel)
//        signUpMenteeBtn.addSubview(signUpMenteeArrow)
//        signUpMenteeImg.snp.makeConstraints { make in
//            make.top.equalTo(signUpMenteeBtn.snp.top).offset(24)
//            make.leading.equalTo(signUpMenteeBtn.snp.leading).offset(24)
//        }
//        signUpMenteeTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(signUpMenteeBtn.snp.top).offset(24)
//            make.leading.equalTo(signUpMenteeImg.snp.trailing).offset(12)
//            make.height.equalTo(22)
//        }
//        signUpMenteeLabel.snp.makeConstraints { make in
//            make.leading.equalTo(signUpMenteeTitleLabel.snp.leading)
//            make.top.equalTo(signUpMenteeTitleLabel.snp.bottom).offset(2)
//            make.height.equalTo(18)
//        }
//        signUpMenteeArrow.snp.makeConstraints { make in
//            make.top.equalTo(signUpMenteeBtn.snp.top).offset(33)
//            make.trailing.equalTo(signUpMenteeBtn.snp.trailing).inset(24)
//        }
//
//        view.addSubview(signUpMentorBtn)
//        signUpMentorBtn.snp.makeConstraints { make in
//            make.top.equalTo(signUpMenteeBtn.snp.bottom).offset(12)
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(90)
//        }
//
//        signUpMentorBtn.addSubview(signUpMentorTitleLabel)
//        signUpMentorBtn.addSubview(signUpMentorImg)
//        signUpMentorBtn.addSubview(signUpMentorLabel)
//        signUpMentorBtn.addSubview(signUpMentorArrow)
//        signUpMentorImg.snp.makeConstraints { make in
//            make.top.equalTo(signUpMentorBtn.snp.top).offset(24)
//            make.leading.equalTo(signUpMentorBtn.snp.leading).offset(24)
//        }
//        signUpMentorTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(signUpMentorBtn.snp.top).offset(24)
//            make.leading.equalTo(signUpMentorImg.snp.trailing).offset(12)
//            make.height.equalTo(22)
//        }
//        signUpMentorLabel.snp.makeConstraints { make in
//            make.leading.equalTo(signUpMentorTitleLabel.snp.leading)
//            make.top.equalTo(signUpMentorTitleLabel.snp.bottom).offset(2)
//            make.height.equalTo(18)
//        }
//        signUpMentorArrow.snp.makeConstraints { make in
//            make.top.equalTo(signUpMentorBtn.snp.top).offset(33)
//            make.trailing.equalTo(signUpMentorBtn.snp.trailing).inset(24)
//        }
//    }
//
//    private func binding() {
//        signUpMentorBtn.rx.tap
//            .bind {
//                let nextVC = WhichFieldViewController()
//                nextVC.titleLabel.text = "어떤 분야에서\n일하고 계신가요?👀"
//                self.navigationController?.pushViewController(nextVC, animated: true)
//            }
//            .disposed(by: disposeBag)
//
//        signUpMenteeBtn.rx.tap
//            .bind {
//                self.navigationController?.pushViewController(WhichFieldViewController(), animated: true)
//            }
//            .disposed(by: disposeBag)
//
//        backBtn.rx.tap
//            .bind {
//                self.navigationController?.popViewController(animated: true)
//            }
//            .disposed(by: disposeBag)
//    }
    }
}
