//
//  LoginViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/15.
//

import RxSwift

struct LoginViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
        var email :String?
        var password: String?
    }
    
    struct Input {
        var emailText: AnyObserver<String>
        var passwordText: AnyObserver<String>
    }
    
    struct Output {
        var emailIsValid: Observable<Bool>
    }
    
    init(dependency: Dependency = Dependency(email: nil, password: nil)) {
        self.dependency = dependency
        
        let emailText$ = BehaviorSubject<String>(value: "")
        let passwordText$ = BehaviorSubject<String>(value: "")
        let emailIsValid$ = emailValidation(email: emailText$)
        
        self.input = Input(emailText: emailText$.asObserver(), passwordText: passwordText$.asObserver())
        self.output = Output(emailIsValid: emailIsValid$)
    }
}

private func emailValidation(email: Observable<String>) -> Observable<Bool> {
    return email.asObservable()
        .map { email in
            return email.contains("@") && email.contains(".")
        }
}
