//
//  RegistProfileThirdViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/15.
//

import RxSwift
import RxCocoa

struct RegistProfileThirdViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
        var rank: String?
        var year: String?
        var month: String?
    }
    
    struct Input {
        var department: AnyObserver<String?>
        var rankTitle: AnyObserver<String?>
        var inputYear: AnyObserver<String?>
        var inputMonth: AnyObserver<String?>
    }
    
    struct Output {
        var nextBtnEnable: Driver<Bool>
        var monthEnable: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency(rank: nil, year: nil, month: nil)) {
        self.dependency = dependency
        
        let department$ = BehaviorSubject<String?>(value: nil)
        let rankTitle$ = BehaviorSubject<String?>(value: nil)
        let inputYear$ = BehaviorSubject<String?>(value: nil)
        let inputMonth$ = BehaviorSubject<String?>(value: nil)
        let monthEnable$ = inputMonth$.map(monthValidation).asDriver(onErrorJustReturn: false)
        let nextBtnEnable$ = Observable.combineLatest(department$, rankTitle$, inputYear$, inputMonth$).map(btnValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(department: department$.asObserver(), rankTitle: rankTitle$.asObserver(), inputYear: inputYear$.asObserver(), inputMonth: inputMonth$.asObserver())
        self.output = Output(nextBtnEnable: nextBtnEnable$, monthEnable: monthEnable$)
    }
}

private func btnValidation(department: String?, rank: String?, year: String?, month: String?) -> Bool {
    return department?.isEmpty == false && rank?.isEmpty == false && year?.isEmpty == false && month?.isEmpty == false
}

private func monthValidation(month: String?) -> Bool {
    if let mon = Int(month ?? "") {
        return mon > -1 && mon < 12
    }
    return false
}
