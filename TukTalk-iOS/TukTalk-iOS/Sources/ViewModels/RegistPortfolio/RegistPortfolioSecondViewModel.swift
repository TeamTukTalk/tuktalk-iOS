//
//  RegistPortfolioSecondViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/24.
//

import RxSwift
import RxCocoa

struct RegistPortfolioSecondViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var projectCountInput: AnyObserver<String?>
        var pageCountInput: AnyObserver<String?>
        var startYearInput: AnyObserver<String?>
        var endYearInput: AnyObserver<String?>
    }
    
    struct Output {
        var nextIsValid: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let projectCountInput$ = BehaviorSubject<String?>(value: nil)
        let pageCountInput$ = BehaviorSubject<String?>(value: nil)
        let startYearInput$ = BehaviorSubject<String?>(value: nil)
        let endYearInput$ = BehaviorSubject<String?>(value: nil)
        
        let nextIsValid$ = Observable.combineLatest(projectCountInput$, pageCountInput$, startYearInput$, endYearInput$).map(nextValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(projectCountInput: projectCountInput$.asObserver(), pageCountInput: pageCountInput$.asObserver(), startYearInput: startYearInput$.asObserver(), endYearInput: endYearInput$.asObserver())
        self.output = Output(nextIsValid: nextIsValid$)
    }
}

private func nextValidation(prjCount: String?, pageCount: String?, start: String?, end: String?) -> Bool {
    
    guard let prjCount = prjCount else { return false }
    guard let pageCount = pageCount else { return false }
    guard let start = start else { return false }
    guard let end = end else { return false }
    
    return prjCount.count > 0 && pageCount.count > 0 && start.count > 0 && end.count > 0
}
