//
//  RegistProfileFifthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift
import Moya

struct RegistProfileFifthViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var companySelected: AnyObserver<Bool>
        var hashTagSelected: AnyObserver<Int>
    }
    
    struct Output {
        var nextBtnEnable: Observable<Bool>
    }
    var company: String?
    var hashTag: [String] = []
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let companySelected$ = BehaviorSubject<Bool>(value: false)
        let hashTagSelected$ = BehaviorSubject<Int>(value: 0)
        let nextBtnEnable$ = btnValidation(company: companySelected$, hashTag: hashTagSelected$)
        
        self.input = Input(companySelected: companySelected$.asObserver(), hashTagSelected: hashTagSelected$.asObserver())
        self.output = Output(nextBtnEnable: nextBtnEnable$)
    }
    
    func registProfile(param: RegistMentorRequest) {
        let provider = MoyaProvider<RegistMentorService>()
        provider.rx.request(.registMentorRequest(param: param))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
}

private func btnValidation(company: Observable<Bool>, hashTag: Observable<Int>) -> Observable<Bool> {
    return Observable.combineLatest(company, hashTag)
        .map { com, tag in
            return com && tag > 0
        }
}
