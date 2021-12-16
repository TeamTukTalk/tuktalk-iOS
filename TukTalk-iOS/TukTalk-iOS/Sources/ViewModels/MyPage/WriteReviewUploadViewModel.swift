//
//  WriteReviewUploadViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import RxSwift
import RxCocoa

struct WriteReviewUploadViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var textViewInput: AnyObserver<String?>
        var initText: AnyObserver<String?>
    }
    
    struct Output {
        var nextIsValid: Driver<Bool>
    }
    
    var rating: Int = 0
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let textViewInput$ = BehaviorSubject<String?>(value: nil)
        let initText$ = BehaviorSubject<String?>(value: nil)
        let nextIsValid$ = Observable.combineLatest(textViewInput$, initText$).map(nextValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(textViewInput: textViewInput$.asObserver(), initText: initText$.asObserver())
        self.output = Output(nextIsValid: nextIsValid$)
    }
    
    func insertData(text: String?) {
        guard let text = text else { return }
        UserPortfolio.shared.description = text
    }
}

private func nextValidation(text: String?, initText: String?) -> Bool {
    guard let text = text else { return false }
    guard let initText = initText else { return false }
    
    return text != initText && text.count != 0
}
