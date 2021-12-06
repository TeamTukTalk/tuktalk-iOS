//
//  IntroduceTextFieldViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/13.
//

import RxSwift
import RxCocoa

struct RegistMentorFirstViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var introduceText: AnyObserver<String?>
        var detailText: AnyObserver<String?>
        var detailEditingBegin: AnyObserver<Bool?>
    }
    
    struct Output {
        var introduceTextCount: Driver<Int>
        var buttonEnable: Driver<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let introduceText$ = BehaviorSubject<String?>(value: nil)
        let detailText$ = BehaviorSubject<String?>(value: nil)
        let detailEditingBegin$ = BehaviorSubject<Bool?>(value: nil)
        let introduceTextCount$ = introduceText$.map(checkCount).asDriver(onErrorJustReturn: 0)
        let buttonEnable$ = Observable.combineLatest(introduceText$, detailText$, detailEditingBegin$).map(checkEnable).asDriver(onErrorJustReturn: false)
        
        self.input = Input(introduceText: introduceText$.asObserver(), detailText: detailText$.asObserver(), detailEditingBegin: detailEditingBegin$.asObserver())
        self.output = Output(introduceTextCount: introduceTextCount$, buttonEnable: buttonEnable$)
    }
}

private func checkCount(text: String?) -> Int {
    guard let text = text else { return 0 }
    
    return text.count
}

private func checkEnable(intro: String?, detail: String?, begin: Bool?) -> Bool {
    guard let intro = intro else { return false}
    guard let detail = detail else { return false}
    guard let begin = begin else { return false}
    
    return intro.count > 0 && detail.count > 0 && begin
}
