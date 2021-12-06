//
//  RegistProfileFourthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift

struct RegistMentorFourthViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var inputText: AnyObserver<String>
    }
    
    struct Output {
        var textChanged: Observable<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let inputText$ = BehaviorSubject<String>(value: "")
        let textChanged$ = textCheck(text: inputText$)
        
        self.input = Input(inputText: inputText$.asObserver())
        self.output = Output(textChanged: textChanged$)
    }
}

private func textCheck(text: Observable<String>) -> Observable<Bool> {
    return text.map { text in
        if text.count == 0 {
            return false
        } else {
            return true
        }
    }
}
