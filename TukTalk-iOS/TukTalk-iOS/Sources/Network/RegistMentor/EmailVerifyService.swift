//
//  EmailVerifyService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Moya

enum EmailVerifyService {
    case verifyRequest
}

extension EmailVerifyService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .verifyRequest:
            return APIConstants.emailVerifyURL
        }
    }
    
    var method: Method {
        switch self {
        case .verifyRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .verifyRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .verifyRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
