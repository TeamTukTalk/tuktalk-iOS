//
//  ReviewUploadRequest.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/17.
//

import Foundation

struct ReviewUploadRequest: Codable {
    let mentorId: Int
    let rating: Int
    let description: String
}
