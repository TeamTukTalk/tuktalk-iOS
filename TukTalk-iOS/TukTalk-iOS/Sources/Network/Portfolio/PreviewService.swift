//
//  PreviewService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import Moya

enum PreviewService {
    case previewRequest([MultipartFormData])
}

extension PreviewService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .previewRequest:
            return APIConstants.previewURL
        }
    }
    
    var method: Method {
        switch self {
        case .previewRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .previewRequest(multiData):
            return .uploadMultipart(multiData)
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .previewRequest:
            return [
                "Authorization": token,
                "Content-Type": "multipart/form-data"
            ]
        }
    }
}
