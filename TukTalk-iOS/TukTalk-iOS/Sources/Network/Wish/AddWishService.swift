//
//  WishService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import Moya

enum AddWishService {
    case wishRequest(mentorID: Int)
}

extension AddWishService: TargetType {
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
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .wishRequest(let id):
            let params: [String: String] = ["mentorId": String(id)]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
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
