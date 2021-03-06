//
//  SignUpViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/22.
//

import RxSwift
import RxCocoa
import Moya

final class SignUpThirdViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var nicknameInput: AnyObserver<String?>
        var passwordInput: AnyObserver<String?>
        var passwordValidInput: AnyObserver<String?>
    }
    
    struct Output {
        var nicknameCheck: Driver<Bool>
        var passwordCheck: Driver<Bool>
        var passwordConfirmCheck: Driver<Bool>
        var signUpBtnCheck: Driver<Bool>
    }
    
    var agreeBtnState = BehaviorSubject<Bool>(value: false)
    var emailChecked = BehaviorSubject<Bool?>(value: nil)
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let nicknameInput$ = BehaviorSubject<String?>(value: nil)
        let passwordInput$ = BehaviorSubject<String?>(value: nil)
        let passwordConfirmInput$ = BehaviorSubject<String?>(value: nil)
        
        let nicknameCheck$ = nicknameInput$.map(nicknameValidation).asDriver(onErrorJustReturn: false)
        let passwordCheck$ = passwordInput$.map(passwordValidation).asDriver(onErrorJustReturn: false)
        let passwordConfirmCheck$ = Observable.combineLatest(passwordInput$, passwordConfirmInput$).map(passwordConfirmValidation).asDriver(onErrorJustReturn: false)
        let signUpBtnCheck$ = Observable.combineLatest(nicknameInput$, emailChecked, passwordInput$, passwordConfirmInput$, agreeBtnState).map(signUpBtnEnable).asDriver(onErrorJustReturn: false)
        
        self.input = Input(nicknameInput: nicknameInput$.asObserver(), passwordInput: passwordInput$.asObserver(), passwordValidInput: passwordConfirmInput$.asObserver())
        self.output = Output(nicknameCheck: nicknameCheck$, passwordCheck: passwordCheck$, passwordConfirmCheck: passwordConfirmCheck$, signUpBtnCheck: signUpBtnCheck$)
    }
    
    func signUpRequest(param: SignUpRequest) {
        let provider = MoyaProvider<SignUpService>()
        provider.rx.request(.signUp(param: param))
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(SignUpResponse.self)
                    
                    guard let token = responseData?.accessToken else { return }
                    let tokenString = "Bearer " + token
                    if let token = tokenString.data(using: String.Encoding.utf8) {
                        KeyChain.save(key: "token", data: token)
                    }
                    if let role = responseData?.role.data(using: String.Encoding.utf8) {
                        KeyChain.save(key: "role", data: role)
                    }
                    if let name = responseData?.nickname.data(using: String.Encoding.utf8) {
                        KeyChain.save(key: "nickname", data: name)
                    }
                    if let firstLetter = responseData?.firstLetter.data(using: String.Encoding.utf8) {
                        KeyChain.save(key: "firstLetter", data: firstLetter)
                    }
                    if let profileImageColor = responseData?.profileImageColor.data(using: String.Encoding.utf8) {
                        KeyChain.save(key: "profileImageColor", data: profileImageColor)
                    }
                    if let email = responseData?.email.data(using: String.Encoding.utf8) {
                        KeyChain.save(key: "email", data: email)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    func emailValidation(email: String, completion: @escaping (EmailValidResponse) -> ()) {
        let provider = MoyaProvider<EmailValidService>()
        provider.rx.request(.emailRequest(email))
            .subscribe { result in
                switch result {
                case let .success(response):
                    let emailValid = try? response.map(EmailValidResponse.self)
                    guard let response = emailValid else { return }
                    completion(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
    
}

private func nicknameValidation(nickname: String?) -> Bool {
    if let value = nickname?.count {
        return value >= 2
    }
    return false
}

private func passwordValidation(password: String?) -> Bool {
    if let value = password?.count {
        return value >= 8
    }
    return false
}

private func passwordConfirmValidation(password: String?, passwordConfirm: String?) -> Bool {
    return password?.isEmpty == false && passwordConfirm?.isEmpty == false && password == passwordConfirm
}

private func signUpBtnEnable(nickname: String?, email: Bool?, password: String?, passwordConfirm: String?, agreeState: Bool) -> Bool {
    
    guard let nickname = nickname else { return false }
    guard let email = email else { return false }
    guard let password = password else { return false }
    guard let passwordConfirm = passwordConfirm else { return false }
    
    return nickname.count >= 2 && password.count >= 8 && email && passwordConfirm == password && agreeState
}
