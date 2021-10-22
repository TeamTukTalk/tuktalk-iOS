//
//  SignUpViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/16.
//

import SnapKit
import Then
import RxSwift

class SignUpChoiceViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()

    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 12
        $0.frame.size.width = 12
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "뚝딱에서 어떤 서비스를\n이용하고 싶으세요? 🤔"
        $0.font = UIFont.TTFont(type: .SDHeader, size: 20)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 20)
    }
    
    private let signUpMenteeBtn = UIButton().then {
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 20, spread: 0)
    }
    
    private let signUpMenteeImg = UIImageView().then {
        $0.image = UIImage(named: "signUpMenteeImg")
    }
    
    private let signUpMenteeTitleLabel = UILabel().then {
        $0.text = "멘티로 가입"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let signUpMenteeLabel = UILabel().then {
        $0.text = "멘토와 소통하면서 취뽀하고 싶다면!"
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let signUpMenteeArrow = UIImageView().then {
        $0.image = UIImage(named: "nextBtnImg")
    }
    
    private let signUpMentorBtn = UIButton().then {
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 20, spread: 0)
    }
    
    private let signUpMentorImg = UIImageView().then {
        $0.image = UIImage(named: "signUpMentorImg")
    }
    
    private let signUpMentorTitleLabel = UILabel().then {
        $0.text = "멘토로 가입"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let signUpMentorLabel = UILabel().then {
        $0.text = "지식공유를 하면서 수익 창출하고 싶다면!"
        $0.font = UIFont.TTFont(type: .SDReg, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let signUpMentorArrow = UIImageView().then {
        $0.image = UIImage(named: "nextBtnImg")
    }
    
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        binding()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(59)
            make.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(signUpMenteeBtn)
        signUpMenteeBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(90)
        }
        
        signUpMenteeBtn.addSubview(signUpMenteeTitleLabel)
        signUpMenteeBtn.addSubview(signUpMenteeImg)
        signUpMenteeBtn.addSubview(signUpMenteeLabel)
        signUpMenteeBtn.addSubview(signUpMenteeArrow)
        signUpMenteeImg.snp.makeConstraints { make in
            make.top.equalTo(signUpMenteeBtn.snp.top).offset(24)
            make.leading.equalTo(signUpMenteeBtn.snp.leading).offset(24)
        }
        signUpMenteeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpMenteeBtn.snp.top).offset(24)
            make.leading.equalTo(signUpMenteeImg.snp.trailing).offset(12)
            make.height.equalTo(22)
        }
        signUpMenteeLabel.snp.makeConstraints { make in
            make.leading.equalTo(signUpMenteeTitleLabel.snp.leading)
            make.top.equalTo(signUpMenteeTitleLabel.snp.bottom).offset(2)
            make.height.equalTo(18)
        }
        signUpMenteeArrow.snp.makeConstraints { make in
            make.top.equalTo(signUpMenteeBtn.snp.top).offset(33)
            make.trailing.equalTo(signUpMenteeBtn.snp.trailing).inset(24)
        }
        
        view.addSubview(signUpMentorBtn)
        signUpMentorBtn.snp.makeConstraints { make in
            make.top.equalTo(signUpMenteeBtn.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(90)
        }
        
        signUpMentorBtn.addSubview(signUpMentorTitleLabel)
        signUpMentorBtn.addSubview(signUpMentorImg)
        signUpMentorBtn.addSubview(signUpMentorLabel)
        signUpMentorBtn.addSubview(signUpMentorArrow)
        signUpMentorImg.snp.makeConstraints { make in
            make.top.equalTo(signUpMentorBtn.snp.top).offset(24)
            make.leading.equalTo(signUpMentorBtn.snp.leading).offset(24)
        }
        signUpMentorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpMentorBtn.snp.top).offset(24)
            make.leading.equalTo(signUpMentorImg.snp.trailing).offset(12)
            make.height.equalTo(22)
        }
        signUpMentorLabel.snp.makeConstraints { make in
            make.leading.equalTo(signUpMentorTitleLabel.snp.leading)
            make.top.equalTo(signUpMentorTitleLabel.snp.bottom).offset(2)
            make.height.equalTo(18)
        }
        signUpMentorArrow.snp.makeConstraints { make in
            make.top.equalTo(signUpMentorBtn.snp.top).offset(33)
            make.trailing.equalTo(signUpMentorBtn.snp.trailing).inset(24)
        }
    }
    
    private func binding() {
        signUpMentorBtn.rx.tap
            .bind {
                let nextVC = WhichFieldViewController()
                nextVC.titleLabel.text = "어떤 분야에서\n일하고 계신가요?👀"
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        signUpMenteeBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(WhichFieldViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

}
