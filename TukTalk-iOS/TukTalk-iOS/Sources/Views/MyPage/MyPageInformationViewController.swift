//
//  InformationViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift

class MyPageInformationViewController: UIViewController {
    
    //MARK:- Properties
    
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let backBtnLabel = UILabel().then {
        $0.text = "기본정보"
        $0.font = UIFont.TTFont(type: .SDBold, size: 16)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "이름(닉네임)"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let nameTextField = UITextField().then {
        let nickname = String(data: KeyChain.load(key: "nickname")!, encoding: .utf8)
        $0.text = nickname
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.setLeftPaddingPoints(16)
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.isEnabled = false
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "이름(닉네임)"
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
    }
    
    private let emailTextField = UITextField().then {
        let email = String(data: KeyChain.load(key: "email")!, encoding: .utf8)
        $0.text = email
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.GrayScale.gray1.cgColor
        $0.layer.cornerRadius = 8
        $0.setLeftPaddingPoints(16)
        $0.textColor = UIColor.GrayScale.sub1
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.isEnabled = false
    }
    
    private let successIcon = UIImageView().then {
        $0.image = UIImage(named: "successIcon")
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
        tabBarController?.tabBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //MARK:- Function
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(backBtnLabel)
        backBtnLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(backBtn)
            $0.leading.equalTo(backBtn.snp.trailing).offset(4)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(backBtnLabel.snp.bottom).offset(34)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        emailTextField.addSubview(successIcon)
        successIcon.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func binding() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
    }
}
