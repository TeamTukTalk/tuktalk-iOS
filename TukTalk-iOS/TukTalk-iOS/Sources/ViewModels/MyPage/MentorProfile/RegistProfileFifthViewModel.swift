//
//  RegistProfileFifthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift

struct RegistProfileFifthViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var companySelected: AnyObserver<Bool>
        var hashTagSelected: AnyObserver<Int>
    }
    
    struct Output {
        var nextBtnEnable: Observable<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let companySelected$ = BehaviorSubject<Bool>(value: false)
        let hashTagSelected$ = BehaviorSubject<Int>(value: 0)
        let nextBtnEnable$ = btnValidation(company: companySelected$, hashTag: hashTagSelected$)
        
        self.input = Input(companySelected: companySelected$.asObserver(), hashTagSelected: hashTagSelected$.asObserver())
        self.output = Output(nextBtnEnable: nextBtnEnable$)
    }
}

private func btnValidation(company: Observable<Bool>, hashTag: Observable<Int>) -> Observable<Bool> {
    return Observable.combineLatest(company, hashTag)
        .map { com, tag in
            return com && tag > 0
        }
}
