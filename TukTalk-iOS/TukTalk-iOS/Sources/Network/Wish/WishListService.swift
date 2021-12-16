//
//  WishListService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import Moya

enum WishListService {
    case wishRequest
}

extension WishListService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .wishRequest:
            return APIConstants.wishURL
        }
    }
    
    var method: Method {
        switch self {
        case .wishRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .wishRequest:
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
