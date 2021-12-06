//
//  RegistMenteeService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Moya

enum RegistMenteeService {
    case registMenteeRequest(param: RegistMenteeRequest)
}

extension RegistMenteeService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .registMenteeRequest:
            return APIConstants.registMenteeURL
        }
    }
    
    var method: Method {
        switch self {
        case .registMenteeRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .registMenteeRequest(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .registMenteeRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
