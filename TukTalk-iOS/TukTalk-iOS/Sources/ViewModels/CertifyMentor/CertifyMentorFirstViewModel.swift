//
//  EnrollFirstViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import RxSwift
import RxCocoa

struct CertifyMentorFirstViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var companyText: AnyObserver<String?>
    }
    
    struct Output {
        var nextIsValid: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        
        let companyText$ = BehaviorSubject<String?>(value: nil)
        let nextIsValid$ = companyText$.map(nextValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(companyText: companyText$.asObserver())
        self.output = Output(nextIsValid: nextIsValid$)
    }
}

private func nextValidation(company: String?) -> Bool {
    guard let company = company else { return false }
    
    return !company.isEmpty
}
