//
//  WishListViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import RxSwift
import Moya

class WishListViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    func getWishListRequest(status: @escaping (Int) -> (), completion: @escaping (WishListResponse) -> ()) {
        let provider = MoyaProvider<WishListService>()
        provider.rx.request(.wishRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    status(response.statusCode)
                    let responseData = try? response.map(WishListResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
