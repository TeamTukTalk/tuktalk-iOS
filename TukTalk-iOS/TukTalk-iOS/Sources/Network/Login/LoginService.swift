//
//  LoginService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import Moya

enum LoginService {
    case login(param: LoginRequest)
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return APIConstants.loginURL
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let loginRequest):
            return .requestJSONEncodable(loginRequest)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        }
    }
}
