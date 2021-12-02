//
//  ViewPortfolioService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Moya

enum ViewPortfolioService {
    case viewPortfolio(portfolioId: Int)
}

extension ViewPortfolioService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .viewPortfolio:
            return APIConstants.viewPortfoliioURL
        }
    }
    
    var method: Method {
        switch self {
        case .viewPortfolio:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .viewPortfolio(let portfolioId):
            let param: [String : Any] = ["portfolioId" : portfolioId]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .viewPortfolio:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
