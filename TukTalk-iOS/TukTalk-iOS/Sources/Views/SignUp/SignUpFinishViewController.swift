//
//  SignUpFinishViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/23.
//

import RxSwift

class SignUpFinishViewController: UIViewController {
    
    //MARK:- Properties
    
    private let user = UserSignUp.shared
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "뚝딱 가입을 환영합니다!"
        $0.font = UIFont.TTFont(type: .SDBold, size: 18)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "마이페이지에서 자신을 소개해보세요."
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.textColor = UIColor.GrayScale.sub2
    }
    
    private let conImage = UIImageView().then {
        $0.image = UIImage(named: "conImg")
    }
    
    private let mainBtn = UIButton().then {
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Primary.primary.cgColor
        $0.layer.cornerRadius = 26
    }
    
    private let homeBtn = UIButton().then {
        $0.setTitle("홈으로 가기", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub2, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray2.cgColor
        $0.layer.cornerRadius = 26
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(25)
            if UIScreen.main.bounds.height == 667 {
                $0.top.equalToSuperview().offset(320)
            } else {
                $0.top.equalToSuperview().offset(420)
            }
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(conImage)
        conImage.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        switch user.role {
        case "MENTEE":
            mainBtn.setTitle("프로필 등록하기", for: .normal)
        default:
            mainBtn.setTitle("멘토 인증하기", for: .normal)
        }
        view.addSubview(mainBtn)
        mainBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(homeBtn)
        homeBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(mainBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        mainBtn.rx.tap
            .bind { _ in
                switch self.user.role {
                case "MENTEE":
                    self.navigationController?.pushViewController(RegistMenteeProfileViewController(), animated: true)
                default:
                    self.navigationController?.pushViewController(RegistProfileFirstViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)
        homeBtn.rx.tap
            .bind { _ in
                self.navigationController?.popToRootViewController(animated: true)
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
