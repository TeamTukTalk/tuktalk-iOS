//
//  PortfolioPageViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import RxSwift
import Moya

struct PortfolioPageViewModel {
    private let disposeBag = DisposeBag()
    
    func getPortfolioPage(mentorID: Int, completion: @escaping (PortfolioPageResponse) -> ()) {
        let provider = MoyaProvider<PortfolioPageService>()
        provider.rx.request(.portfolioPageRequest(id: mentorID))
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(PortfolioPageResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
