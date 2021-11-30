//
//  MentorProfileService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Moya

enum MentorProfileService {
    case mentorProfileRequest
}

extension MentorProfileService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .mentorProfileRequest:
            return APIConstants.mentorProfileURL
        }
    }
    
    var method: Method {
        switch self {
        case .mentorProfileRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .mentorProfileRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        print(token)
        switch self {
        case .mentorProfileRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
