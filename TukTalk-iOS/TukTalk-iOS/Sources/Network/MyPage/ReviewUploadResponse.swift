//
//  ReviewUploadResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import Foundation

struct ReviewUploadResponse: Codable {
    let reviewID: Int
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
    }
}
