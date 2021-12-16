//
//  ReviewCollectionViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/09.
//

import RxSwift
import Moya

struct ReviewCollectionViewModel {
    let disposeBag = DisposeBag()
    
    func getReviewRequest(completion: @escaping (ReviewSearchResponse) -> ()) {
        let provider = MoyaProvider<ReviewSearchService>()
        provider.rx.request(.reviewSearchRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    let data = try? response.map(ReviewSearchResponse.self)
                    guard let response = data else { return }
                    completion(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: self.disposeBag)
    }
}
