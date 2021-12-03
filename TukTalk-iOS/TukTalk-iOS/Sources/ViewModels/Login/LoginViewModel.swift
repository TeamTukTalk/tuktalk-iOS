//
//  LoginViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/15.
//

import RxSwift
import RxCocoa

struct LoginViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var emailText: AnyObserver<String?>
        var passwordText: AnyObserver<String?>
    }
    
    struct Output {
        var emailIsValid: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let emailText$ = BehaviorSubject<String?>(value: nil)
        let passwordText$ = BehaviorSubject<String?>(value: nil)
        let emailIsValid$ = emailText$.map(emailValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(emailText: emailText$.asObserver(), passwordText: passwordText$.asObserver())
        self.output = Output(emailIsValid: emailIsValid$)
    }
}

private func emailValidation(email: String?) -> Bool {
    guard let email = email else { return false }
    return email.contains("@") && email.contains(".")
}
