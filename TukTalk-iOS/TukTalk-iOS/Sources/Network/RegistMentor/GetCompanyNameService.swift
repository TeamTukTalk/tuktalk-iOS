//
//  GetCompanyNameService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Moya

enum GetCompanyNameService {
    case companyNameRequest(_ email: String? = nil)
}

extension GetCompanyNameService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .companyNameRequest:
            return APIConstants.companyNameURL
        }
    }
    
    var method: Method {
        switch self {
        case .companyNameRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .companyNameRequest(let email):
            let params: [String: String] = ["email": email!]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .companyNameRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
