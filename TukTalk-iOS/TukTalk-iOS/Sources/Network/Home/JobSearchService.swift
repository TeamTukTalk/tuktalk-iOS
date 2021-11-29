//
//  jobSearchService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Moya

enum JobSearchService {
    case jobSearchRequest(_ specialty: String? = nil)
}

extension JobSearchService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .jobSearchRequest:
            return APIConstants.jobSearchURL
        }
    }
    
    var method: Method {
        switch self {
        case .jobSearchRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .jobSearchRequest(let specialty):
            let params: [String: String] = ["specialty": specialty!]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .jobSearchRequest:
            return ["Content-Type": "application/json"]
        }
    }
}
