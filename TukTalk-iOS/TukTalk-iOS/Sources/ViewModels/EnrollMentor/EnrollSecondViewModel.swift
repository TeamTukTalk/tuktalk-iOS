//
//  EnrollSecondViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import RxSwift
import RxCocoa

struct EnrollSecondViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
        var email :String?
    }
    
    struct Input {
        var emailText: AnyObserver<String>
    }
    
    struct Output {
        var sendIsValid: Observable<Bool>
    }
    
    init(dependency: Dependency = Dependency(email: nil)) {
        self.dependency = dependency
        
        let emailText$ = BehaviorSubject<String>(value: "")
        let sendIsValid$ = sendValidation(email: emailText$)
        
        self.input = Input(emailText: emailText$.asObserver())
        self.output = Output(sendIsValid: sendIsValid$)
    }
}

private func sendValidation(email: Observable<String>) -> Observable<Bool> {
    return email.asObservable()
        .map { email in
            return email.contains("@") && email.contains(".")
        }
}
