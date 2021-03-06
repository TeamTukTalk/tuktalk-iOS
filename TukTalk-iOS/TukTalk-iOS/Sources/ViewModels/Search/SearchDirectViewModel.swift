//
//  SearchDirectViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/26.
//

import RxSwift

struct SearchDirectViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var searchText: AnyObserver<String>
    }
    
    struct Output {
        var resultText: Observable<String>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        
        let searchText$ = BehaviorSubject<String>(value: "")
        let resultText$ = searchText$
        
        self.input = Input(searchText: searchText$.asObserver())
        self.output = Output(resultText: resultText$)
    }
}
