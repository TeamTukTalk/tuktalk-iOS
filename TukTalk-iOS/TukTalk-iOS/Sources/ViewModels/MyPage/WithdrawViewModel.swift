//
//  WithdrawViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift
import RxCocoa

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
    
}

private func signUpBtnEnable(agreeState: Bool) -> Bool {
    return agreeState
}
