//
//  HomeViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/11.
//

import RxSwift

struct HomeViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var indexPath: AnyObserver<IndexPath>
    }
    
    struct Output {
        var indexPathNum: Observable<Int>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let indexPath$ = BehaviorSubject<IndexPath>(value: IndexPath(index: 0))
        let indexPathNum$ = returnNumber(indexPath: indexPath$)
        
        self.input = Input(indexPath: indexPath$.asObserver())
        self.output = Output(indexPathNum: indexPathNum$)
    }
}

private func returnNumber(indexPath: Observable<IndexPath>) -> Observable<Int> {
    return indexPath.map { num in
        guard let result = num.last else { return 0 }
        return result
    }
}
