//
//  EnrollFirstViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import RxSwift

struct RegistMentorFirstViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
        var company :String?
        var department: String?
    }
    
    struct Input {
        var companyText: AnyObserver<String>
    }
    
    struct Output {
        var nextIsValid: Observable<Bool>
    }
    
    init(dependency: Dependency = Dependency(company: nil, department: nil)) {
        self.dependency = dependency
        
        let companyText$ = BehaviorSubject<String>(value: "")
        let nextIsValid$ = nextValidation(company: companyText$)
        
        self.input = Input(companyText: companyText$.asObserver())
        self.output = Output(nextIsValid: nextIsValid$)
    }
}

private func nextValidation(company: Observable<String>) -> Observable<Bool> {
    
    return company.map { text in
        return !text.isEmpty
    }
}
