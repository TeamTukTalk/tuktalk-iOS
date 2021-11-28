//
//  ReviewSearchService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Moya

enum ReviewSearchService {
    case reviewSearchRequest
}

extension ReviewSearchService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .reviewSearchRequest:
            return APIConstants.reviewSearchURL
        }
    }
    
    var method: Method {
        switch self {
        case .reviewSearchRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .reviewSearchRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .reviewSearchRequest:
            return ["Content-Type": "application/json"]
        }
    }
}
