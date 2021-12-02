//
//  HistoryPortfolioService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import Moya

enum HistoryPortfolioService {
    case historyRequest
}

extension HistoryPortfolioService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .historyRequest:
            return APIConstants.historyPortfolioURL
        }
    }
    
    var method: Method {
        switch self {
        case .historyRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .historyRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .historyRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
