//
//  MenteeProfileViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import RxSwift
import RxCocoa
import Moya

struct RegistMenteeViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var inputText: AnyObserver<String?>
    }
    
    struct Output {
        var output: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let inputText$ = BehaviorSubject<String?>(value: nil)
        let output$ = inputText$.map(saveEnableCheck).asDriver(onErrorJustReturn: false)
        
        self.input = Input(inputText: inputText$.asObserver())
        self.output = Output(output: output$)
    }
    
    func signUpRequest(param: RegistMenteeRequest) {
        let provider = MoyaProvider<RegistMenteeService>()
        provider.rx.request(.registMenteeRequest(param: param))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
}

private func saveEnableCheck(input: String?) -> Bool {
    guard let text = input else { return false }
    
    return !text.isEmpty
}
