//
//  WithdrawViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift
import RxCocoa
import Moya

final class WithdrawViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var withdrawBtnCheck: Driver<Bool>
    }
    
    var agreeBtnState = BehaviorSubject<Bool>(value: false)
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        
        let withdrawBtnCheck$ = agreeBtnState.map(signUpBtnEnable).asDriver(onErrorJustReturn: false)
        
        self.input = Input()
        self.output = Output(withdrawBtnCheck: withdrawBtnCheck$)
    }
    
    func withdrawRequest() {
        let provider = MoyaProvider<WithdrawService>()
        provider.rx.request(.withdrawRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
}

private func signUpBtnEnable(agreeState: Bool) -> Bool {
    return agreeState
}
