//
//  IntroduceTextFieldViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/13.
//

import RxSwift

struct RegistMentorFirstViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var introduceText: AnyObserver<String>
        var detailText: AnyObserver<String>
        var detailEditingBegin: AnyObserver<Bool>
    }
    
    struct Output {
        var introduceTextCount: Observable<Int>
        var buttonEnable: Observable<Bool>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let introduceText$ = BehaviorSubject<String>(value: "")
        let detailText$ = BehaviorSubject<String>(value: "")
        let detailEditingBegin$ = BehaviorSubject<Bool>(value: false)
        let introduceTextCount$ = checkCount(text: introduceText$)
        let buttonEnable$ = checkEnable(intro: introduceText$, detail: detailText$, begin: detailEditingBegin$)
        
        self.input = Input(introduceText: introduceText$.asObserver(), detailText: detailText$.asObserver(), detailEditingBegin: detailEditingBegin$.asObserver())
        self.output = Output(introduceTextCount: introduceTextCount$, buttonEnable: buttonEnable$)
    }
}

private func checkCount(text: Observable<String>) -> Observable<Int> {
    return text.map { text in
        return text.count
    }
}

private func checkEnable(intro: Observable<String>, detail: Observable<String>, begin: Observable<Bool>) -> Observable<Bool> {
    return Observable.combineLatest(intro, detail, begin)
        .map { intro, detail, begin in
            return intro.count > 0 && detail.count > 0 && begin
        }
}
