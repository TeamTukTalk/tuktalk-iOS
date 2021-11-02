//
//  EnrollFirstViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/23.
//

import RxSwift

struct EnrollFirstViewModel: ViewModelType {
    
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
        var departmentText: AnyObserver<String>
    }
    
    struct Output {
        var nextIsValid: Observable<Bool>
    }
    
    init(dependency: Dependency = Dependency(company: nil, department: nil)) {
        self.dependency = dependency
        
        let companyText$ = BehaviorSubject<String>(value: "")
        let departmentText$ = BehaviorSubject<String>(value: "")
        let nextIsValid$ = nextValidation(company: companyText$, department: departmentText$)
        
        self.input = Input(companyText: companyText$.asObserver(), departmentText: departmentText$.asObserver())
        self.output = Output(nextIsValid: nextIsValid$)
    }
}

private func nextValidation(company: Observable<String>, department: Observable<String>) -> Observable<Bool> {
    
    return Observable.combineLatest(company, department)
        .map { com, de in
            return !com.isEmpty && !de.isEmpty
        }
}
