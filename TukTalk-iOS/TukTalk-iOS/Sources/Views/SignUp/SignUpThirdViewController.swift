//
//  SignUpMentiViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/16.
//

import RxSwift
import Moya

class SignUpThirdViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK:- Properties
    
    private var keyboardFrame: NSValue?
    private let screenHeight = UIScreen.main.bounds.height
    private lazy var viewModel = SignUpThirdViewModel()
    private let provider = MoyaProvider<EmailValidService>()
    private let user = UserSignUp.shared
    private var emailValid: Bool?
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
    
    private let mainScrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let mainContentView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.text = "딱 이것만 체크하면\n가입완료!"
        $0.font = UIFont.TTFont(type: .SDHeader, size: 20)
        $0.textColor = UIColor.GrayScale.normal
        $0.makeHeightSpacing(thisText: $0.text, fontSize: 20)
    }
    
    // Name Area
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
    private let nameErrorLabel = UILabel().then {
        $0.text = "최소 2자 이상으로 적어주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.State.error
        $0.isHidden = true
    }
    private let nameErrorIcon = UIImageView()
    
    // Email Area
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
    private let emailErrorLabel = UILabel().then {
        $0.text = "중복확인을 진행해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.State.error
        $0.isHidden = true
    }
    private let emailErrorIcon = UIImageView()
    
    // Password Area
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let passwordTextField = UITextField().then {
        $0.placeholder = "8자 이상으로 입력해주세요."
        $0.borderStyle = UITextField.BorderStyle.none
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.isSecureTextEntry = true
        $0.setUnderline(false)
    }
    private let passwordErrorLabel = UILabel().then {
        $0.text = "8자 이상으로 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.State.error
        $0.isHidden = true
    }
    private let passwordErrorIcon = UIImageView()
    
    private let passwordCheckLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    private let passwordCheckTextField = UITextField().then {
        $0.placeholder = "8자 이상으로 입력해주세요."
        $0.borderStyle = UITextField.BorderStyle.none
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.isSecureTextEntry = true
        $0.setUnderline(false)
    }
    private let passwordCheckErrorLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.textColor = UIColor.State.error
        $0.isHidden = true
    }
    private let passwordCheckErrorIcon = UIImageView()
    
    private let allAgreeBtn = UIButton().then {
        $0.setTitle("뚝딱 가입 약관에 모두 동의합니다.", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 12)
        $0.setTitleColor(UIColor.GrayScale.sub1, for: .normal)
        $0.setImage(UIImage(named: "allCheckOffImg"), for: .normal)
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
        $0.isEnabled = false
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainScrollView.flashScrollIndicators()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Functions
    
    private func setScrollView() {
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        mainScrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 635)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAction))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.isEnabled = true
        tapGesture.cancelsTouchesInView = false
        mainScrollView.addGestureRecognizer(tapGesture)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            if UIScreen.main.bounds.height <= 736 {
                $0.top.equalToSuperview().offset(39)
            } else {
                $0.top.equalToSuperview().offset(59)
            }
            $0.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            if UIScreen.main.bounds.height <= 736 {
                $0.top.equalToSuperview().offset(36)
            } else {
                $0.top.equalToSuperview().offset(56)
            }
            $0.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            if UIScreen.main.bounds.height <= 736 {
                $0.top.equalTo(backBtn.snp.bottom).offset(10)
            } else {
                $0.top.equalToSuperview().offset(120)
            }
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        mainScrollView.addSubview(mainContentView)
        mainContentView.snp.makeConstraints {
            $0.width.height.equalTo(mainScrollView.contentSize)
            $0.edges.equalTo(mainScrollView.contentSize)
        }
        
        mainContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        mainContentView.addSubview(nameErrorLabel)
        nameErrorLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
            $0.leading.equalTo(nameTextField.snp.leading)
        }
        
        mainContentView.addSubview(nameErrorIcon)
        nameErrorIcon.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalTo(nameLabel.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(247)
            $0.height.equalTo(30)
        }
        
        mainContentView.addSubview(emailErrorLabel)
        emailErrorLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.leading.equalTo(emailTextField.snp.leading)
        }
        
        mainContentView.addSubview(emailCheckBtn)
        emailCheckBtn.snp.makeConstraints {
            $0.width.equalTo(84)
            $0.height.equalTo(32)
            $0.bottom.equalTo(emailTextField.snp.bottom)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(emailErrorIcon)
        emailErrorIcon.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalTo(emailLabel.snp.bottom).offset(13)
            $0.trailing.equalTo(emailCheckBtn.snp.leading).offset(-12)
        }
        
        mainContentView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        mainContentView.addSubview(passwordErrorLabel)
        passwordErrorLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
            $0.leading.equalTo(passwordTextField.snp.leading)
        }
        
        mainContentView.addSubview(passwordErrorIcon)
        passwordErrorIcon.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(passwordCheckLabel)
        passwordCheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(passwordCheckTextField)
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(passwordCheckLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        mainContentView.addSubview(passwordCheckErrorLabel)
        passwordCheckErrorLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(8)
            $0.leading.equalTo(passwordCheckTextField.snp.leading)
        }
        
        mainContentView.addSubview(passwordCheckErrorIcon)
        passwordCheckErrorIcon.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.equalTo(passwordCheckLabel.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(allAgreeBtn)
        allAgreeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        allAgreeBtn.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(passwordCheckErrorLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainContentView.addSubview(checkBtn)
        let attribute = NSMutableAttributedString(string: "확인하기")
        attribute.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: 4))
        checkBtn.setAttributedTitle(attribute, for: .normal)
        checkBtn.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(passwordCheckErrorLabel.snp.bottom).offset(35)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        mainContentView.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(checkBtn.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(16)
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
                self.viewModel.output.nicknameCheck
                    .drive(onNext: { value in
                        switch value {
                        case true:
                            self.nameErrorLabel.isHidden = true
                            self.nameErrorIcon.image = UIImage(named: "successIcon")
                        case false:
                            self.nameErrorLabel.isHidden = false
                            self.nameErrorIcon.image = UIImage(named: "errorIcon")
                        }
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                self.emailTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingChanged)
            .subscribe { _ in
                self.viewModel.emailChecked.onNext(nil)
                self.emailErrorLabel.textColor = UIColor.State.error
                self.emailErrorLabel.isHidden = true
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidEnd)
            .subscribe { _ in
                self.emailTextField.setUnderline(false)
                if self.emailValid == nil {
                    self.emailErrorLabel.text = "중복확인을 진행해주세요."
                    self.emailErrorLabel.isHidden = false
                    self.emailErrorIcon.image = UIImage(named: "errorIcon")
                }
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
                self.viewModel.output.passwordCheck
                    .drive(onNext: { value in
                        self.passwordErrorLabel.isHidden = value
                        self.passwordErrorIcon.image = value ? UIImage(named: "successIcon") : UIImage(named: "errorIcon")
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        passwordCheckTextField.rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                self.passwordCheckTextField.setUnderline(true)
                self.viewModel.output.passwordConfirmCheck
                    .drive(onNext: { value in
                        self.passwordCheckErrorLabel.isHidden = value
                        self.passwordCheckErrorIcon.image = value ? UIImage(named: "successIcon") : UIImage(named: "errorIcon")
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        passwordCheckTextField.rx.controlEvent(.editingDidEnd)
            .subscribe { _ in
                self.passwordCheckTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        nameTextField.rx.text
            .bind(to: viewModel.input.nicknameInput)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .bind(to: viewModel.input.passwordInput)
            .disposed(by: disposeBag)
        
        passwordCheckTextField.rx.text
            .bind(to: viewModel.input.passwordValidInput)
            .disposed(by: disposeBag)
        
        emailCheckBtn.rx.tap
            .bind { _ in
                if let text = self.emailTextField.text {
                    if !text.contains("@") || !text.contains(".") {
                        self.emailErrorLabel.text = "이메일 형식에 맞게 입력해주세요."
                        self.emailErrorLabel.isHidden = false
                        self.emailErrorIcon.image = UIImage(named: "errorIcon")
                        return
                    }
                }
                self.provider.rx.request(.emailRequest(self.emailTextField.text))
                    .subscribe { result in
                        switch result {
                        case let .success(response):
                            let emailValid = try? response.map(EmailValidResponse.self)
                            if let result = emailValid?.existingEmail {
                                switch result {
                                case true:
                                    self.emailErrorLabel.isHidden = false
                                    self.emailErrorLabel.text = "이미 등록된 계정입니다."
                                    self.emailErrorIcon.image = UIImage(named: "errorIcon")
                                    self.viewModel.emailChecked.onNext(false)
                                case false:
                                    self.emailErrorLabel.isHidden = false
                                    self.emailErrorLabel.text = "사용할 수 있는 아이디입니다."
                                    self.emailErrorLabel.textColor = UIColor.GrayScale.sub3
                                    self.emailErrorIcon.image = UIImage(named: "successIcon")
                                    self.viewModel.emailChecked.onNext(true)
                                }
                        }
                        case let .failure(error):
                            print(error.localizedDescription)
                        }
                    }
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        allAgreeBtn.rx.tap
            .scan(false) { state, _ in
                !state
            }
            .bind(onNext: { state in
                self.viewModel.agreeBtnState.onNext(state)
                state ? self.allAgreeBtn.setImage(UIImage(named: "allCheckOnImg"), for: .normal) : self.allAgreeBtn.setImage(UIImage(named: "allCheckOffImg"), for: .normal)
            })
            .disposed(by: disposeBag)
        
        viewModel.emailChecked
            .bind(onNext: { value in
                self.emailValid = value
            })
            .disposed(by: disposeBag)
        
        viewModel.output.signUpBtnCheck
            .drive(onNext: { value in
                switch value {
                case false:
                    self.signUpBtn.setTitleColor(UIColor.GrayScale.sub4, for: .normal)
                    self.signUpBtn.backgroundColor = UIColor.GrayScale.gray4
                    self.signUpBtn.isEnabled = value
                case true:
                    self.signUpBtn.setTitleColor(.white, for: .normal)
                    self.signUpBtn.backgroundColor = UIColor.Primary.primary
                    self.signUpBtn.isEnabled = value
                }
            })
            .disposed(by: disposeBag)
        
        signUpBtn.rx.tap
            .bind { _ in
                self.user.nickname = self.nameTextField.text
                self.user.email = self.emailTextField.text
                self.user.password = self.passwordTextField.text
                self.user.firstLetter = String(self.nameTextField.text!.prefix(1)).uppercased()
                self.user.profileImageColor = self.user.getRandomProfileColor()
                let param = SignUpRequest(subSpecialties: self.user.field, email: self.user.email!, nickname: self.user.nickname!, password: self.user.password!, role: self.user.role!, profileImageColor: self.user.profileImageColor!, firstLetter: self.user.firstLetter!)
                self.viewModel.signUpRequest(param: param)
                self.navigationController?.pushViewController(SignUpFinishViewController(), animated: true)
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
    
    @objc private func didTapAction(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func keyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        if UIResponder.currentFirst() != passwordCheckTextField {
            return
        }
        var passwordCheckBottomPosition = passwordCheckTextField.frame.origin.y + passwordCheckTextField.frame.height
        if UIScreen.main.bounds.height <= 736 {
            passwordCheckBottomPosition += 69
        } else {
            passwordCheckBottomPosition += 120
        }
        keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardTopPosition = screenHeight - keyboardFrame!.cgRectValue.height
        if passwordCheckBottomPosition < keyboardTopPosition {
            return
        }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y += keyboardTopPosition - passwordCheckBottomPosition - 20
        }
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
