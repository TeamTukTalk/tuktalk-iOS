//
//  RegistMentorService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Moya

enum RegistMentorService {
    case registMentorRequest(param: RegistMentorRequest)
}

extension RegistMentorService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .registMentorRequest:
            return APIConstants.registMentorURL
        }
    }
    
    var method: Method {
        switch self {
        case .registMentorRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .registMentorRequest(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .registMentorRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
