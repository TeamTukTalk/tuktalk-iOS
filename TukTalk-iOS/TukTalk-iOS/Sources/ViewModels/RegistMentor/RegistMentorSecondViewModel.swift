//
//  EnrollSecondViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import RxSwift
import Moya

struct RegistMentorSecondViewModel: ViewModelType {
    
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
    
    func sendEmailRequest(email: String) {
        let provider = MoyaProvider<SendEmailService>()
        provider.rx.request(.sendEmailRequest(email))
            .subscribe { result in
                switch result {
                case .success(_):
                    print(result)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    func verifyEmailRequest(completion: @escaping (EmailVerifyResponse) -> ()) {
        let provider = MoyaProvider<EmailVerifyService>()
        provider.rx.request(.verifyRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(EmailVerifyResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
}

private func sendValidation(email: Observable<String>) -> Observable<Bool> {
    return email.asObservable()
        .map { email in
            return email.contains("@") && email.contains(".")
        }
}
