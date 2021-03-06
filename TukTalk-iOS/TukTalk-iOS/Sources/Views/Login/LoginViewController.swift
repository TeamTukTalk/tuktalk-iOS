//
//  LoginViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/15.
//

import RxSwift
import RxCocoa
import Moya
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    //MARK:- Properties
    
    private var keyboardFrame: NSValue?
    private let screenHeight = UIScreen.main.bounds.height
    private lazy var viewModel = LoginViewModel()
    private lazy var provider = MoyaProvider<LoginService>()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logoImg")
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "아이디(이메일)"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let errorIcon = UIImageView().then {
        $0.image = UIImage(named: "errorIcon")
        $0.isHidden = true
    }
    
    private let emailErrorMsg = UILabel().then {
        $0.text = "이메일 형식이 유효하지 않습니다."
        $0.textColor = UIColor.State.error
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.isHidden = true
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.isSecureTextEntry = true
        $0.setUnderline(false)
    }
    
    private let loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = UIColor.Primary.primary
        $0.layer.cornerRadius = 26
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
    }
    
//    private let findBtn = UIButton().then {
//        $0.setTitle("아이디 | 비밀번호 찾기", for: .normal)
//        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 13)
//        $0.setTitleColor(UIColor.GrayScale.sub3, for: .normal)
//    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .equalSpacing
    }
    
    private let signUpLabel = UILabel().then {
        $0.text = "아직 뚝딱 회원이 아니신가요?"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let signUpBtn = UIButton().then {
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
    }
    
    private let alertView = UIView().then {
        $0.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 40/255, alpha: 0.7)
        $0.layer.cornerRadius = 8
        $0.alpha = 0
    }
    private let alertLabel = UILabel().then {
        $0.text = "아이디(이메일) 또는 비밀번호가 틀립니다."
        $0.textColor = .white
        $0.font = UIFont.TTFont(type: .SDMed, size: 13)
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setDisappear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardObserver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //MARK:- Functions
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            if UIScreen.main.bounds.height == 667 {
                $0.top.equalToSuperview().offset(180)
            } else {
                $0.top.equalToSuperview().offset(233)
            }
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(logoImageView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        view.addSubview(errorIcon)
        errorIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(emailLabel.snp.bottom).offset(13)
        }
        
        view.addSubview(emailErrorMsg)
        emailErrorMsg.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(46)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(22)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        view.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(signUpLabel)
        bottomStackView.addArrangedSubview(signUpBtn)
        let attribute = NSMutableAttributedString(string: "회원가입")
        attribute.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: 4))
        signUpBtn.setAttributedTitle(attribute, for: .normal)
        bottomStackView.snp.makeConstraints {
            $0.height.equalTo(20)
            if UIScreen.main.bounds.height <= 737 {
                $0.bottom.equalToSuperview().offset(-16)
            } else {
                $0.bottom.equalToSuperview().offset(-42)
            }
            $0.centerX.equalToSuperview()
        }
        
//        view.addSubview(findBtn)
//        findBtn.snp.makeConstraints {
//            $0.top.equalTo(loginBtn.snp.bottom).offset(20)
//            $0.centerX.equalTo(view)
//        }
        
        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(bottomStackView.snp.top).offset(-16)
        }
        
        alertView.addSubview(alertLabel)
        alertLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

    
    private func binding() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.emailText)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.passwordText)
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .bind {
                self.emailTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)

        emailTextField.rx.controlEvent(.editingDidEnd)
            .bind {
                self.emailTextField.setUnderline(false)
                self.viewModel.output.emailIsValid
                    .drive(onNext: { status in
                        self.emailErrorMsg.isHidden = status
                        self.errorIcon.isHidden = status
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .bind {
                self.passwordTextField.setUnderline(true)
            }
            .disposed(by: disposeBag)

        passwordTextField.rx.controlEvent(.editingDidEnd)
            .bind {
                self.passwordTextField.setUnderline(false)
            }
            .disposed(by: disposeBag)
        
        loginBtn.rx.tap
            .bind {
                self.view.endEditing(true)
                
                self.provider.rx.request(.login(param: LoginRequest(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")))
                    .subscribe { result in
                        switch result {
                        case let .success(response):
                            let loginResponse = try? response.map(LoginResponse.self)
                            if response.statusCode == 200 {
                                self.inputKeyChain(loginResponse: loginResponse)
                                self.checkOnboarding()
                            } else {
                                self.loginFailureAlert()
                            }
                        case let .failure(error):
                            self.loginFailureAlert()
                            print(error.localizedDescription)
                        }
                    }
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        signUpBtn.rx.tap
            .bind {
                self.navigationController?.pushViewController(SignUpFirstViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func loginFailureAlert() {
        self.alertView.alpha = 1
        UIView.animate(withDuration: 3, animations: { self.alertView.alpha = 0 })
    }
    
    private func inputKeyChain(loginResponse: LoginResponse?) {
        guard let token = loginResponse?.accessToken else {
            loginFailureAlert()
            return
        }
        let tokenString = "Bearer " + token
        if let role = loginResponse?.role.data(using: String.Encoding.utf8) {
            KeyChain.save(key: "role", data: role)
        }
        if let token = tokenString.data(using: String.Encoding.utf8) {
            KeyChain.save(key: "token", data: token)
        }
        if let name = loginResponse?.nickname.data(using: String.Encoding.utf8) {
            KeyChain.save(key: "nickname", data: name)
        }
        if let firstLetter = loginResponse?.firstLetter.data(using: String.Encoding.utf8) {
            KeyChain.save(key: "firstLetter", data: firstLetter)
        }
        if let profileImageColor = loginResponse?.profileImageColor.data(using: String.Encoding.utf8) {
            KeyChain.save(key: "profileImageColor", data: profileImageColor)
        }
        if let email = loginResponse?.email.data(using: String.Encoding.utf8) {
            KeyChain.save(key: "email", data: email)
        }
    }
    
    private func checkOnboarding() {
        let nextVC = TabBarViewController()
        nextVC.modalPresentationStyle = .fullScreen
        if UserDefaults.standard.bool(forKey: "first") {
            self.present(nextVC, animated: true, completion: nil)
        } else {
            self.navigationController?.pushViewController(FirstOnboardingViewController(), animated: true)
        }
    }
    
    private func setDisappear() {
        [emailTextField, passwordTextField].forEach { $0.text = ""}
        NotificationCenter.default.removeObserver(self)
    }
    
    private func keyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        let loginBtnBottomPosition = loginBtn.frame.origin.y + loginBtn.frame.height
        keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardTopPosition = screenHeight - keyboardFrame!.cgRectValue.height
        if loginBtnBottomPosition < keyboardTopPosition {
            return
        }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y += keyboardTopPosition - loginBtnBottomPosition - 20
        }
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }

}
