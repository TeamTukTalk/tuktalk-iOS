//
//  QuerySearchDataModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Moya

enum QuerySearchService {
    case querySearchRequest(_ query: String? = nil, _ companySize: String? = nil, _ subSpecialty: String? = nil, _ startYear: Int? = nil, _ page: Int? = nil)
}

extension QuerySearchService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .querySearchRequest:
            return APIConstants.querySearchURL
        }
    }
    
    var method: Method {
        switch self {
        case .querySearchRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .querySearchRequest(let query, let companySize, let subSpecialty, let startYear, let page):
            let params: [String: Any] = ["query": query, "companySize": companySize, "subSpecialty": subSpecialty, "startYear": startYear, "page": page]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .querySearchRequest:
            return ["Content-Type": "application/json"]
        }
    }
}
