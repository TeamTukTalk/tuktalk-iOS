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
    
//    func getMenteeProfileData(completion: @escaping (MenteeProfileResponse) -> ()) {
//        let provider = MoyaProvider<MenteeProfileService>()
//        provider.rx.request(.menteeProfileRequest)
//            .subscribe { result in
//                switch result {
//                case let .success(response):
//                    let responseData = try? response.map(MenteeProfileResponse.self)
//                    guard let data = responseData else { return }
//                    completion(data)
//                case let .failure(error):
//                    print(error.localizedDescription)
//                }
//            }
//            .disposed(by: disposeBag)
//    }
//
//    func getMentorProfileData(completion: @escaping (MentorProfileResponse) -> ()) {
//        let provider = MoyaProvider<MentorProfileService>()
//        provider.rx.request(.mentorProfileRequest)
//            .subscribe { result in
//                switch result {
//                case let .success(response):
//                    let responseData = try? response.map(MentorProfileResponse.self)
//                    guard let data = responseData else { return }
//                    completion(data)
//                case let .failure(error):
//                    print(error.localizedDescription)
//                }
//            }
//            .disposed(by: disposeBag)
//    }
}
