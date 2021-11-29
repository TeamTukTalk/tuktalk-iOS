//
//  MentorListCollectionViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/31.
//

import RxSwift
import Moya

class MentorListCollectionViewModel {
    static let shared = MentorListCollectionViewModel()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func getTopMentorList(completion: @escaping (TopMentorSearchResponse) -> ()) {
        let provider = MoyaProvider<TopMentorSearchService>()
        provider.rx.request(.topMentorSearchRequest)
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(TopMentorSearchResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getJobMentorList(field: String, completion: @escaping (JobSearchResponse) -> ()) {
        let provider = MoyaProvider<JobSearchService>()
        provider.rx.request(.jobSearchRequest(field))
            .subscribe { result in
                switch result {
                case let .success(response):
                    let responseData = try? response.map(JobSearchResponse.self)
                    guard let data = responseData else { return }
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
