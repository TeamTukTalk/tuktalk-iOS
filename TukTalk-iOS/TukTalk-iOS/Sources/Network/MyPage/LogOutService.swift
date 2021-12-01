//
//  LogOutService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Moya

enum LogOutService {
    case logOutRequest
}

extension LogOutService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .logOutRequest:
            return APIConstants.logOutURL
        }
    }
    
    var method: Method {
        switch self {
        case .logOutRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .logOutRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .logOutRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
