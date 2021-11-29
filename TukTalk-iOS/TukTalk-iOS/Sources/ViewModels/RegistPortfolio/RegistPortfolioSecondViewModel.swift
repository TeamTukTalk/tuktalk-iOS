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
    
    func insertData(projectCount: String?, pageCount: String?, startYear: String?, endYear: String?) {
        guard let projectCount = Int(projectCount!) else { return }
        guard let pageCount = Int(pageCount!) else { return }
        guard let startYear = Int(startYear!) else { return }
        guard let endYear = Int(endYear!) else { return }
        UserPortfolio.shared.projectCount = projectCount
        UserPortfolio.shared.totalPages = pageCount
        UserPortfolio.shared.startYear = startYear
        UserPortfolio.shared.endYear = endYear
    }
}

private func nextValidation(prjCount: String?, pageCount: String?, start: String?, end: String?) -> Bool {
    
    guard let prjCount = prjCount else { return false }
    guard let pageCount = pageCount else { return false }
    guard let start = start else { return false }
    guard let end = end else { return false }
    
    return prjCount.count > 0 && pageCount.count > 0 && start.count > 0 && end.count > 0
}
