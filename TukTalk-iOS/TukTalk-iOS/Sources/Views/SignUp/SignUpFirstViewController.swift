//
//  SignUpViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/16.
//

import RxSwift

class SignUpFirstViewController: UIViewController {
    
    //MARK:- Properties
    
    private let user = UserSignUp.shared
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
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
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
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: .black, alpha: 0.05, x: 4, y: 4, blur: 14, spread: 0)
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
        setUI()
        binding()
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            if UIScreen.main.bounds.height <= 737 {
                $0.top.equalToSuperview().offset(39)
            } else {
                $0.top.equalToSuperview().offset(59)
            }
            $0.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(signUpMenteeBtn)
        signUpMenteeBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(56)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(90)
        }
        
        signUpMenteeBtn.addSubview(signUpMenteeTitleLabel)
        signUpMenteeBtn.addSubview(signUpMenteeImg)
        signUpMenteeBtn.addSubview(signUpMenteeLabel)
        signUpMenteeBtn.addSubview(signUpMenteeArrow)
        signUpMenteeImg.snp.makeConstraints {
            $0.top.equalTo(signUpMenteeBtn.snp.top).offset(24)
            $0.leading.equalTo(signUpMenteeBtn.snp.leading).offset(24)
        }
        signUpMenteeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(signUpMenteeBtn.snp.top).offset(24)
            $0.leading.equalTo(signUpMenteeImg.snp.trailing).offset(12)
            $0.height.equalTo(22)
        }
        signUpMenteeLabel.snp.makeConstraints {
            $0.leading.equalTo(signUpMenteeTitleLabel.snp.leading)
            $0.top.equalTo(signUpMenteeTitleLabel.snp.bottom).offset(2)
            $0.height.equalTo(18)
        }
        signUpMenteeArrow.snp.makeConstraints {
            $0.top.equalTo(signUpMenteeBtn.snp.top).offset(33)
            $0.trailing.equalTo(signUpMenteeBtn.snp.trailing).inset(24)
        }
        
        view.addSubview(signUpMentorBtn)
        signUpMentorBtn.snp.makeConstraints {
            $0.top.equalTo(signUpMenteeBtn.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(90)
        }
        
        signUpMentorBtn.addSubview(signUpMentorTitleLabel)
        signUpMentorBtn.addSubview(signUpMentorImg)
        signUpMentorBtn.addSubview(signUpMentorLabel)
        signUpMentorBtn.addSubview(signUpMentorArrow)
        signUpMentorImg.snp.makeConstraints {
            $0.top.equalTo(signUpMentorBtn.snp.top).offset(24)
            $0.leading.equalTo(signUpMentorBtn.snp.leading).offset(24)
        }
        signUpMentorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(signUpMentorBtn.snp.top).offset(24)
            $0.leading.equalTo(signUpMentorImg.snp.trailing).offset(12)
            $0.height.equalTo(22)
        }
        signUpMentorLabel.snp.makeConstraints {
            $0.leading.equalTo(signUpMentorTitleLabel.snp.leading)
            $0.top.equalTo(signUpMentorTitleLabel.snp.bottom).offset(2)
            $0.height.equalTo(18)
        }
        signUpMentorArrow.snp.makeConstraints {
            $0.top.equalTo(signUpMentorBtn.snp.top).offset(33)
            $0.trailing.equalTo(signUpMentorBtn.snp.trailing).inset(24)
        }
    }
    
    private func binding() {
        signUpMentorBtn.rx.tap
            .bind {
                self.user.role = "MENTOR"
                let nextVC = SignUpSecondViewController()
                nextVC.titleLabel.text = "어떤 분야에서\n일하고 계신가요?👀"
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        signUpMenteeBtn.rx.tap
            .bind {
                self.user.role = "MENTEE"
                self.navigationController?.pushViewController(SignUpSecondViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

}
