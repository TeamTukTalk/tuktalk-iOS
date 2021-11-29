//
//  PortfolioService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Moya

enum PortfolioService {
    case portfolioRequest(param: PortfolioRequest)
}

extension PortfolioService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .portfolioRequest:
            return APIConstants.portfolioURL
        }
    }
    
    var method: Method {
        switch self {
        case .portfolioRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .portfolioRequest(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .portfolioRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
