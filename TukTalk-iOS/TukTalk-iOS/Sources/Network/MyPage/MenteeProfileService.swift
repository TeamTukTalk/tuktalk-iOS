//
//  MenteeProfileService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Moya

enum MenteeProfileService {
    case menteeProfileRequest
}

extension MenteeProfileService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .menteeProfileRequest:
            return APIConstants.menteeProfileURL
        }
    }
    
    var method: Method {
        switch self {
        case .menteeProfileRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .menteeProfileRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .menteeProfileRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
