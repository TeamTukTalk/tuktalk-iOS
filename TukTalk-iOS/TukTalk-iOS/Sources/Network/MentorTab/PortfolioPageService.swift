//
//  PortfolioPageService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Moya

enum PortfolioPageService {
    case portfolioPageRequest(id: Int)
}

extension PortfolioPageService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .portfolioPageRequest:
            return APIConstants.mentorPortfolioURL
        }
    }
    
    var method: Method {
        switch self {
        case .portfolioPageRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .portfolioPageRequest(id):
            let param = ["mentorId" : id]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .portfolioPageRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
