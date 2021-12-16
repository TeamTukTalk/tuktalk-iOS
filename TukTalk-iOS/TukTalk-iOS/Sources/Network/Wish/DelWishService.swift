//
//  DelWishService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import Moya

enum DelWishService {
    case wishRequest(wishID: Int)
}

extension DelWishService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .wishRequest(let wishId):
            return "\(APIConstants.wishURL)/\(String(wishId))"
        }
    }
    
    var method: Method {
        switch self {
        case .wishRequest:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .wishRequest(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .wishRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
