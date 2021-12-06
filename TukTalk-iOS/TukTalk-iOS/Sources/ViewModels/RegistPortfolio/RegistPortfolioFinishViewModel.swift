//
//  RegistPortfolioFinishViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/06.
//

import RxSwift
import RxCocoa
import Moya

struct RegistPortfolioFinishViewModel {
    private let disposeBag = DisposeBag()
    
    func portfolioRequest(param: PortfolioRequest, completion: @escaping (PortfolioResponse) -> ()) {
        let provider = MoyaProvider<PortfolioService>()
        provider.rx.request(.portfolioRequest(param: param))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                    let responseData = try? response.map(PortfolioResponse.self)
                    guard let data = responseData else { return }
                    print(data)
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
