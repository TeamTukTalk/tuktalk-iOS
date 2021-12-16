//
//  ReviewUploadService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import Moya

enum ReviewUploadService {
    case reviewUploadRequest(param: ReviewUploadRequest)
}

extension ReviewUploadService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .reviewUploadRequest:
            return APIConstants.reviewUploadURL
        }
    }
    
    var method: Method {
        switch self {
        case .reviewUploadRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .reviewUploadRequest(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .reviewUploadRequest:
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }
    }
}
