//
//  WithdrawService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Moya

enum WithdrawService {
    case withdrawRequest
}

extension WithdrawService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .withdrawRequest:
            return APIConstants.withdrawURL
        }
    }
    
    var method: Method {
        switch self {
        case .withdrawRequest:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .withdrawRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .withdrawRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
