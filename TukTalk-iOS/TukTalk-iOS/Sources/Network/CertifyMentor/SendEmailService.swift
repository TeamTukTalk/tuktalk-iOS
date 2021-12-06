//
//  SendEmailService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Moya

enum SendEmailService {
    case sendEmailRequest(_ email: String? = nil)
}

extension SendEmailService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .sendEmailRequest:
            return APIConstants.sendEmailURL
        }
    }
    
    var method: Method {
        switch self {
        case .sendEmailRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendEmailRequest(let email):
            let params: [String: String] = ["email": email!]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .sendEmailRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}

