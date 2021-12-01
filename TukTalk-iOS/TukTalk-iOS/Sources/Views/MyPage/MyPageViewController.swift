//
//  MenteeMyPageViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/27.
//

import RxSwift
import Moya

class MyPageViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = MyPageViewModel()
    private var mentorEmailValid: Bool?
    private var user: String?
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
//    private let settingBtn = UIButton().then {
//        $0.setImage(UIImage(named: "settingBtn"), for: .normal)
//    }
    
    private let profileImg = UIImageView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 35
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    private let profileBackground = UIView().then {
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 35
    }
    private let profileLabel = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDBold, size: 24)
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
    
    private let notiBtn = UIButton().then {
        $0.backgroundColor = UIColor.GrayScale.gray5
        $0.layer.cornerRadius = 22
    }
    private let notiBtnLabel = UILabel().then {
        $0.text = "✉️ 멘토 인증을 해주셔야 활동하실 수 있습니다!"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    private let notiBtnImg = UIImageView().then {
        $0.image = UIImage(named: "arrowRightImg")
    }
    
    private let devideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray5
    }
    private let secondDevideView = UIView(frame: .zero).then {
        $0.backgroundColor = UIColor.GrayScale.gray4
    }
    
    private let mentorServiceLabel = UILabel().then {
        $0.text = "💬 나의 서비스"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let mentorServiceView = UIView().then {
        $0.backgroundColor = UIColor.myPageColor
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray3.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let mentorServiceNilImg = UIImageView().then {
        $0.image = UIImage(named: "nilAlertImg")
    }
    
    private let mentorServiceNilLabel = UILabel().then {
        $0.text = "등록한 서비스가 없습니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 12)
        $0.textColor = UIColor.GrayScale.sub4
    }
    
    private let menteeServiceLabel = UILabel().then {
        $0.text = "📁 최근 본 포트폴리오"
        $0.font = UIFont.TTFont(type: .SDBold, size: 15)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let myServiceBtn = UIButton()
    
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
        setProfileData()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setProfileData()
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- Function
    
    private func setProfileData() {
        if let role = KeyChain.load(key: "role") {
            let role = String(data: role, encoding: .utf8)
            user = role
        }
        
        if let nickname = KeyChain.load(key: "nickname") {
            let name = String(data: nickname, encoding: .utf8)
            self.nameLabel.text = "\(name ?? "")님"
        }
        if let firstLetter = KeyChain.load(key: "firstLetter") {
            let first = String(data: firstLetter, encoding: .utf8)
            self.profileLabel.text = first
        }
        if let profileImageColor = KeyChain.load(key: "profileImageColor") {
            let color = String(data: profileImageColor, encoding: .utf8)
            self.profileBackground.backgroundColor = UIColor.Profile.getProfileColor(color: color ?? "")
            self.profileLabel.textColor = UIColor.Profile.getNameColor(color: color ?? "")
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
//        view.addSubview(settingBtn)
//        settingBtn.snp.makeConstraints {
//            $0.width.height.equalTo(24)
//            $0.top.equalToSuperview().offset(54)
//            $0.trailing.equalToSuperview().inset(16)
//        }
        view.addSubview(profileImg)
        profileImg.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.top.equalToSuperview().offset(88)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(profileBackground)
        profileBackground.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.top.equalToSuperview().offset(88)
            $0.leading.equalToSuperview().offset(16)
        }
        
        profileBackground.addSubview(profileLabel)
        profileLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerX.centerY.equalToSuperview()
        }
        
        view.addSubview(profileEditImg)
        profileEditImg.snp.makeConstraints {
            $0.trailing.bottom.equalTo(profileBackground)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(99)
            $0.leading.equalTo(profileBackground.snp.trailing).offset(20)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        if user == "MENTOR" {
            view.addSubview(notiBtn)
            notiBtn.snp.makeConstraints {
                $0.height.equalTo(44)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.equalTo(profileBackground.snp.bottom).offset(20)
            }
            notiBtn.addSubview(notiBtnLabel)
            notiBtnLabel.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(20)
            }
            notiBtn.addSubview(notiBtnImg)
            notiBtnImg.snp.makeConstraints {
                $0.width.height.equalTo(16)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
            }
            view.addSubview(devideView)
            devideView.snp.makeConstraints {
                $0.height.equalTo(6)
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(notiBtn.snp.bottom).offset(20)
            }
            view.addSubview(myServiceBtn)
            myServiceBtn.snp.makeConstraints {
                $0.height.equalTo(54)
                $0.top.equalTo(devideView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }
            myServiceBtn.addSubview(mentorServiceLabel)
            mentorServiceLabel.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(16)
            }
            myServiceBtn.addSubview(myServiceImageView)
            myServiceImageView.snp.makeConstraints {
                $0.width.height.equalTo(16)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(16)
            }
            view.addSubview(mentorServiceView)
            mentorServiceView.snp.makeConstraints {
                $0.height.equalTo(135)
                $0.top.equalTo(myServiceBtn.snp.bottom).offset(19)
                $0.leading.trailing.equalToSuperview().inset(16)
            }
            mentorServiceView.addSubview(mentorServiceNilImg)
            mentorServiceNilImg.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(43)
            }
            
            mentorServiceView.addSubview(mentorServiceNilLabel)
            mentorServiceNilLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(75)
            }
            view.addSubview(secondDevideView)
            secondDevideView.snp.makeConstraints {
                $0.height.equalTo(6)
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(mentorServiceView.snp.bottom).offset(24)
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
            mentorEmailValidation()
        } else if user == "MENTEE" {
            view.addSubview(devideView)
            devideView.snp.makeConstraints {
                $0.height.equalTo(6)
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(profileBackground.snp.bottom).offset(24)
            }
            
            view.addSubview(myServiceBtn)
            myServiceBtn.snp.makeConstraints {
                $0.height.equalTo(54)
                $0.top.equalTo(devideView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }
            
            myServiceBtn.addSubview(myServiceImageView)
            myServiceImageView.snp.makeConstraints {
                $0.width.height.equalTo(16)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(16)
            }
            
            myServiceBtn.addSubview(menteeServiceLabel)
            menteeServiceLabel.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(16)
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
        
        
    }
    
    private func mentorEmailValidation() {
        viewModel.emailValidation() { response in
            if response.certifiedMentor {
                self.notiBtn.isHidden = true
                self.devideView.snp.removeConstraints()
                self.devideView.snp.makeConstraints {
                    $0.height.equalTo(6)
                    $0.leading.trailing.equalToSuperview()
                    $0.top.equalTo(self.profileBackground.snp.bottom).offset(24)
                }
            }
            self.mentorEmailValid = response.certifiedMentor
        }
    }
    
    private func binding() {
//        profileBtn.rx.tap
//            .bind {
//                self.tabBarController?.tabBar.isHidden = true
//                self.navigationController?.pushViewController(RegistProfileFirstViewController(), animated: true)
//            }
//            .disposed(by: disposeBag)
        let profileTapAction = UITapGestureRecognizer(target: self, action: #selector(profileTapAction(_:)))
        profileBackground.addGestureRecognizer(profileTapAction)
        
        notiBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(RegistMentorFirstViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        accountSettingBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(AccountSettingViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func profileTapAction(_ gesture: UITapGestureRecognizer) {
        if self.mentorEmailValid == false && user == "MENTOR" {
            let popUpViewController = MentorCertifyPopUp()
            let naviVC = UINavigationController(rootViewController: popUpViewController)
            naviVC.modalPresentationStyle = .overCurrentContext
            naviVC.modalTransitionStyle = .crossDissolve
            naviVC.navigationBar.isHidden = true
            self.present(naviVC, animated: true) {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                naviVC.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
            }
        } else if self.mentorEmailValid == true && user == "MENTOR" {
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(RegistProfileFirstViewController(), animated: true)
        } else if user == "MENTEE" {
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(RegistMenteeProfileViewController(), animated: true)
        }
    }
}
