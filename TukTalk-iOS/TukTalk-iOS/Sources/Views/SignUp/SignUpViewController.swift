//
//  SignUpMentiViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/16.
//

import RxSwift

class SignUpViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var agreeButtonViewModel = AgreeButtonViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.frame.size.height = 24
        $0.frame.size.width = 24
    }
    
    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
        $0.frame.size.height = 20
        $0.frame.size.width = 20
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "딱 이것만 체크하면\n가입완료!"
        $0.font = UIFont.TTFont(type: .SDHeader, size: 20)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 20)
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "이름(닉네임)"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let nameTextField = UITextField().then {
        $0.placeholder = "이름을 입력해주세요."
        $0.borderStyle = UITextField.BorderStyle.none
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "아이디(이메일)"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let emailCheckBtn = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Primary.primary.cgColor
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요."
        $0.borderStyle = UITextField.BorderStyle.none
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "8자 이상으로 입력해주세요."
        $0.borderStyle = UITextField.BorderStyle.none
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let passwordCheckLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let passwordCheckTextField = UITextField().then {
        $0.placeholder = "8자 이상으로 입력해주세요."
        $0.borderStyle = UITextField.BorderStyle.none
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let allAgreeBtn = UIButton().then {
        $0.setTitle("뚝딱 가입 약관에 모두 동의합니다.", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
        $0.setImage(UIImage(named: "allCheckOffImg"), for: .normal)
        $0.setImage(UIImage(named: "allCheckOnImg"), for: .selected)
    }
    
    private let checkBtn = UIButton().then {
        $0.titleLabel?.font = UIFont.TTFont(type: .SFReg, size: 12)
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
    }
    
    private let signUpBtn = UIButton().then {
        $0.setTitle("가입완료", for: .normal)
        $0.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDReg, size: 16)
        $0.backgroundColor = UIColor.GrayScale.gray4
        $0.layer.cornerRadius = 26
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        binding()
    }
    
    //MARK:- Functions
    
    private func setUI() {
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(59)
            $0.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(56)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(247)
            $0.height.equalTo(30)
        }
        
        view.addSubview(emailCheckBtn)
        emailCheckBtn.snp.makeConstraints {
            $0.width.equalTo(84)
            $0.height.equalTo(32)
            $0.bottom.equalTo(emailTextField.snp.bottom)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        view.addSubview(passwordCheckLabel)
        passwordCheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(passwordCheckTextField)
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(passwordCheckLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        view.addSubview(allAgreeBtn)
        allAgreeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        allAgreeBtn.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(checkBtn)
        let attribute = NSMutableAttributedString(string: "확인하기")
        attribute.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: 4))
        checkBtn.setAttributedTitle(attribute, for: .normal)
        checkBtn.snp.makeConstraints {
            $0.top.equalTo(allAgreeBtn.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(79)
        }
        
    }
    
    private func binding() {
        nameTextField.rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                self.nameTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        nameTextField.rx.controlEvent(.editingDidEnd)
            .subscribe { _ in
                self.nameTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                self.emailTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidEnd)
            .subscribe { _ in
                self.emailTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                self.passwordTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidEnd)
            .subscribe { _ in
                self.passwordTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        passwordCheckTextField.rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                self.passwordCheckTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        passwordCheckTextField.rx.controlEvent(.editingDidEnd)
            .subscribe { _ in
                self.passwordCheckTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        allAgreeBtn.rx.tap
            .bind { _ in
                self.agreeButtonViewModel.btnToggle()
                self.agreeButtonViewModel.toggle ? self.allAgreeBtn.setImage(UIImage(named: "allCheckOnImg"), for: .normal) : self.allAgreeBtn.setImage(UIImage(named: "allCheckOffImg"), for: .normal)
            }
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind { _ in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind {_ in
                let popUpViewController = PopUpViewController()
                let naviVC = UINavigationController(rootViewController: popUpViewController)
                naviVC.modalPresentationStyle = .overCurrentContext
                naviVC.modalTransitionStyle = .crossDissolve
                naviVC.navigationBar.isHidden = true
                self.view.endEditing(true)
                self.present(naviVC, animated: true) {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                    naviVC.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
                }
            }
            .disposed(by: disposeBag)
    }
}
