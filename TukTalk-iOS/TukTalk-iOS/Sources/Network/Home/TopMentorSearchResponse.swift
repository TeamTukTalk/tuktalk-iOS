//
//  TopMentorSearchResponse.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import Foundation

struct TopMentorSearchResponse: Codable {
    let id: Int
    let nickname, companyName, department: String
    let hashTags: [TopMentorSearchHashTag]
}

// MARK: - HashTag
struct TopMentorSearchHashTag: Codable {
    let hashTag: String
}
