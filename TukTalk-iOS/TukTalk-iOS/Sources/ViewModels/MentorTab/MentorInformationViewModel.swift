//
//  MentorInformationViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/17.
//

import RxSwift
import Moya

final class MentorInformationViewModel: ViewModelType {
    var dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    var input: Input
    var output: Output
    
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        var pageData: Observable<[PageCollectionViewDataModel]>
    }
    
    var pageList: [PageCollectionViewDataModel] = [
        PageCollectionViewDataModel(title: "멘토정보"),
        PageCollectionViewDataModel(title: "포트폴리오"),
        PageCollectionViewDataModel(title: "후기")
    ]
    
    func getMentorInform(id: Int, completion: @escaping (MentorPageResponse) -> ()) {
        let provider = MoyaProvider<MentorPageService>()
        provider.rx.request(.mentorPageRequest(id: id))
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(MentorPageResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func openPortfolio(id: Int, completion: @escaping (PortfolioPageResponse) -> (), status: @escaping (_ status: Bool) -> ()) {
        let provider = MoyaProvider<PortfolioPageService>()
        provider.rx.request(.portfolioPageRequest(id: id))
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(PortfolioPageResponse.self)
                    status(responseData != nil)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func viewPortfolio(id: Int) {
        let provider = MoyaProvider<ViewPortfolioService>()
        provider.rx.request(.viewPortfolio(portfolioId: id))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func AddWishReqeust(id: Int) {
        let provider = MoyaProvider<AddWishService>()
        provider.rx.request(.wishRequest(mentorID: id))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func DelWishRequest(id: Int) {
        let provider = MoyaProvider<DelWishService>()
        provider.rx.request(.wishRequest(wishID: id))
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func WishListRequest(completion: @escaping (WishListResponse) -> ()) {
        let provider = MoyaProvider<WishListService>()
        provider.rx.request(.wishRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    print(response)
                    let responseData = try? response.map(WishListResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = Dependency()
        let pageData$ = Observable<[PageCollectionViewDataModel]>.just(pageList)
        
        self.input = Input()
        self.output = Output(pageData: pageData$)
    }
}
