//
//  RegistPortfolioFirthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/25.
//

import RxSwift
import RxCocoa

struct RegistPortfolioFirthViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var inputText: AnyObserver<String?>
    }
    
    struct Output {
        var priceEnable: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let inputText$ = BehaviorSubject<String?>(value: nil)
        let priceEnable$ = inputText$.map(priceCheck).asDriver(onErrorJustReturn: false)
        
        self.input = Input(inputText: inputText$.asObserver())
        self.output = Output(priceEnable: priceEnable$)
    }
}

private func priceCheck(priceInput: String?) -> Bool {
    guard let priceInput = priceInput else { return false }
    
    if let price = Int(priceInput) {
        return price > 0 && price <= 100000
    }
    return false
}
