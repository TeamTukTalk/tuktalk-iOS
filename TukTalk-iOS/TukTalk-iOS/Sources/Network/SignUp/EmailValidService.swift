//
//  EmailValidService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/21.
//

import Moya

enum EmailValidService {
    case emailRequest(_ email: String? = nil)
}

extension EmailValidService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .emailRequest:
            return APIConstants.emailValidURL
        }
    }
    
    var method: Method {
        switch self {
        case .emailRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .emailRequest(let email):
            let params: [String: String] = ["email": email!]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .emailRequest:
            return ["Content-Type": "application/json"]
        }
    }
}
