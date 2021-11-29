//
//  PortfolioService.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Moya

enum PortfolioService {
    case portfolioRequest(Data, fileName: String)
}

extension PortfolioService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .portfolioRequest:
            return APIConstants.portfolioURL
        }
    }
    
    var method: Method {
        switch self {
        case .portfolioRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .portfolioRequest(data, fileName):
            let pdfData = MultipartFormData(provider: .data(data), name: "pdf", fileName: fileName, mimeType: "application/pdf")
            return .uploadMultipart([pdfData])
        }
    }
    
    var headers: [String : String]? {
        guard let token = APIConstants.token else { return nil }
        switch self {
        case .portfolioRequest:
            return [
                "Authorization": token,
                "Content-Type": "multipart/form-data"
            ]
        }
    }
}
