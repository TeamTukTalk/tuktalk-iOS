//
//  QuerySearchDataModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Moya

enum QuerySearchService {
    case querySearchRequest(param: QuerySearchRequest)
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
        case .querySearchRequest(let param):
            var params = ["query": param.query]
            if param.CompanySize != nil {
                params["companySize"] = param.CompanySize
            }
            if param.subSpecialty != nil {
                params["subSpecialty"] = param.subSpecialty
            }
            if param.startYear != nil {
                params["startYear"] = param.startYear
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .querySearchRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
