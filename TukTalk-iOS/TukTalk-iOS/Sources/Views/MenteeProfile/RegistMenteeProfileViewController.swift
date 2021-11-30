//
//  RegistMenteeProfileViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import RxSwift

class RegistMenteeProfileViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = MenteeProfileViewModel()
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
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.setLeftPaddingPoints(16)
    }
    
    private let saveBtn = UIButton().then {
        $0.backgroundColor = UIColor.Primary.primary
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 26
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setProfileData()
        binding()
    }
    
    //MARK:- Function
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(profileBackground)
        profileBackground.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.top.equalTo(backBtn.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        profileBackground.addSubview(profileLabel)
        profileLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerX.centerY.equalToSuperview()
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(profileBackground.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setProfileData() {
        if let nickname = KeyChain.load(key: "nickname") {
            let name = String(data: nickname, encoding: .utf8)
            self.nameTextField.text = "\(name ?? "")"
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
    
    private func binding() {
        
        nameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.inputText)
            .disposed(by: disposeBag)
        
        viewModel.output.output
            .drive(onNext: { status in
                self.saveBtn.isEnabled = status
                self.saveBtn.backgroundColor = status ? UIColor.Primary.primary : UIColor.GrayScale.gray4
                self.saveBtn.setTitleColor(status ? .white : UIColor.GrayScale.sub4, for: .normal)
            })
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind(onNext: { _ in
                self.navigationController?.viewControllers[0].tabBarController?.tabBar.isHidden = false
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        saveBtn.rx.tap
            .bind { _ in
                KeyChain.delete(key: "nickname")
                KeyChain.delete(key: "firstLetter")
                KeyChain.save(key: "nickname", data: self.nameTextField.text!.data(using: .utf8)!)
                let firstLetter = String(self.nameTextField.text!.prefix(1)).uppercased()
                KeyChain.save(key: "firstLetter", data: firstLetter.data(using: .utf8)!)
                self.viewModel.signUpRequest(param: RegistMenteeRequest(nickname: self.nameTextField.text!))
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
