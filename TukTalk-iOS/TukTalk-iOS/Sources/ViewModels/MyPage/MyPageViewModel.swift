//
//  MypageViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import RxSwift
import Moya

class MyPageViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    func emailValidation(completion: @escaping (EmailVerifyResponse) -> ()) {
        let provider = MoyaProvider<EmailVerifyService>()
        provider.rx.request(.verifyRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(EmailVerifyResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getUserInfo(completion: @escaping (UserInfoResponse) -> ()) {
        let provider = MoyaProvider<UserInfoService>()
        provider.rx.request(.userInfoRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(UserInfoResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getPortfolioData(id: Int?, completion: @escaping (PortfolioPageResponse) -> ()) {
        let provider = MoyaProvider<PortfolioPageService>()
        provider.rx.request(.portfolioPageRequest(id: id ?? -1))
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
            .disposed(by: self.disposeBag)
    }
    
    func getHistory(completion: @escaping (HistoryPortfolioResponse) -> ()) {
        let provider = MoyaProvider<HistoryPortfolioService>()
        provider.rx.request(.historyRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                    let responseData = try? response.map(HistoryPortfolioResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
