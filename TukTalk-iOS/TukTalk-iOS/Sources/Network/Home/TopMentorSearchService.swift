//
//  TopMentorSearchService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Moya

enum TopMentorSearchService {
    case topMentorSearchRequest
}

extension TopMentorSearchService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .topMentorSearchRequest:
            return APIConstants.topMentorSearchURL
        }
    }
    
    var method: Method {
        switch self {
        case .topMentorSearchRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .topMentorSearchRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .topMentorSearchRequest:
            return ["Content-Type": "application/json"]
        }
    }
}
