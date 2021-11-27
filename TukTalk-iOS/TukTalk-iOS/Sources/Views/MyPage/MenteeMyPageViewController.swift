//
//  MenteeMyPageViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/27.
//

import RxSwift

class MenteeMyPageViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let settingBtn = UIButton().then {
        $0.setImage(UIImage(named: "settingBtn"), for: .normal)
    }
    
    private let profileBtn = UIButton().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 35
    }
    private let profileLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
    }
    
    private let profileEditImg = UIImageView().then {
        $0.image = UIImage(named: "profileEditBtn")
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "리즈님"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let welcomeLabel = UILabel().then {
        $0.text = "안녕하세요."
        $0.font = UIFont.TTFont(type: .SDMed, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let devideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    private let secondDevideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    private let myServiceBtn = UIButton()
    
    private let myServiceLabel = UILabel().then {
        $0.text = "📁 최근 본 포트폴리오"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let myServiceImageView = UIImageView().then {
        $0.image = UIImage(named: "arrowRightImg")
    }
    
    private let certifyBtn = UIButton()
    private let certifyLabel = UILabel().then {
        $0.text = "멘토/회사 인증하기"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let accountSettingBtn = UIButton()
    private let accountSettingLabel = UILabel().then {
        $0.text = "계정 설정"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(settingBtn)
        settingBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(profileBtn)
        profileBtn.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.top.equalToSuperview().offset(88)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(profileEditImg)
        profileEditImg.snp.makeConstraints {
            $0.trailing.bottom.equalTo(profileBtn)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(99)
            $0.leading.equalTo(profileBtn.snp.trailing).offset(20)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        view.addSubview(devideView)
        devideView.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(profileBtn.snp.bottom).offset(24)
        }
        
        view.addSubview(myServiceBtn)
        myServiceBtn.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.top.equalTo(devideView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        myServiceBtn.addSubview(myServiceLabel)
        myServiceLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        myServiceBtn.addSubview(myServiceImageView)
        myServiceImageView.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(secondDevideView)
        secondDevideView.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(myServiceBtn.snp.bottom)
        }
        
        view.addSubview(certifyBtn)
        certifyBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(secondDevideView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        certifyBtn.addSubview(certifyLabel)
        certifyLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        
        view.addSubview(accountSettingBtn)
        accountSettingBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(certifyBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        accountSettingBtn.addSubview(accountSettingLabel)
        accountSettingLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    private func binding() {
        profileBtn.rx.tap
            .bind { _ in
                self.tabBarController?.tabBar.isHidden = true
                self.navigationController?.pushViewController(RegistProfileFirstViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
