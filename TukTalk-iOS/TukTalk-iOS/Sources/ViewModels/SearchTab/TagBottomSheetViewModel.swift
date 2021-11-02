//
//  TagBottomSheetViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/29.
//

import RxSwift

struct TagBottomSheetViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
        var text: String?
    }
    
    struct Input {
        var companyTitle: AnyObserver<String>
        var careerTitle: AnyObserver<String>
    }
    
    struct Output {
        var companyText: Observable<String>
        var careerText: Observable<String>
    }
    
    init(dependency: Dependency = Dependency(text: nil)) {
        self.dependency = dependency
        
        let companyTitle$ = BehaviorSubject<String>(value: "")
        let careerTitle$ = BehaviorSubject<String>(value: "")
        
        self.input = Input(companyTitle: companyTitle$.asObserver(), careerTitle: careerTitle$.asObserver())
        self.output = Output(companyText: companyTitle$, careerText: careerTitle$)
    }
}
