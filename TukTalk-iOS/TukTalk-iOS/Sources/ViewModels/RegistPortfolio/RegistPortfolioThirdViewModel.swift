//
//  RegistPortfolioThirdViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/24.
//

import RxSwift
import RxCocoa

struct RegistPortfolioThirdViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var textViewInput: AnyObserver<String?>
        var initText: AnyObserver<String?>
    }
    
    struct Output {
        var nextIsValid: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let textViewInput$ = BehaviorSubject<String?>(value: nil)
        let initText$ = BehaviorSubject<String?>(value: nil)
        let nextIsValid$ = Observable.combineLatest(textViewInput$, initText$).map(nextValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(textViewInput: textViewInput$.asObserver(), initText: initText$.asObserver())
        self.output = Output(nextIsValid: nextIsValid$)
    }
}

private func nextValidation(text: String?, initText: String?) -> Bool {
    guard let text = text else { return false }
    guard let initText = initText else { return false }
    
    return text != initText && text.count != 0
}
