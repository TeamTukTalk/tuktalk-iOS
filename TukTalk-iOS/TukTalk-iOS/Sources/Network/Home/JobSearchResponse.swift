//
//  JobSearchResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Foundation

struct JobSearchResponseElement: Codable {
    let mentorID: Int
    let nickname, companyName, department, profileImageURL: String
    let profileImageColor, firstLetter: String
    let hashTags: [HashTag]

    enum CodingKeys: String, CodingKey {
        case mentorID = "mentorId"
        case nickname, companyName, department
        case profileImageURL = "profileImageUrl"
        case profileImageColor, firstLetter, hashTags
    }
}

typealias JobSearchResponse = [JobSearchResponseElement]
