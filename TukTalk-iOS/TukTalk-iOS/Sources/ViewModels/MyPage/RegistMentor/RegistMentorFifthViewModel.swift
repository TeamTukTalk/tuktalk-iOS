//
//  RegistProfileFifthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/16.
//

import RxSwift
import RxCocoa
import Moya

struct RegistMentorFifthViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency{
    }
    
    struct Input {
        var companySelected: AnyObserver<Bool?>
        var hashTagSelected: AnyObserver<Int?>
    }
    
    struct Output {
        var nextBtnEnable: Driver<Bool>
    }
    var company: String?
    var hashTag: [String] = []
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let companySelected$ = BehaviorSubject<Bool?>(value: nil)
        let hashTagSelected$ = BehaviorSubject<Int?>(value: nil)
        let nextBtnEnable$ = Observable.combineLatest(companySelected$, hashTagSelected$).map(btnValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(companySelected: companySelected$.asObserver(), hashTagSelected: hashTagSelected$.asObserver())
        self.output = Output(nextBtnEnable: nextBtnEnable$)
    }
    
    func registProfile(param: RegistMentorRequest, completion: @escaping (RegistMentorResponse) -> ()) {
        let provider = MoyaProvider<RegistMentorService>()
        provider.rx.request(.registMentorRequest(param: param))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                    let responseData = try? response.map(RegistMentorResponse.self)
                    guard let data = responseData else { return }
                    print(data.mentorId)
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
}

private func btnValidation(company: Bool?, hashTag: Int?) -> Bool {
    guard let company = company else { return false }
    guard let hashTag = hashTag else { return false }
    
    return company && hashTag > 0
}
