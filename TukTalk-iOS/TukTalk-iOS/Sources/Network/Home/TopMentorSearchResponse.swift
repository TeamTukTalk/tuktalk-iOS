//
//  TopMentorSearchResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Foundation

struct TopMentorSearchResponseElement: Codable {
    let id: Int
    let nickname, companyName, department: String
    let hashTags: [TopMentorHashTag]
}

// MARK: - HashTag
struct TopMentorHashTag: Codable {
    let hashTag: String
}

typealias TopMentorSearchResponse = [TopMentorSearchResponseElement]
