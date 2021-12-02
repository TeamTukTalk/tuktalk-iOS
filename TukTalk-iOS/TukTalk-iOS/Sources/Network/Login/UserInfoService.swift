//
//  UserInfoService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Moya

enum UserInfoService {
    case userInfoRequest
}

extension UserInfoService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .userInfoRequest:
            return APIConstants.userInfoURL
        }
    }
    
    var method: Method {
        switch self {
        case .userInfoRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .userInfoRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .userInfoRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
