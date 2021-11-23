//
//  SignUpService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/19.
//

import Moya

enum SignUpService {
    case signUp(param: SignUpRequest)
}

extension SignUpService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return APIConstants.signUpURL
        }
    }
    
    var method: Method {
        switch self {
        case .signUp:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signUp(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp:
            return ["Content-Type": "application/json"]
        }
    }
}
