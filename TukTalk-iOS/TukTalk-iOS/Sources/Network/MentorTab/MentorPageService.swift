//
//  MentorPageService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/01.
//

import Moya

enum MentorPageService {
    case mentorPageRequest
}

extension MentorPageService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .mentorPageRequest:
            return APIConstants.mentorPageURL
        }
    }
    
    var method: Method {
        switch self {
        case .mentorPageRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .mentorPageRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .mentorPageRequest:
            return ["Content-Type": "application/json"]
        }
    }
}
