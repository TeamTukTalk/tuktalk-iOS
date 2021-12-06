//
//  RegistProfileFourthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift
import RxCocoa

struct RegistMentorFourthViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var inputText: AnyObserver<String?>
    }
    
    struct Output {
        var textChanged: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let inputText$ = BehaviorSubject<String?>(value: nil)
        let textChanged$ = inputText$.map(textCheck).asDriver(onErrorJustReturn: false)
        
        self.input = Input(inputText: inputText$.asObserver())
        self.output = Output(textChanged: textChanged$)
    }
}

private func textCheck(text: String?) -> Bool {
    guard let text = text else { return false }
    
    return !text.isEmpty
}
