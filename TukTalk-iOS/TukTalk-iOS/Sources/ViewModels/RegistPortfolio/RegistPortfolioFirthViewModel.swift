//
//  RegistPortfolioFirthViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Moya
import RxSwift

struct RegistPortfolioFirthViewModel {
    var formData: [MultipartFormData] = []
    var imgData = BehaviorSubject(value: [])
    
    func portfolioRequest(param: PortfolioRequest) {
        let provider = MoyaProvider<PortfolioService>()
        provider.rx.request(.portfolioRequest(param: param))
            .subscribe { result in
                switch result {
                case .success(_):
                    print("success Upload")
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: DisposeBag())
    }
}
