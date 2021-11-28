//
//  jobSearchService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Moya

enum jobSearchService {
    case jobSearchRequest(_ subSpecialty: String? = nil, _ startYear: Int? = nil, _ endYear: Int? = nil, _ page: Int? = nil, _ companySize: String? = nil, _ specialty: String? = nil)
}

extension jobSearchService: TargetType {
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
        case .jobSearchRequest(let specialty, let subSpecialty, let companySize, let startYear, let endYear, let page):
            let params: [String: Any] = ["specialty": specialty, "subSpecialty": subSpecialty, "companySize": companySize, "startYear": startYear, "endYear": endYear, "page": page]
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
